"""
UNIFIED ITINERARY PLANNER APPLICATION
======================================

A comprehensive itinerary planning system combining:
- Route optimization with Travelling Salesman Problem (TSP) solver
- A* pathfinding for micro-routing
- PostgreSQL database connectivity (optional)
- Flask web application with API endpoints
- Command-line interface for interactive planning
- Meal-based destination optimization

This unified module consolidates all functionality from:
- algorithms.py (TSP solver and A* pathfinding)
- app.py (Flask application)
- cli.py (CLI interface)
- db_module.py (Database integration)
- detailed_routelist.py (Micro-routing)
- routing.py (Route optimization)
- routelist_3.0.py (Route planning)
- utils.py (Utility functions)

Stack:
- Frontend: HTML5/Bootstrap/jQuery
- Backend: Flask + Python
- Data: CSV (selangor_travel_restaurants_2.1.csv) or PostgreSQL (optional)
- Algorithms: Simulated Annealing TSP, A* pathfinding
"""

# ============================================================================
# IMPORTS
# ============================================================================

import csv
import heapq
import itertools
import math
import os
import random
import re
import logging
from functools import lru_cache
from typing import Any, Dict, List, Optional, Tuple, Union

import pandas as pd
from flask import Flask, jsonify, render_template, request
from flask_cors import CORS

# Optional mapping libraries
try:
    import folium
    FOLIUM_AVAILABLE = True
except ImportError:
    FOLIUM_AVAILABLE = False

try:
    import networkx as nx
    NETWORKX_AVAILABLE = True
except ImportError:
    NETWORKX_AVAILABLE = False

try:
    import osmnx as ox
    OSMNX_AVAILABLE = True
except ImportError:
    OSMNX_AVAILABLE = False

try:
    from geopy.distance import geodesic
    GEOPY_AVAILABLE = True
except ImportError:
    GEOPY_AVAILABLE = False

# Optional PostgreSQL support
try:
    import psycopg2
    from psycopg2.extras import RealDictCursor
    POSTGRES_AVAILABLE = True
except ImportError:
    POSTGRES_AVAILABLE = False


# ============================================================================
# CONFIGURATION & TYPE DEFINITIONS
# ============================================================================

CSV_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), "spots.csv")

NodeId = Union[str, int]
RoadGraph = Dict[NodeId, Dict[str, Any]]


# ============================================================================
# DATABASE CONFIGURATION & FUNCTIONS
# ============================================================================

class DatabaseConfig:
    """PostgreSQL connection configuration."""
    
    def __init__(
        self,
        host: str = os.getenv('DB_HOST', 'localhost'),
        port: int = int(os.getenv('DB_PORT', '5432')),
        database: str = os.getenv('DB_NAME', 'itinerary_planner'),
        user: str = os.getenv('DB_USER', 'postgres'),
        password: str = os.getenv('DB_PASSWORD', 'abc123')
    ):
        self.host = host
        self.port = port
        self.database = database
        self.user = user
        self.password = password
    
    def get_connection_string(self) -> str:
        """Generate PostgreSQL connection string."""
        return (
            f"postgresql://{self.user}:{self.password}@"
            f"{self.host}:{self.port}/{self.database}"
        )


def load_spots_from_database(config: Optional[DatabaseConfig] = None) -> List[Dict]:
    """
    Load spots from PostgreSQL database.
    
    Parameters
    ----------
    config : DatabaseConfig, optional
        Database configuration. Uses environment variables if not provided.
        
    Returns
    -------
    list of dict
        List of spot records from database.
        
    Raises
    ------
    ImportError
        If psycopg2 is not installed.
    Exception
        If database connection fails.
    """
    if not POSTGRES_AVAILABLE:
        raise ImportError(
            "psycopg2 is required for PostgreSQL support. "
            "Install with: pip install psycopg2-binary"
        )
    
    if config is None:
        config = DatabaseConfig()
    
    spots = []
    
    try:
        conn = psycopg2.connect(
            host=config.host,
            port=config.port,
            database=config.database,
            user=config.user,
            password=config.password
        )
        
        cursor = conn.cursor(cursor_factory=RealDictCursor)
        
        cursor.execute("""
            SELECT 
                spot_id,
                spot_name,
                spot_description,
                is_restaurant,
                spot_rating,
                location_x,
                location_y,
                meal_type
            FROM public.spots
            ORDER BY spot_id
        """)
        
        rows = cursor.fetchall()
        
        for row in rows:
            spots.append({
                "spot_id": row['spot_id'],
                "spot_name": row['spot_name'],
                "spot_description": row['spot_description'],
                "is_restaurant": row['is_restaurant'],
                "spot_rating": float(row['spot_rating']),
                "location_x": float(row['location_x']),
                "location_y": float(row['location_y']),
                "meal_type": row['meal_type'] or ""
            })
        
        cursor.close()
        conn.close()
        
        print(f"Successfully loaded {len(spots)} spots from PostgreSQL")
        return spots
        
    except psycopg2.Error as e:
        print(f"Database error: {e}")
        raise


def get_spot_by_id(spot_id: int, config: Optional[DatabaseConfig] = None) -> Optional[Dict]:
    """Get a single spot by ID from database."""
    if not POSTGRES_AVAILABLE:
        raise ImportError("psycopg2 is required for PostgreSQL support.")
    
    if config is None:
        config = DatabaseConfig()
    
    try:
        conn = psycopg2.connect(
            host=config.host,
            port=config.port,
            database=config.database,
            user=config.user,
            password=config.password
        )
        
        cursor = conn.cursor(cursor_factory=RealDictCursor)
        cursor.execute("SELECT * FROM public.spots WHERE spot_id = %s", (spot_id,))
        
        row = cursor.fetchone()
        cursor.close()
        conn.close()
        
        if row:
            return {
                "spot_id": row['spot_id'],
                "spot_name": row['spot_name'],
                "spot_description": row['spot_description'],
                "is_restaurant": row['is_restaurant'],
                "spot_rating": float(row['spot_rating']),
                "location_x": float(row['location_x']),
                "location_y": float(row['location_y']),
                "meal_type": row['meal_type'] or ""
            }
        
        return None
        
    except psycopg2.Error as e:
        print(f"Database error: {e}")
        return None


def search_spots_in_database(
    query: str,
    limit: int = 10,
    config: Optional[DatabaseConfig] = None
) -> List[Dict]:
    """Search spots in database by name or description."""
    if not POSTGRES_AVAILABLE:
        raise ImportError("psycopg2 is required for PostgreSQL support.")
    
    if config is None:
        config = DatabaseConfig()
    
    spots = []
    query_lower = query.lower()
    
    try:
        conn = psycopg2.connect(
            host=config.host,
            port=config.port,
            database=config.database,
            user=config.user,
            password=config.password
        )
        
        cursor = conn.cursor(cursor_factory=RealDictCursor)
        
        cursor.execute("""
            SELECT * FROM public.spots
            WHERE LOWER(spot_name) LIKE %s 
               OR LOWER(spot_description) LIKE %s
            ORDER BY spot_rating DESC
            LIMIT %s
        """, (f"%{query_lower}%", f"%{query_lower}%", limit))
        
        rows = cursor.fetchall()
        
        for row in rows:
            spots.append({
                "spot_id": row['spot_id'],
                "spot_name": row['spot_name'],
                "spot_description": row['spot_description'],
                "is_restaurant": row['is_restaurant'],
                "spot_rating": float(row['spot_rating']),
                "location_x": float(row['location_x']),
                "location_y": float(row['location_y']),
                "meal_type": row['meal_type'] or ""
            })
        
        cursor.close()
        conn.close()
        
        return spots
        
    except psycopg2.Error as e:
        print(f"Database error: {e}")
        return []


# ============================================================================
# DATA LOADING & PARSING UTILITIES
# ============================================================================

import os
import osmnx as ox

# Define your local cache filename
CACHE_FILENAME = "selangor_network.graphml"

if os.path.exists(CACHE_FILENAME):
    print("🚀 Cache found! Instantly loading Selangor road network from disk...")
    # This reads the complete graph array in under 2 seconds
    GLOBAL_MAP_GRAPH = ox.load_graphml(CACHE_FILENAME)
else:
    print("⏳ No cache found. Downloading the Selangor road network (this takes a while)...")
    
    # 1. Download the full state network
    GLOBAL_MAP_GRAPH = ox.graph_from_place(
        "Selangor, Malaysia", 
        network_type="drive",
        retain_all=True
    )
    
    # 2. Impute driving attributes
    print("⚙️ Processing edge speeds and travel times...")
    GLOBAL_MAP_GRAPH = ox.add_edge_speeds(GLOBAL_MAP_GRAPH)
    GLOBAL_MAP_GRAPH = ox.add_edge_travel_times(GLOBAL_MAP_GRAPH)
    
    # 3. Save it to disk so you never have to download it online again
    ox.save_graphml(GLOBAL_MAP_GRAPH, filepath=CACHE_FILENAME)
    print(f"✅ Successfully cached Selangor road network to '{CACHE_FILENAME}'!")

def read_dataset_file(file_path):
    """
    Read a CSV file or Excel workbook saved with a .csv name.
    
    Parameters
    ----------
    file_path : str
        Path to the CSV or Excel file.
        
    Returns
    -------
    pd.DataFrame
        DataFrame containing the dataset.
    """
    with open(file_path, "rb") as file:
        file_signature = file.read(4)

    if file_signature.startswith(b"PK"):
        return pd.read_excel(file_path, engine="openpyxl")

    # The project CSV may be saved from Excel with Windows/Latin encoding.
    # Try UTF variants first, then fall back to common legacy encodings.
    last_error = None
    for encoding in ("utf-8", "utf-8-sig", "cp1252", "latin1"):
        try:
            return pd.read_csv(file_path, encoding=encoding)
        except UnicodeDecodeError as exc:
            last_error = exc

    if last_error:
        raise last_error

    return pd.read_csv(file_path)


def convert_to_bool(value):
    """Convert various value types to boolean."""
    if isinstance(value, bool):
        return value

    value = str(value).strip().lower()
    return value in ["true", "1", "yes"]


def load_dataset(csv_path=CSV_PATH):
    """
    Load and validate the spots dataset from CSV.
    
    Parameters
    ----------
    csv_path : str
        Path to the spots CSV file.
        
    Returns
    -------
    pd.DataFrame
        Cleaned and validated DataFrame with required columns.
        
    Raises
    ------
    ValueError
        If required columns are missing.
    """
    df = read_dataset_file(csv_path)

    # Clean column names
    df.columns = (
        df.columns
        .str.strip()
        .str.lower()
        .str.replace(" ", "_")
    )

    required_columns = [
        "spot_id",
        "spot_name",
        "spot_description",
        "is_restaurant",
        "spot_rating",
        "location_x",
        "location_y"
    ]

    for col in required_columns:
        if col not in df.columns:
            raise ValueError(f"Missing column in CSV: {col}")

    if "meal_type" not in df.columns:
        df["meal_type"] = ""

    df["is_restaurant"] = df["is_restaurant"].apply(convert_to_bool)
    df["meal_type"] = (
        df["meal_type"]
        .fillna("")
        .astype(str)
        .str.strip()
        .str.lower()
    )
    df["spot_id"] = df["spot_id"].astype(int)
    df["spot_rating"] = df["spot_rating"].astype(float)
    df["location_x"] = df["location_x"].astype(float)
    df["location_y"] = df["location_y"].astype(float)

    return df


def load_spots_from_csv(csv_path="spots.csv"):
    """Load spots data from CSV for quick in-memory access."""
    spots_db = []
    try:
        with open(csv_path, mode="r", encoding="utf-8") as file:
            reader = csv.DictReader(file)
            for row in reader:
                spots_db.append(
                    {
                        "spot_id": int(row["spot_id"]),
                        "spot_name": row["spot_name"],
                        "spot_description": row["spot_description"],
                        "is_restaurant": row["is_restaurant"] == "True",
                        "spot_rating": float(row["spot_rating"]),
                        "location_x": float(row["location_x"]),
                        "location_y": float(row["location_y"]),
                    }
                )
    except Exception as e:
        print(f"Error loading CSV dataset: {e}")
    return spots_db


def parse_meal_requirements(user_input):
    """
    Parse meal type requirements from user input.
    
    Valid meals: breakfast, lunch, dinner
    
    Parameters
    ----------
    user_input : str
        Comma-separated meal types.
        
    Returns
    -------
    list of str
        List of valid meal types (no duplicates).
    """
    valid_meals = {"breakfast", "lunch", "dinner"}
    meals = []

    for item in str(user_input or "").split(","):
        meal_type = item.strip().lower()
        if meal_type in valid_meals and meal_type not in meals:
            meals.append(meal_type)

    return meals


def restaurant_matches_meal(row, meal_type):
    """
    Check if a restaurant matches a specific meal type requirement.
    
    Parameters
    ----------
    row : pd.Series
        A row from the dataset.
    meal_type : str
        The meal type to check for.
        
    Returns
    -------
    bool
        True if the restaurant serves the requested meal type.
    """
    if not bool(row["is_restaurant"]):
        return False

    requested_meal = str(meal_type).strip().lower()
    if requested_meal not in {"breakfast", "lunch", "dinner"}:
        return False

    meal_value = str(row.get("meal_type", "") or "").strip().lower()
    return re.search(rf"\b{re.escape(requested_meal)}\b", meal_value) is not None


# ============================================================================
# DISTANCE & COORDINATE UTILITIES
# ============================================================================

def euclidean_distance(x1, y1, x2, y2):
    """Calculate Euclidean distance between two points."""
    return math.sqrt((x1 - x2) ** 2 + (y1 - y2) ** 2)


def calculate_distance(x1, y1, x2, y2):
    """
    Calculate Euclidean distance between two points.
    
    Parameters
    ----------
    x1, y1, x2, y2 : float
        Coordinates of the two points.
        
    Returns
    -------
    float
        Euclidean distance between the points.
    """
    return math.sqrt((x1 - x2) ** 2 + (y1 - y2) ** 2)


def get_place_location(df, spot_id):
    """
    Retrieve the (x, y) coordinates for a given spot ID.
    
    Parameters
    ----------
    df : pd.DataFrame
        Dataset containing spot information.
    spot_id : int
        The spot ID to look up.
        
    Returns
    -------
    tuple of float or None
        (location_x, location_y) if found, None otherwise.
    """
    row_df = df[df["spot_id"] == spot_id]

    if row_df.empty:
        return None

    row = row_df.iloc[0]
    return float(row["location_x"]), float(row["location_y"])


def resolve_place_name(df, user_text):
    """
    Convert user's place name input into internal spot_id.
    
    Supports exact matching and partial name matching.
    If multiple partial matches exist, returns the one with highest rating.
    
    Parameters
    ----------
    df : pd.DataFrame
        Dataset containing spot information.
    user_text : str
        Place name input by user.
        
    Returns
    -------
    int or None
        spot_id if found, None otherwise.
    """
    user_text = str(user_text).strip().lstrip("\ufeff")

    if user_text == "":
        return None

    lower_text = user_text.lower()

    # Exact name match
    exact_match = df[df["spot_name"].str.lower() == lower_text]

    if not exact_match.empty:
        return int(exact_match.iloc[0]["spot_id"])

    # Partial name match
    partial_match = df[
        df["spot_name"].str.lower().str.contains(lower_text, na=False)
    ].copy()

    if not partial_match.empty:
        # If several places match, choose the one with highest rating
        partial_match = partial_match.sort_values(
            by="spot_rating",
            ascending=False
        )

        matched_row = partial_match.iloc[0]

        print(f"Matched '{user_text}' to '{matched_row['spot_name']}'")

        return int(matched_row["spot_id"])

    print(f"Warning: Cannot find place name: {user_text}")
    return None


# ============================================================================
# ROUTE PLANNING UTILITIES
# ============================================================================

def get_destination_list(destination_ids, csv_path=CSV_PATH):
    """
    Get full destination details for a list of spot IDs.
    
    Parameters
    ----------
    destination_ids : list of int
        List of spot IDs.
    csv_path : str
        Path to the CSV file.
        
    Returns
    -------
    list of dict
        List of destination details.
    """
    df = load_dataset(csv_path)

    destination_list = []

    for spot_id in destination_ids:
        row_df = df[df["spot_id"] == spot_id]

        if row_df.empty:
            continue

        row = row_df.iloc[0]

        destination_list.append({
            "spot_id": int(row["spot_id"]),
            "spot_name": row["spot_name"],
            "spot_description": row["spot_description"],
            "is_restaurant": bool(row["is_restaurant"]),
            "spot_rating": float(row["spot_rating"]),
            "meal_type": row["meal_type"]
        })

    return destination_list


def print_route(route_id_array, csv_path=CSV_PATH):
    """
    Print the names of destinations in the given order.
    
    Parameters
    ----------
    route_id_array : list of int
        List of destination IDs in order.
    csv_path : str
        Path to the CSV file.
    """
    destination_list = get_destination_list(route_id_array, csv_path)
    if not destination_list:
        return

    max_name_len = max(len(spot['spot_name']) for spot in destination_list)

    print("\nVisiting order:")
    for i, spot in enumerate(destination_list, start=1):
        meal_label = ""
        if spot["is_restaurant"] and spot["meal_type"]:
            meal_label = f", Meal: {spot['meal_type']}"

        print(
            f"{i:2d}. {spot['spot_name']:<{max_name_len}} - "
            f"{spot['spot_description']} "
            f"(Rating: {spot['spot_rating']}{meal_label})"
        )


# ============================================================================
# TRAVELLING SALESMAN PROBLEM (TSP) SOLVER
# ============================================================================

def load_city_coords(spot_ids, csv_path):
    """
    Retrieve (spot_id, x, y) for the given spot IDs from the CSV file.
    
    Parameters
    ----------
    spot_ids : list of int
        List of spot IDs to retrieve.
    csv_path : str
        Path to the spots CSV file.
        
    Returns
    -------
    list of tuple
        List of (spot_id, x, y) tuples preserving input order.
        
    Raises
    ------
    ValueError
        If a spot_id is not found in the dataset.
    """
    df = read_dataset_file(csv_path)
    df.columns = df.columns.str.strip().str.lower().str.replace(" ", "_")
    coords = []
    for sid in spot_ids:
        row = df[df["spot_id"] == int(sid)]
        if row.empty:
            raise ValueError(f"spot_id {sid} not found in dataset")
        x = float(row.iloc[0]["location_x"])
        y = float(row.iloc[0]["location_y"])
        coords.append((int(sid), x, y))
    return coords


def route_total_distance(route, cities):
    """
    Compute the total Euclidean distance of a closed tour.
    
    Parameters
    ----------
    route : list of int
        List of indices into the cities list.
    cities : list of tuple
        List of (spot_id, x, y) tuples.
        
    Returns
    -------
    float
        Total distance of the closed tour.
    """
    n = len(route)
    dist = 0.0
    for i in range(n):
        curr = cities[route[i]]
        nxt = cities[route[(i + 1) % n]]
        dist += euclidean_distance(curr[1], curr[2], nxt[1], nxt[2])
    return dist


def simulated_annealing_tsp(cities,
                            initial_temp=1000,
                            cooling_rate=0.995,
                            min_temp=1e-5,
                            iterations_per_temp=100):
    """
    Solve the Travelling Salesman Problem using simulated annealing.
    
    Parameters
    ----------
    cities : list of tuple
        List of (spot_id, x, y) tuples representing cities/spots.
    initial_temp : float, optional
        Starting temperature for annealing (default 1000).
    cooling_rate : float, optional
        Rate at which temperature decreases (default 0.995).
    min_temp : float, optional
        Minimum temperature threshold (default 1e-5).
    iterations_per_temp : int, optional
        Iterations to perform at each temperature (default 100).
        
    Returns
    -------
    list of int
        Optimized order of spot_ids forming the best route found.
    """
    n = len(cities)
    # Initial random permutation
    current_route = list(range(n))
    random.shuffle(current_route)
    current_dist = route_total_distance(current_route, cities)

    best_route = current_route[:]
    best_dist = current_dist

    temp = initial_temp
    while temp > min_temp:
        for _ in range(iterations_per_temp):
            # Generate a neighbour by swapping two cities
            new_route = current_route[:]
            i, j = random.sample(range(n), 2)
            new_route[i], new_route[j] = new_route[j], new_route[i]

            new_dist = route_total_distance(new_route, cities)
            delta = new_dist - current_dist

            # Metropolis acceptance criterion
            if delta < 0 or random.random() < math.exp(-delta / temp):
                current_route = new_route
                current_dist = new_dist
                if current_dist < best_dist:
                    best_route = current_route[:]
                    best_dist = current_dist
        temp *= cooling_rate

    return [cities[idx][0] for idx in best_route]


def get_optimized_destination_order(start_id, destination_ids, csv_path="spots.csv"):
    """
    Optimize the order of destinations using TSP, treating start_id as the origin.
    
    Parameters
    ----------
    start_id : int
        The starting spot ID.
    destination_ids : list of int
        List of destination spot IDs (typically 6 for this application).
    csv_path : str
        Path to the spots CSV file.
        
    Returns
    -------
    list of int
        Optimized order of destination IDs (excluding start_id).
    """
    all_ids = [start_id] + destination_ids
    cities = load_city_coords(all_ids, csv_path)

    # Solve TSP for all points (closed loop)
    full_order = simulated_annealing_tsp(cities)

    # Rotate the loop so that start_id comes first
    idx = full_order.index(start_id)
    rotated = full_order[idx:] + full_order[:idx]

    # Return only the destinations, preserving the optimal order
    return rotated[1:]


def route_planner(route_planning_input, csv_path="spots.csv"):
    """
    Plan the optimal visiting order for a start point and destinations.
    
    Parameters
    ----------
    route_planning_input : dict
        Must contain:
        - "start_id" (int): Starting location
        - "destination_ids" (list of int): Destination locations
    csv_path : str, optional
        Path to spots CSV file.
        
    Returns
    -------
    list of int
        Optimized visiting order [start_id, dest1, dest2, ...].
    """
    start_id = route_planning_input["start_id"]
    dest_ids = route_planning_input["destination_ids"]
    all_ids = [start_id] + dest_ids
    cities = load_city_coords(all_ids, csv_path)
    return simulated_annealing_tsp(cities)


# ============================================================================
# A* PATHFINDING FOR MICRO-ROUTING
# ============================================================================

def _euclidean_distance(x1: float, y1: float, x2: float, y2: float) -> float:
    return math.hypot(x1 - x2, y1 - y2)


def _manhattan_heuristic(node_a: Dict[str, Any], node_b: Dict[str, Any]) -> float:
    return abs(node_a["x"] - node_b["x"]) + abs(node_a["y"] - node_b["y"])


def _extract_node_coords(road_graph: RoadGraph, node_id: NodeId) -> Tuple[float, float]:
    node = road_graph.get(node_id)
    if node is None:
        raise KeyError(f"Node ID not found in road_graph: {node_id}")
    return float(node["x"]), float(node["y"])


def _build_text_instructions(edge_path: List[Dict[str, Any]]) -> List[str]:
    instructions: List[str] = []
    last_street: str = ""
    for edge in edge_path:
        street_name = str(edge.get("street_name", "Unnamed Road")).strip() or "Unnamed Road"
        if street_name == last_street:
            continue
        if street_name.lower().startswith(("continue", "turn", "head", "merge", "exit")):
            instructions.append(street_name)
        else:
            instructions.append(f"Passed {street_name}")
        last_street = street_name
    return instructions


def _reconstruct_path(
    road_graph: RoadGraph,
    start_node_id: NodeId,
    end_node_id: NodeId,
    came_from: Dict[NodeId, NodeId],
    edge_taken: Dict[NodeId, Dict[str, Any]],
) -> Tuple[List[NodeId], List[Dict[str, Any]], float]:
    node_sequence: List[NodeId] = []
    edges: List[Dict[str, Any]] = []
    current = end_node_id

    while current != start_node_id:
        node_sequence.append(current)
        if current not in came_from or current not in edge_taken:
            raise ValueError("Failed to reconstruct path: parent or edge missing.")
        edges.append(edge_taken[current])
        current = came_from[current]

    node_sequence.append(start_node_id)
    node_sequence.reverse()
    edges.reverse()

    total_distance = sum(float(edge.get("distance", 0.0)) for edge in edges)
    return node_sequence, edges, total_distance


def _get_neighbors(road_graph: RoadGraph, node_id: NodeId) -> List[Dict[str, Any]]:
    node = road_graph.get(node_id, {})
    neighbors = node.get("neighbors")
    if neighbors is None:
        return []
    return list(neighbors)


def a_star_micro_routing(
    road_graph: RoadGraph,
    start_node_id: NodeId,
    end_node_id: NodeId,
) -> Dict[str, Any]:
    """
    Find optimal route between two nodes using A* algorithm.
    
    Provides detailed turn-by-turn instructions and coordinate paths.
    Falls back to direct line if no road path exists.
    
    Parameters
    ----------
    road_graph : dict
        Graph structure where each node contains x, y coordinates and neighbors.
    start_node_id : int or str
        ID of the starting node.
    end_node_id : int or str
        ID of the destination node.
        
    Returns
    -------
    dict
        Result with keys:
        - status: "success" or "fail"
        - total_distance: float
        - micro_coordinates: list of [x, y] points
        - text_instructions: list of direction strings
    """
    if start_node_id == end_node_id:
        try:
            start_x, start_y = _extract_node_coords(road_graph, start_node_id)
        except KeyError:
            return {
                "status": "fail",
                "total_distance": 0.0,
                "micro_coordinates": [],
                "text_instructions": ["Invalid start/end node"],
            }
        return {
            "status": "success",
            "total_distance": 0.0,
            "micro_coordinates": [[start_x, start_y]],
            "text_instructions": [],
        }

    if start_node_id not in road_graph or end_node_id not in road_graph:
        return {
            "status": "fail",
            "total_distance": 0.0,
            "micro_coordinates": [],
            "text_instructions": ["Invalid start or end node ID."],
        }

    start_node = road_graph[start_node_id]
    end_node = road_graph[end_node_id]

    open_heap: List[Tuple[float, float, NodeId]] = []
    heapq.heappush(open_heap, (0.0 + _manhattan_heuristic(start_node, end_node), 0.0, start_node_id))

    came_from: Dict[NodeId, NodeId] = {}
    edge_taken: Dict[NodeId, Dict[str, Any]] = {}
    g_score: Dict[NodeId, float] = {start_node_id: 0.0}
    closed_set: set = set()

    while open_heap:
        _, current_g, current = heapq.heappop(open_heap)

        if current in closed_set:
            continue
        if current == end_node_id:
            try:
                node_sequence, edge_sequence, total_distance = _reconstruct_path(
                    road_graph,
                    start_node_id,
                    end_node_id,
                    came_from,
                    edge_taken,
                )
            except ValueError:
                break
            micro_coordinates = []
            for i, node_id in enumerate(node_sequence[:-1]):
                curr_node = road_graph[node_id]
                micro_coordinates.append([float(curr_node["x"]), float(curr_node["y"])])
                
                # Check if the connecting edge has a detailed curve geometry array
                edge = edge_sequence[i]
                if "geometry" in edge and edge["geometry"]:
                    # Inject curved road coordinates between intersections
                    # Expected format: list of [x, y] coordinates
                    micro_coordinates.extend(edge["geometry"])
            
            # Append final destination coordinates
            final_node = road_graph[node_sequence[-1]]
            micro_coordinates.append([float(final_node["x"]), float(final_node["y"])])
            # --------------------------------------

            text_instructions = _build_text_instructions(edge_sequence)
            return {
                "status": "success",
                "total_distance": total_distance,
                "micro_coordinates": micro_coordinates,
                "text_instructions": text_instructions,
            }
        
        closed_set.add(current)
        for edge in _get_neighbors(road_graph, current):
            neighbor = edge.get("to")
            if neighbor is None or neighbor in closed_set:
                continue

            edge_distance = float(edge.get("distance", 0.0))
            tentative_g = current_g + edge_distance

            if tentative_g >= g_score.get(neighbor, float("inf")):
                continue

            g_score[neighbor] = tentative_g
            came_from[neighbor] = current
            edge_taken[neighbor] = edge
            heuristic = _manhattan_heuristic(road_graph[neighbor], end_node)
            f_score = tentative_g + heuristic
            heapq.heappush(open_heap, (f_score, tentative_g, neighbor))

    # Fallback strategy: return direct line if no road path found.
    try:
        start_x, start_y = _extract_node_coords(road_graph, start_node_id)
        end_x, end_y = _extract_node_coords(road_graph, end_node_id)
    except KeyError:
        return {
            "status": "fail",
            "total_distance": 0.0,
            "micro_coordinates": [],
            "text_instructions": ["Unable to compute fallback route."],
        }

    direct_distance = _euclidean_distance(start_x, start_y, end_x, end_y)
    return {
        "status": "success",
        "total_distance": direct_distance,
        "micro_coordinates": [[start_x, start_y], [end_x, end_y]],
        "text_instructions": ["Direct Route (No road data found)"],
    }


# ============================================================================
# ROUTE OPTIMIZATION WITH MEAL SLOTS
# ============================================================================

def calculate_open_path_distance(start_id, ordered_destination_ids, df):
    """
    Calculate total distance for a path (not closed loop).
    
    Parameters
    ----------
    start_id : int
        Starting point ID.
    ordered_destination_ids : list of int
        Destination IDs in order.
    df : pd.DataFrame
        Dataset containing spot locations.
        
    Returns
    -------
    float
        Total distance traveled.
        
    Raises
    ------
    ValueError
        If any spot ID not found in dataset.
    """
    ordered_ids = [int(start_id)] + [
        int(spot_id) for spot_id in ordered_destination_ids
    ]
    locations = {}

    for spot_id in ordered_ids:
        location = get_place_location(df, spot_id)
        if location is None:
            raise ValueError(f"spot_id {spot_id} not found in dataset")
        locations[spot_id] = location

    total_distance = 0.0
    for current_id, next_id in zip(ordered_ids, ordered_ids[1:]):
        current_x, current_y = locations[current_id]
        next_x, next_y = locations[next_id]
        total_distance += calculate_distance(
            current_x,
            current_y,
            next_x,
            next_y
        )

    return total_distance


def find_meal_restaurant_id(destination_ids, meal_type, df, used_ids=None):
    """
    Find a restaurant in destination list that serves a specific meal.
    
    Parameters
    ----------
    destination_ids : list of int
        Available destination IDs.
    meal_type : str
        Meal type to find (breakfast, lunch, or dinner).
    df : pd.DataFrame
        Dataset containing spot information.
    used_ids : set, optional
        Set of already-used IDs to skip.
        
    Returns
    -------
    int or None
        spot_id of matching restaurant, or None if not found.
    """
    used_ids = {int(spot_id) for spot_id in (used_ids or [])}

    for spot_id in destination_ids:
        spot_id = int(spot_id)
        if spot_id in used_ids:
            continue

        row_df = df[df["spot_id"] == spot_id]
        if row_df.empty:
            continue

        if restaurant_matches_meal(row_df.iloc[0], meal_type):
            return int(spot_id)

    return None


def optimize_route_with_meal_slots(
    start_id,
    destination_ids,
    required_meals,
    csv_path=CSV_PATH
):
    """
    Find optimal route with specific meal type destinations at fixed positions.
    
    Uses exhaustive permutation search over flexible slots to minimize distance
    while respecting meal type constraints at designated stops.
    
    Parameters
    ----------
    start_id : int
        Starting point ID.
    destination_ids : list of int
        List of 6 destination IDs.
    required_meals : list of str
        Meal types that must be included.
    csv_path : str, optional
        Path to spots CSV file.
        
    Returns
    -------
    list of int
        Optimized order of 6 destination IDs.
        
    Raises
    ------
    ValueError
        If destination_ids length != 6.
    """
    df = load_dataset(csv_path)
    destination_ids = list(dict.fromkeys(int(item) for item in destination_ids))

    if len(destination_ids) != 6:
        raise ValueError("Route optimization requires exactly 6 destinations.")

    required_meals = parse_meal_requirements(
        ",".join(required_meals or [])
        if not isinstance(required_meals, str)
        else required_meals
    )
    
    # Fixed meal slots in the route
    meal_slots = {
        "breakfast": 0,
        "lunch": 2,
        "dinner": 5
    }
    fixed_slots = {}
    used_ids = set()

    for meal_type in required_meals:
        restaurant_id = find_meal_restaurant_id(
            destination_ids,
            meal_type,
            df,
            used_ids
        )
        if restaurant_id is None:
            print(
                f"Warning: No separate destination can fill the "
                f"{meal_type} meal slot."
            )
            continue

        fixed_slots[meal_slots[meal_type]] = restaurant_id
        used_ids.add(restaurant_id)

    flexible_ids = [
        spot_id for spot_id in destination_ids
        if spot_id not in used_ids
    ]
    flexible_slots = [
        index for index in range(6)
        if index not in fixed_slots
    ]

    best_order = None
    best_distance = float("inf")

    for permutation in itertools.permutations(flexible_ids):
        ordered_ids = [None] * 6

        for slot, spot_id in fixed_slots.items():
            ordered_ids[slot] = spot_id

        for slot, spot_id in zip(flexible_slots, permutation):
            ordered_ids[slot] = spot_id

        distance = calculate_open_path_distance(start_id, ordered_ids, df)
        if distance < best_distance:
            best_distance = distance
            best_order = ordered_ids

    return best_order


# ============================================================================
# DESTINATION EXPANSION
# ============================================================================

def expand_itinerary(
    current_place_id,
    selected_destination_ids,
    total_slots=6,
    csv_path=CSV_PATH,
    required_meals=None
):
    """
    Expand user's selected destinations into a complete destination list.
    
    Handles:
    - Removing duplicates and invalid IDs
    - Meal-based restaurant requirements
    - Proximity-based recommendations
    - Ensuring at least one restaurant if none selected
    - Auto-filling up to `total_slots` destinations
    
    Parameters
    ----------
    current_place_id : int
        User's current place (starting location, not counted as destination).
    selected_destination_ids : list of int
        Places the user wants to visit.
    total_slots : int, optional
        Final number of destinations to output (default 6).
    csv_path : str, optional
        Path to spots CSV file.
    required_meals : list of str, optional
        Meal types that must be represented.
        
    Returns
    -------
    list of int
        Expanded list of destination IDs (length = total_slots).
        
    Raises
    ------
    ValueError
        If current location not found or insufficient unique destinations.
    """
    df = load_dataset(csv_path)
    required_meals = parse_meal_requirements(
        ",".join(required_meals or [])
        if not isinstance(required_meals, str)
        else required_meals
    )

    available_ids = set(df["spot_id"].tolist())

    # Remove duplicate selected destinations
    selected_destination_ids = list(dict.fromkeys(selected_destination_ids))

    # Remove invalid IDs
    selected_destination_ids = [
        spot_id for spot_id in selected_destination_ids
        if spot_id in available_ids
    ]

    # Remove current location from destination list
    selected_destination_ids = [
        spot_id for spot_id in selected_destination_ids
        if spot_id != current_place_id
    ]

    current_location = get_place_location(df, current_place_id)

    if current_location is None:
        raise ValueError("Current place is not found in dataset.")

    current_x, current_y = current_location

    final_ids = selected_destination_ids[:total_slots]
    selected_df = df[df["spot_id"].isin(final_ids)].copy()
    candidate_df = df[
        (~df["spot_id"].isin(final_ids)) &
        (df["spot_id"] != current_place_id)
    ].copy()

    candidate_scores = []

    for _, candidate in candidate_df.iterrows():
        # Distance from candidate to user's current location
        distance_to_current_place = calculate_distance(
            candidate["location_x"],
            candidate["location_y"],
            current_x,
            current_y
        )

        # Distance from candidate to selected destinations
        if not selected_df.empty:
            distances_to_selected = []

            for _, selected in selected_df.iterrows():
                distance = calculate_distance(
                    candidate["location_x"],
                    candidate["location_y"],
                    selected["location_x"],
                    selected["location_y"]
                )
                distances_to_selected.append(distance)

            average_selected_distance = sum(distances_to_selected) / len(distances_to_selected)

            # Weighted distance score
            # 50% depends on current location
            # 50% depends on already selected destinations
            final_distance_score = (
                0.5 * distance_to_current_place +
                0.5 * average_selected_distance
            )

        else:
            # If user selected no destination, recommend near current location
            final_distance_score = distance_to_current_place

        candidate_scores.append({
            "spot_id": int(candidate["spot_id"]),
            "spot_rating": float(candidate["spot_rating"]),
            "is_restaurant": bool(candidate["is_restaurant"]),
            "meal_type": candidate["meal_type"],
            "distance_score": final_distance_score
        })

    # Sort by nearer distance first, then higher rating
    candidate_scores = sorted(
        candidate_scores,
        key=lambda x: (x["distance_score"], -x["spot_rating"])
    )

    needed_slots = total_slots - len(final_ids)

    def meal_is_satisfied(meal_type):
        rows = df[df["spot_id"].isin(final_ids)]
        return any(
            restaurant_matches_meal(row, meal_type)
            for _, row in rows.iterrows()
        )

    def can_remove_without_losing_meals(spot_id, meals_to_keep):
        remaining_ids = [item for item in final_ids if item != spot_id]
        remaining_rows = df[df["spot_id"].isin(remaining_ids)]
        return all(
            any(
                restaurant_matches_meal(row, meal_type)
                for _, row in remaining_rows.iterrows()
            )
            for meal_type in meals_to_keep
        )

    satisfied_meals = []

    for meal_type in required_meals:
        if meal_is_satisfied(meal_type):
            satisfied_meals.append(meal_type)
            continue

        matching_candidate = next(
            (
                candidate for candidate in candidate_scores
                if restaurant_matches_meal(candidate, meal_type)
            ),
            None
        )

        if matching_candidate is None:
            print(f"Warning: No restaurant found for required meal: {meal_type}")
            continue

        if needed_slots <= 0:
            removable_id = next(
                (
                    spot_id for spot_id in reversed(final_ids)
                    if can_remove_without_losing_meals(spot_id, satisfied_meals)
                ),
                None
            )
            if removable_id is None:
                print(f"Warning: Cannot reserve a destination slot for {meal_type}.")
                continue
            final_ids.remove(removable_id)
        else:
            needed_slots -= 1

        final_ids.append(matching_candidate["spot_id"])
        candidate_scores.remove(matching_candidate)
        satisfied_meals.append(meal_type)

    # Business rule:
    # If destination list has no restaurant, add one restaurant.
    selected_dest_df = df[df["spot_id"].isin(final_ids)].copy()
    has_restaurant = selected_dest_df["is_restaurant"].any()

    if not has_restaurant and needed_slots > 0:
        for candidate in candidate_scores:
            if candidate["is_restaurant"]:
                final_ids.append(candidate["spot_id"])
                candidate_scores.remove(candidate)
                needed_slots -= 1
                break

    # Fill remaining destinations with closest/highest rated spots
    for candidate in candidate_scores:
        if needed_slots <= 0:
            break

        if candidate["spot_id"] in final_ids:
            continue

        final_ids.append(candidate["spot_id"])
        needed_slots -= 1

    if len(final_ids) < total_slots:
        raise ValueError(
            f"Not enough unique destinations to create {total_slots} stops. "
            f"Found {len(final_ids)}, need {total_slots}."
        )

    return final_ids[:total_slots]


# ============================================================================
# ROAD NETWORK & MAPPING UTILITIES
# ============================================================================
import osmnx as ox
import networkx as nx

def create_sample_road_network(spots_list):
    """
    Creates a real OSMnx road graph mapping actual roads, using 
    the bounding box around your waypoints.
    """
    if not spots_list or len(spots_list) == 0:
        return {}
    
    # 1. Extract all coordinates to establish map boundaries
    lats = [float(s["location_y"]) for s in spots_list]
    lons = [float(s["location_x"]) for s in spots_list]
    
    # Add a slight padding buffer so border points don't clip outside the map download
    padding = 0.02 
    north, south = max(lats) + padding, min(lats) - padding
    east, west = max(lons) + padding, min(lons) - padding
    
    # 2. Download the real drivable street network
    print(f"Downloading real road network map for bbox: N:{north}, S:{south}, E:{east}, W:{west}...")
    G_raw = ox.graph_from_bbox(bbox=[north, south, east, west], network_type="drive")
    
    # 3. Add edge lengths and travel times 
    G_raw = ox.add_edge_speeds(G_raw)
    G_raw = ox.add_edge_travel_times(G_raw)
    
    # 4. Transform the OSMnx network into the EXACT dictionary format your A* script expects
    road_graph = {}
    
    # Map all actual intersections as nodes
    for node_id, data in G_raw.nodes(data=True):
        road_graph[node_id] = {
            "x": float(data["x"]),  # Longitude
            "y": float(data["y"]),  # Latitude
            "neighbors": []
        }
    
    # Map all real street segments as edges
    for u, v, data in G_raw.edges(data=True):
        # Extract curvature geometry if present, otherwise fall back to raw nodes
        geometry_coords = []
        if "geometry" in data:
            # OSMnx geometry stores points as (x, y). Unpack to matches your micro_coordinates format
            geometry_coords = [[float(pt[0]), float(pt[1])] for pt in data["geometry"].coords]
            
        road_graph[u]["neighbors"].append({
            "to": v,
            "distance": float(data.get("length", 0.0)),
            "street_name": str(data.get("name", "Unnamed Road")),
            "geometry": geometry_coords  # Crucial for rendering road curves!
        })
        
    return road_graph

def _spot_lon_lat(spot: Dict[str, Any]) -> Tuple[float, float]:
    """Return dataset coordinates as longitude, latitude."""
    return float(spot["location_x"]), float(spot["location_y"])


def _spot_lat_lon(spot: Dict[str, Any]) -> List[float]:
    """Return coordinates in Folium/Leaflet order: latitude, longitude."""
    lon, lat = _spot_lon_lat(spot)
    return [lat, lon]


def _haversine_km(lon1: float, lat1: float, lon2: float, lat2: float) -> float:
    """Approximate real-world distance between two lon/lat points in km."""
    radius_km = 6371.0
    phi1 = math.radians(lat1)
    phi2 = math.radians(lat2)
    delta_phi = math.radians(lat2 - lat1)
    delta_lambda = math.radians(lon2 - lon1)

    a = (
        math.sin(delta_phi / 2) ** 2
        + math.cos(phi1) * math.cos(phi2) * math.sin(delta_lambda / 2) ** 2
    )
    return radius_km * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))


def _bearing_degrees(lon1: float, lat1: float, lon2: float, lat2: float) -> float:
    phi1 = math.radians(lat1)
    phi2 = math.radians(lat2)
    delta_lambda = math.radians(lon2 - lon1)

    x = math.sin(delta_lambda) * math.cos(phi2)
    y = (
        math.cos(phi1) * math.sin(phi2)
        - math.sin(phi1) * math.cos(phi2) * math.cos(delta_lambda)
    )
    return (math.degrees(math.atan2(x, y)) + 360) % 360


def _compass_direction(degrees: float) -> str:
    directions = [
        "north", "northeast", "east", "southeast",
        "south", "southwest", "west", "northwest"
    ]
    return directions[int((degrees + 22.5) // 45) % 8]


def _add_bidirectional_geo_edge(
    road_graph: RoadGraph,
    from_id: NodeId,
    to_id: NodeId,
    destination_name: str,
) -> None:
    from_node = road_graph[from_id]
    to_node = road_graph[to_id]
    distance = _haversine_km(
        float(from_node["x"]),
        float(from_node["y"]),
        float(to_node["x"]),
        float(to_node["y"]),
    )

    for source_id, target_id in ((from_id, to_id), (to_id, from_id)):
        source = road_graph[source_id]
        target = road_graph[target_id]
        bearing = _bearing_degrees(
            float(source["x"]),
            float(source["y"]),
            float(target["x"]),
            float(target["y"]),
        )
        direction = _compass_direction(bearing)
        road_graph[source_id]["neighbors"].append({
            "to": target_id,
            "distance": distance,
            "street_name": (
                f"Continue {direction} for {distance:.2f} m "
                f"toward {destination_name}"
            )
        })

import osmnx as ox
import networkx as nx
def build_geographic_segment_graph(from_spot: Dict[str, Any], to_spot: Dict[str, Any]) -> RoadGraph:
    """
    Instantly slices a local coordinate dictionary out of the pre-cached global road map graph.
    """
    from_lon, from_lat = _spot_lon_lat(from_spot)
    to_lon, to_lat = _spot_lon_lat(to_spot)

    # Find the nearest structural network nodes on our pre-loaded map
    u_node = ox.nearest_nodes(GLOBAL_MAP_GRAPH, X=from_lon, Y=from_lat)
    v_node = ox.nearest_nodes(GLOBAL_MAP_GRAPH, X=to_lon, Y=to_lat)

    # Find the shortest structural node path between these points
    import networkx as nx
    try:
        node_path = nx.shortest_path(GLOBAL_MAP_GRAPH, source=u_node, target=v_node, weight='length')
    except nx.NetworkXNoPath:
        # Fallback if nodes cannot find a path
        return {
            "start": {"x": from_lon, "y": from_lat, "neighbors": [{"to": "end", "distance": 1.0, "street_name": "Direct Link"}]},
            "end": {"x": to_lon, "y": to_lat, "neighbors": []}
        }

    # Reconstruct the exact localized road graph format your A* script reads
    road_graph: RoadGraph = {}
    for i in range(len(node_path)):
        node = node_path[i]
        node_data = GLOBAL_MAP_GRAPH.nodes[node]
        road_graph[node] = {
            "x": float(node_data["x"]),
            "y": float(node_data["y"]),
            "neighbors": []
        }

    # Add the connecting edge paths and their curves into your dictionary structure
    for i in range(len(node_path) - 1):
        u, v = node_path[i], node_path[i+1]
        edge_data = GLOBAL_MAP_GRAPH.get_edge_data(u, v)[0] # Extract primary edge attributes
        
        geometry_coords = []
        if "geometry" in edge_data:
            geometry_coords = [[float(pt[0]), float(pt[1])] for pt in edge_data["geometry"].coords]

        road_graph[u]["neighbors"].append({
            "to": v,
            "distance": float(edge_data.get("length", 1.0)),
            "street_name": str(edge_data.get("name", "Unnamed Street")),
            "geometry": geometry_coords
        })

    return road_graph

def build_segment_route(from_spot: Dict[str, Any], to_spot: Dict[str, Any]) -> Dict[str, Any]:
    # 1. This now returns a network populated with thousands of real road nodes
    road_graph = build_geographic_segment_graph(from_spot, to_spot)
    
    from_lon, from_lat = _spot_lon_lat(from_spot)
    to_lon, to_lat = _spot_lon_lat(to_spot)
    
    # 2. Match your spot coordinates to the closest real node keys
    if "start" in road_graph and "end" in road_graph:
        start_node_id = "start"
        end_node_id = "end"
    else:
        # Find closest numerical OSM IDs in the dictionary
        start_node_id = min(road_graph.keys(), key=lambda k: math.hypot(road_graph[k]["x"] - from_lon, road_graph[k]["y"] - from_lat))
        end_node_id = min(road_graph.keys(), key=lambda k: math.hypot(road_graph[k]["x"] - to_lon, road_graph[k]["y"] - to_lat))

    # 3. Call your A* search loop
    route = a_star_micro_routing(road_graph, start_node_id, end_node_id)
    
    coordinates = [[lat, lon] for lon, lat in route.get("micro_coordinates", [])]
    instructions = [f"Start from {from_spot['spot_name']}", *route.get("text_instructions", []), f"Arrive at {to_spot['spot_name']}"]

    return {
        "status": route.get("status", "fail"),
        "total_distance": route.get("total_distance", 0.0),
        "coordinates": coordinates,
        "instructions": instructions,
    }

def render_folium_fullscreen(map_object) -> str:
    """Render Folium as a full iframe document instead of a small repr iframe."""
    html = map_object.get_root().render()
    fullscreen_css = """
    <style>
        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
        .folium-map {
            width: 100% !important;
            height: 100% !important;
        }
    </style>
    """
    return html.replace("</head>", f"{fullscreen_css}</head>")


def generate_folium_map(current_spot, route_spots, zoom_start=12):
    """
    Generate an interactive Folium map with route visualization.
    
    Parameters
    ----------
    current_spot : dict
        Starting location spot object
    route_spots : list of dict
        List of destination spots in order
    zoom_start : int
        Initial zoom level
        
    Returns
    -------
    folium.Map
        Interactive map object
    """
    if not FOLIUM_AVAILABLE:
        raise ImportError("Folium not installed. Install with: pip install folium")
    
    route_points = [current_spot] + route_spots
    all_lat_lon = [_spot_lat_lon(spot) for spot in route_points]
    center_lat = sum(point[0] for point in all_lat_lon) / len(all_lat_lon)
    center_lon = sum(point[1] for point in all_lat_lon) / len(all_lat_lon)
    
    # Create map
    m = folium.Map(
        location=[center_lat, center_lon],
        zoom_start=zoom_start,
        tiles="OpenStreetMap",
    )
    
    # Add current location marker
    folium.Marker(
        location=_spot_lat_lon(current_spot),
        popup=f"<b>START</b><br>{current_spot['spot_name']}<br>Rating: {current_spot.get('spot_rating', 'N/A')}",
        icon=folium.Icon(color='green', icon='play'),
        tooltip=f"START: {current_spot['spot_name']}"
    ).add_to(m)
    
    full_route_coordinates: List[List[float]] = []

    for idx, spot in enumerate(route_spots, 1):
        # Color based on position
        if idx == 1:
            color = 'blue'
        elif idx == len(route_spots):
            color = 'red'
        else:
            color = 'blue'
        
        # Add marker with custom icon
        folium.Marker(
            location=_spot_lat_lon(spot),
            popup=f"<b>{idx}. {spot['spot_name']}</b><br>Rating: {spot.get('spot_rating', 'N/A')}<br>{spot.get('spot_description', '')}",
            icon=folium.Icon(color=color, icon='info-sign'),
            tooltip=f"{idx}. {spot['spot_name']}"
        ).add_to(m)
    
    for leg_index, (from_spot, to_spot) in enumerate(zip(route_points, route_points[1:]), 1):
        segment = build_segment_route(from_spot, to_spot)
        segment_coordinates = segment["coordinates"]
        if not segment_coordinates:
            continue

        if full_route_coordinates and full_route_coordinates[-1] == segment_coordinates[0]:
            full_route_coordinates.extend(segment_coordinates[1:])
        else:
            full_route_coordinates.extend(segment_coordinates)

        midpoint = segment_coordinates[len(segment_coordinates) // 2]
        folium.Marker(
            location=midpoint,
            icon=folium.DivIcon(
                html=(
                    '<div style="font-size: 12px; background: white; '
                    'padding: 2px 6px; border: 1px solid #007aff; '
                    'border-radius: 4px; white-space: nowrap;">'
                    f"Leg {leg_index}: {segment['total_distance']:.2f} m"
                    '</div>'
                )
            ),
            popup=f"Distance: {segment['total_distance']:.2f} m",
        ).add_to(m)

    # Draw route polyline using A* segment output
    folium.PolyLine(
        locations=full_route_coordinates or all_lat_lon,
        color='#007aff',
        weight=5,
        opacity=0.85,
        popup='Optimized Route'
    ).add_to(m)

    m.fit_bounds(all_lat_lon, padding=(30, 30))
    
    return m


# ============================================================================
# FLASK WEB APPLICATION
# ============================================================================

# Initialize Flask app with proper template and static file paths
app = Flask(
    __name__,
    template_folder=os.path.join(os.path.dirname(__file__), 'templates'),
    static_folder=os.path.join(os.path.dirname(__file__), 'static'),
    static_url_path='/static'
)

# Enable CORS for all routes
CORS(app)

# Configuration
app.config['JSON_SORT_KEYS'] = False
app.config['JSONIFY_PRETTYPRINT_REGULAR'] = True

# ============================================================================
# DATA LOADING & APPLICATION STATE
# ============================================================================

# Load spots database from PostgreSQL or use empty list
# Load spots database from CSV for prototype/demo
try:
    df_spots = load_dataset(CSV_PATH)
 
    spots_db = []

    for _, row in df_spots.iterrows():
        spots_db.append({
            "spot_id": int(row["spot_id"]),
            "spot_name": str(row["spot_name"]),
            "spot_description": str(row["spot_description"]),
            "is_restaurant": bool(row["is_restaurant"]),
            "spot_rating": float(row["spot_rating"]),
            "location_x": float(row["location_x"]),
            "location_y": float(row["location_y"]),
            "meal_type": str(row.get("meal_type", "") or "")
        })

    app.logger.info(f"Loaded {len(spots_db)} spots from CSV: {CSV_PATH}")

except Exception as e:
    app.logger.error(f"Failed to load spots from CSV: {e}")
    spots_db = []

# Selection limits:
# - The first selected spot is the start point.
# - The remaining selected spots are itinerary destinations.
MAX_SELECTED_SPOTS = 7
FINAL_DESTINATION_COUNT = 6

# Track user's selected spot IDs (max 7, first spot is the start point)
saved_spot_ids = []

# Track optimized route (after TSP optimization)
optimized_route = []

# Track current location (starting point)
current_location_id = None


# ============================================================================
# FLASK MIDDLEWARE & ERROR HANDLERS
# ============================================================================

@app.after_request
def add_header(response):
    """
    Add security and cache control headers to all responses.
    
    Prevents caching of API responses while allowing static files to be cached.
    """
    # Prevent caching of API responses
    if request.path.startswith('/api/'):
        response.headers["Cache-Control"] = (
            "no-store, no-cache, must-revalidate, max-age=0"
        )
        response.headers["Pragma"] = "no-cache"
        response.headers["Expires"] = "0"
    # Allow caching of static files
    elif request.path.startswith('/static/'):
        response.headers["Cache-Control"] = "public, max-age=3600"
    
    # Security headers
    response.headers["X-Content-Type-Options"] = "nosniff"
    response.headers["X-Frame-Options"] = "SAMEORIGIN"
    response.headers["X-XSS-Protection"] = "1; mode=block"
    
    return response


@app.before_request
def log_request():
    """Log incoming requests for debugging."""
    app.logger.debug(f"{request.method} {request.path}")


@app.errorhandler(404)
def not_found(error):
    """Handle 404 errors gracefully."""
    return jsonify({"error": "Resource not found"}), 404


@app.errorhandler(500)
def internal_error(error):
    """Handle 500 errors gracefully."""
    app.logger.error(f"Internal server error: {error}")
    return jsonify({"error": "Internal server error"}), 500


# ============================================================================
# PAGE ROUTES
# ============================================================================

@app.route("/", methods=["GET"])
def home():
    """
    Home page - Spot browsing and selection UI.
    
    Renders UI1.html which provides:
    - Paginated spot recommendations
    - Search functionality
    - Spot selection interface (max 7 spots; first spot is the start point)
    - Shopping cart style selection display
    """
    return render_template("UI1.html")


@app.route("/schedule", methods=["GET"])
def schedule_page():
    """
    Schedule/Itinerary page - Displays selected spots on a map.
    
    Renders UI2.html which provides:
    - Overview map with selected destinations in optimized order
    - Itinerary list with spot details numbered 1-6
    - Route visualization with connecting lines
    - Interactive detail view (zoom to specific legs)
    - Click on spot to show detailed route to next destination
    """
    if not optimized_route or not current_location_id:
        # Return error if route not yet optimized
        return render_template("UI2.html", 
                              spots=[], 
                              error="Route not yet planned. Please complete selection first.",
                              optimized_route=[],
                              current_location=None)
    
    try:
        # Get current location
        current_spot = next(
            (item for item in spots_db if item["spot_id"] == current_location_id),
            None
        )
        
        # Get all route spots in optimized order
        ordered_itinerary = []
        for idx, target_id in enumerate(optimized_route, 1):
            match = next(
                (item for item in spots_db if item["spot_id"] == target_id), None
            )
            if match:
                match['order'] = idx
                ordered_itinerary.append(match)

        return render_template(
            "UI2.html",
            spots=ordered_itinerary,
            current_location=current_spot,
            optimized_route=optimized_route,
            error=None
        )
    
    except Exception as e:
        app.logger.error(f"Error loading schedule page: {e}")
        return render_template("UI2.html",
                              spots=[],
                              error=f"Error loading route: {str(e)}",
                              optimized_route=[],
                              current_location=None)


@app.route("/api/health", methods=["GET"])
def health_check():
    """
    Health check endpoint - Used for monitoring and debugging.
    
    Returns:
        JSON with system status and configuration info.
    """
    return jsonify({
        "status": "healthy",
        "database_loaded": len(spots_db) > 0,
        "spots_count": len(spots_db),
        "selected_spots": len(saved_spot_ids)
    })


# ============================================================================
# API ENDPOINTS - SPOT RECOMMENDATIONS
# ============================================================================

@app.route("/api/recommendations", methods=["GET"])
def get_recommendations():
    """
    Get paginated spot recommendations.
    
    Used by UI1 to display browsable spot list in pages of 5.
    Location data is excluded for security (coordinates reserved for saved spots).
    
    Query Parameters:
        page (int): Page number (1-indexed, default 1)
        
    Response Format:
        {
            "spots": [...],
            "has_next": bool
        }
    """
    page = request.args.get("page", default=1, type=int)
    per_page = 5

    start_idx = (page - 1) * per_page
    end_idx = start_idx + per_page

    paginated_slice = spots_db[start_idx:end_idx]
    has_next = end_idx < len(spots_db)

    # Filter out location data to protect recommendation pipeline
    secure_slice = [
        {
            "spot_id": item["spot_id"],
            "spot_name": item["spot_name"],
            "spot_description": item["spot_description"],
            "spot_rating": item["spot_rating"]
        }
        for item in paginated_slice
    ]
    return jsonify({"spots": secure_slice, "has_next": has_next})


@app.route("/api/search", methods=["GET"])
def search_spots():
    """
    Search spots by name or description (UI1 search bar).
    
    Performs real-time case-insensitive substring matching.
    Returns top 3 results sorted by rating (quality filtering).
    
    Query Parameters:
        q (str): Search query (default empty string)
        
    Response Format:
        List of matching spots (max 3)
    """
    query = request.args.get("q", default="", type=str).strip().lower()

    # Return empty collection if search is cleared
    if not query:
        return jsonify([])

    matches = []
    for spot in spots_db:
        # Case-insensitive substring match on name and description
        if query in spot["spot_name"].lower() or query in spot["spot_description"].lower():
            matches.append({
                "spot_id": spot["spot_id"],
                "spot_name": spot["spot_name"],
                "spot_description": spot["spot_description"],
                "spot_rating": spot["spot_rating"]
            })

    # Sort: highest rating first, then name alphabetically
    matches.sort(key=lambda x: (-x["spot_rating"], x["spot_name"]))

    # Return only top 3 items to keep UI responsive
    return jsonify(matches[:3])


# ============================================================================
# API ENDPOINTS - SPOT SELECTION MANAGEMENT
# ============================================================================

@app.route("/api/spots", methods=["GET"])
def get_saved_spots():
    """
    Get user's currently selected spots with full details including coordinates.
    
    Returns all selected spots (max 7). The first selected spot is the start point.
    Used by UI1 to display the selection list and by UI2 for map rendering.
    
    Response Format:
        List of spot objects with full details
    """
    selected_objects = [
        item for item in spots_db if item["spot_id"] in saved_spot_ids
    ]
    return jsonify(selected_objects)


@app.route("/api/spots", methods=["POST"])
def add_spot_by_id():
    """
    Add a spot to the user's selection (UI1 "Add" button).
    
    Validates selection limit (max 7 spots; first is the start point) and prevents duplicates.
    
    Request Format:
        POST /api/spots
        {"spot_id": int}
        
    Error Responses:
        400 Bad Request: No ID specified or max selection reached
    """
    data = request.get_json() or {}
    spot_id = data.get("spot_id")

    if spot_id is None:
        return jsonify({"error": "No ID specified"}), 400
    
    if len(saved_spot_ids) >= MAX_SELECTED_SPOTS:
        return jsonify({
            "error": (
                "Maximum selection reached. The first selected place is the start point, "
                "and the remaining six places are destinations."
            )
        }), 400

    spot_id = int(spot_id)
    if spot_id not in saved_spot_ids:
        saved_spot_ids.append(spot_id)
        app.logger.info(f"Added spot {spot_id} to selection. Total: {len(saved_spot_ids)}")

    return get_saved_spots()


@app.route("/api/spots", methods=["DELETE"])
def remove_spot_by_id():
    """
    Remove a spot from the user's selection (UI1 "Delete" button).
    
    Called when user clicks the "X" or delete button on a selected spot in UI1.
    
    Request Format:
        DELETE /api/spots
        {"spot_id": int}
    """
    data = request.get_json() or {}
    spot_id = data.get("spot_id")

    if spot_id is not None:
        spot_id = int(spot_id)
        if spot_id in saved_spot_ids:
            saved_spot_ids.remove(spot_id)
            app.logger.info(f"Removed spot {spot_id} from selection. Total: {len(saved_spot_ids)}")

    return get_saved_spots()


# ============================================================================
# API ENDPOINTS - WORKFLOW COMPLETION
# ============================================================================

@app.route("/api/complete", methods=["POST"])
def complete_selection():
    """
    Signal completion of spot selection and prepare for route planning.
    
    This is a workflow checkpoint that transitions from UI1 (selection)
    to UI2 (itinerary/map view).
    
    Uses the first selected spot as the start point, auto-fills destination slots
    up to 6 spots, then optimizes the destination route using TSP.
    
    Response Format:
        {
            "status": "success",
            "redirect_url": "/schedule",
            "selected_count": int,
            "optimized_route": [list of 6 spot IDs in order],
            "current_location": int (starting point)
        }
    """
    global optimized_route, current_location_id
    
    if len(saved_spot_ids) == 0:
        return jsonify({"error": "Please select at least one place."}), 400
    
    try:
        # Use first selected spot as current location (or starting point)
        current_location_id = saved_spot_ids[0]

        available_spot_ids = {int(spot["spot_id"]) for spot in spots_db}
        if available_spot_ids and current_location_id not in available_spot_ids:
            return jsonify({"error": "Selected starting spot was not found"}), 400

        selected_destination_ids = [
            int(spot_id)
            for spot_id in saved_spot_ids[1:]
            if int(spot_id) != int(current_location_id)
        ]
        
        # Auto-fill empty slots to reach 6 destinations
        filled_destinations = expand_itinerary(
            current_place_id=current_location_id,
            selected_destination_ids=selected_destination_ids,
            total_slots=FINAL_DESTINATION_COUNT,
            csv_path=CSV_PATH,
            required_meals=[]
        )
        
        # Optimize route using TSP
        optimized_route = get_optimized_destination_order(
            start_id=current_location_id,
            destination_ids=filled_destinations,
            csv_path=CSV_PATH
        )
        
        internal_route_id_array = [current_location_id] + optimized_route
        app.logger.info("Route optimized with start point plus destination stops")
        
        return jsonify({
            "status": "success",
            "redirect_url": "/schedule",
            "selected_count": len(saved_spot_ids),
            "optimized_route": internal_route_id_array[1:],
            "current_location": current_location_id
        })
    
    except Exception as e:
        app.logger.error(f"Error completing selection: {e}")
        return jsonify({"error": str(e)}), 500


# ============================================================================
# API ENDPOINTS - MAP & ROUTE DATA
# ============================================================================

@app.route("/api/route-data", methods=["GET"])
def get_route_data():
    """
    Get complete optimized route data for map visualization.
    
    Returns the full route with all 6 destinations in order.
    Includes coordinates for map rendering.
    
    Response Format:
        {
            "current_location": {spot details},
            "route": [list of 6 spots in optimized order],
            "total_spots": 6,
            "route_order": [list of IDs in order from 1-6]
        }
    """
    if not optimized_route or not current_location_id:
        return jsonify({"error": "Route not yet optimized"}), 400
    
    try:
        # Get current location details
        current_spot = next(
            (item for item in spots_db if item["spot_id"] == current_location_id),
            None
        )
        
        # Get all route spots with their order
        route_spots = []
        for idx, spot_id in enumerate(optimized_route, 1):
            spot = next(
                (item for item in spots_db if item["spot_id"] == spot_id),
                None
            )
            if spot:
                spot['order'] = idx
                route_spots.append(spot)
        
        return jsonify({
            "current_location": current_spot,
            "route": route_spots,
            "total_spots": len(route_spots),
            "route_order": [current_location_id] + optimized_route
        })
    
    except Exception as e:
        app.logger.error(f"Error getting route data: {e}")
        return jsonify({"error": str(e)}), 500


@app.route("/api/segment-route/<int:from_spot_id>/<int:to_spot_id>", methods=["GET"])
def get_segment_route(from_spot_id, to_spot_id):
    """
    Get detailed route between two specific spots using A* algorithm.
    
    This endpoint would use A* if a road network is available.
    For now, returns direct line between spots with coordinates.
    
    Parameters:
        from_spot_id (int): Starting spot ID
        to_spot_id (int): Destination spot ID
    
    Response Format:
        {
            "from_spot": {spot details},
            "to_spot": {spot details},
            "route": {
                "status": "success" or "fail",
                "total_distance": float,
                "coordinates": [[lat, lon], ...],
                "instructions": [list of turn-by-turn directions]
            }
        }
    """
    try:
        from_spot = next(
            (item for item in spots_db if item["spot_id"] == from_spot_id),
            None
        )
        to_spot = next(
            (item for item in spots_db if item["spot_id"] == to_spot_id),
            None
        )
        
        if not from_spot or not to_spot:
            return jsonify({"error": "Spot not found"}), 404
        
        route_data = build_segment_route(from_spot, to_spot)
        
        return jsonify({
            "from_spot": {
                "spot_id": from_spot["spot_id"],
                "spot_name": from_spot["spot_name"],
                "location_x": from_spot["location_x"],
                "location_y": from_spot["location_y"]
            },
            "to_spot": {
                "spot_id": to_spot["spot_id"],
                "spot_name": to_spot["spot_name"],
                "location_x": to_spot["location_x"],
                "location_y": to_spot["location_y"]
            },
            "route": route_data
        })
    
    except Exception as e:
        app.logger.error(f"Error getting segment route: {e}")
        return jsonify({"error": str(e)}), 500


@app.route("/api/segment-map/<int:from_spot_id>/<int:to_spot_id>", methods=["GET"])
def get_segment_map(from_spot_id, to_spot_id):
    """Generate a focused Folium map for one A* route segment."""
    if not FOLIUM_AVAILABLE:
        return jsonify({"error": "Map library not available. Install with: pip install folium"}), 500

    try:
        from_spot = next(
            (item for item in spots_db if item["spot_id"] == from_spot_id),
            None
        )
        to_spot = next(
            (item for item in spots_db if item["spot_id"] == to_spot_id),
            None
        )

        if not from_spot or not to_spot:
            return jsonify({"error": "Spot not found"}), 404

        segment = build_segment_route(from_spot, to_spot)
        coordinates = segment["coordinates"] or [_spot_lat_lon(from_spot), _spot_lat_lon(to_spot)]
        center_lat = sum(point[0] for point in coordinates) / len(coordinates)
        center_lon = sum(point[1] for point in coordinates) / len(coordinates)

        m = folium.Map(
            location=[center_lat, center_lon],
            zoom_start=13,
            tiles="OpenStreetMap",
        )
        folium.Marker(
            location=_spot_lat_lon(from_spot),
            popup=f"<b>From</b><br>{from_spot['spot_name']}",
            icon=folium.Icon(color="green", icon="play"),
            tooltip=f"From: {from_spot['spot_name']}",
        ).add_to(m)
        folium.Marker(
            location=_spot_lat_lon(to_spot),
            popup=f"<b>To</b><br>{to_spot['spot_name']}",
            icon=folium.Icon(color="red", icon="flag"),
            tooltip=f"To: {to_spot['spot_name']}",
        ).add_to(m)
        folium.PolyLine(
            locations=coordinates,
            color="#ff9500",
            weight=6,
            opacity=0.9,
            popup=f"A* segment: {segment['total_distance']:.2f} m",
        ).add_to(m)

        for idx, point in enumerate(coordinates[1:-1], 1):
            folium.CircleMarker(
                location=point,
                radius=5,
                color="#007aff",
                fill=True,
                fill_color="#007aff",
                fill_opacity=0.85,
                tooltip=f"A* waypoint {idx}",
            ).add_to(m)

        m.fit_bounds(coordinates, padding=(30, 30))
        return render_folium_fullscreen(m), 200, {'Content-Type': 'text/html; charset=utf-8'}

    except Exception as e:
        app.logger.error(f"Error generating segment map: {e}")
        return jsonify({"error": str(e)}), 500


@app.route("/api/map-html", methods=["GET"])
def get_map_html():
    """
    Generate interactive map HTML with route visualization.
    
    Uses Folium library to create an interactive map with:
    - All destination markers numbered 1-6
    - Connecting lines between destinations
    - Current location as starting point
    - Distance annotations on each segment
    
    Response Format:
        HTML string containing the map
    """
    if not optimized_route or not current_location_id:
        return jsonify({"error": "Route not yet optimized"}), 400
    
    try:
        # Get all spots
        current_spot = next(
            (item for item in spots_db if item["spot_id"] == current_location_id),
            None
        )
        
        route_spots = []
        for spot_id in optimized_route:
            spot = next(
                (item for item in spots_db if item["spot_id"] == spot_id),
                None
            )
            if spot:
                route_spots.append(spot)
        
        if not current_spot or not route_spots:
            return jsonify({"error": "Invalid route data"}), 400
        
        # Generate map using helper function
        m = generate_folium_map(current_spot, route_spots)
        
        return render_folium_fullscreen(m), 200, {'Content-Type': 'text/html; charset=utf-8'}
    
    except ImportError as e:
        app.logger.error("Folium library not installed")
        return jsonify({"error": "Map library not available. Install with: pip install folium"}), 500
    except Exception as e:
        app.logger.error(f"Error generating map: {e}")
        return jsonify({"error": str(e)}), 500


# ============================================================================
# COMMAND-LINE INTERFACE
# ============================================================================

def cli_main():
    """Main CLI flow for route planning."""
    df = load_dataset()

    print("\n" + "="*60)
    print("Welcome to the Itinerary Planner")
    print("="*60)
    print("\nYou only need to enter place names.")
    print("Example current place: Setia Alam Central Park")
    print("Example destinations: i-City Theme Park, Arabesq Restaurant Shah Alam")

    # User inputs current place name
    current_input = input("\nEnter your current place name: ").strip()

    # Resolve current place
    current_place_id = resolve_place_name(df, current_input)

    if current_place_id is None:
        print("\nERROR: Current place is invalid. Program stopped.")
        return

    # User inputs destination names
    destinations_input = input("\nEnter places you want to visit, separated by commas: ")
    
    # User inputs meal preferences
    meals_input = input(
        "Do you need meals? Enter breakfast, lunch, dinner separated by "
        "commas, or press Enter for none: "
    )
    required_meals = parse_meal_requirements(meals_input)

    # Resolve selected destinations
    selected_destination_ids = []

    for item in destinations_input.split(","):
        spot_id = resolve_place_name(df, item)

        if spot_id is not None:
            selected_destination_ids.append(spot_id)

    if not selected_destination_ids:
        print("\nWARNING: No valid destinations were entered.")

    # Generate final destination IDs (expand to 6 if needed)
    print("\nExpanding destination list...")
    try:
        final_destination_ids = expand_itinerary(
            current_place_id=current_place_id,
            selected_destination_ids=selected_destination_ids,
            required_meals=required_meals
        )
    except ValueError as e:
        print(f"\nERROR: {e}")
        return

    # Optimize route with meal slot constraints
    print("Optimizing route...")
    try:
        optimized_destination_ids = optimize_route_with_meal_slots(
            current_place_id,
            final_destination_ids,
            required_meals
        )
    except ValueError as e:
        print(f"\nERROR: {e}")
        return

    # Display the optimized route
    print_route(optimized_destination_ids)

    # Internal data for the next route planning module:
    # [start_id] + optimized_destination_ids
    route_id_array = [int(current_place_id)] + [
        int(spot_id) for spot_id in optimized_destination_ids
    ]
    
    print("\n" + "="*60)
    print("Route planning completed successfully!")
    print("="*60 + "\n")


# ============================================================================
# APPLICATION ENTRY POINT & CONFIGURATION
# ============================================================================

if __name__ == "__main__":
    # Configure logging
    # Create logs directory if it doesn't exist
    if not os.path.exists('logs'):
        os.makedirs('logs')
    
    # Setup logging
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler('logs/app.log'),
            logging.StreamHandler()
        ]
    )
    
    app.logger.info("=" * 80)
    app.logger.info("ITINERARY PLANNER APPLICATION STARTING")
    app.logger.info("=" * 80)
    app.logger.info(f"Spots Database: {len(spots_db)} records loaded")
    app.logger.info(f"Template Folder: {app.template_folder}")
    app.logger.info(f"Static Folder: {app.static_folder}")
    app.logger.info("-" * 80)
    app.logger.info("STACK COMPONENTS:")
    app.logger.info("  Frontend UI1: /templates/UI1.html (Spot Selection)")
    app.logger.info("  Frontend UI2: /templates/UI2.html (Itinerary Map)")
    app.logger.info("  Styling: /static/bootstrap.min.css + /static/style.css")
    app.logger.info("  JavaScript: /static/jquery.min.js")
    app.logger.info("  Database: CSV (spots.csv)")
    app.logger.info("-" * 80)
    app.logger.info("API ENDPOINTS:")
    app.logger.info("  GET  /                    - Home page (UI1)")
    app.logger.info("  GET  /schedule            - Itinerary page (UI2)")
    app.logger.info("  GET  /api/health          - Health check")
    app.logger.info("  GET  /api/recommendations - Paginated spots")
    app.logger.info("  GET  /api/search          - Search spots")
    app.logger.info("  GET  /api/spots           - Get selected spots")
    app.logger.info("  POST /api/spots           - Add spot to selection")
    app.logger.info("  DELETE /api/spots         - Remove spot from selection")
    app.logger.info("  POST /api/complete        - Complete selection & redirect")
    app.logger.info("-" * 80)
    app.logger.info("Starting Flask server at http://localhost:5000")
    app.logger.info("=" * 80)
    
    # Run the Flask development server
    app.run(
        debug=True,
        host='127.0.0.1',
        port=5000,
        use_reloader=True,
        use_debugger=True
    )
