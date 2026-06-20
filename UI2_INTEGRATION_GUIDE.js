/**
 * UI2 Integration Guide
 * 
 * This file shows how to integrate the new API endpoints into UI2.html
 * for displaying the optimized route, interactive map, and segment routes.
 */

// ============================================================================
// 1. LOAD ROUTE DATA ON PAGE LOAD
// ============================================================================

document.addEventListener('DOMContentLoaded', function() {
    loadRouteData();
    loadInteractiveMap();
});

async function loadRouteData() {
    try {
        const response = await fetch('/api/route-data');
        if (!response.ok) throw new Error('Failed to load route data');
        
        const data = await response.json();
        
        // Display current location
        displayCurrentLocation(data.current_location);
        
        // Display route spots numbered 1-6
        displayRouteSpots(data.route);
        
        console.log('Route data loaded successfully', data);
    } catch (error) {
        console.error('Error loading route data:', error);
        document.getElementById('route-error').textContent = 
            'Error loading route: ' + error.message;
    }
}

// ============================================================================
// 2. DISPLAY CURRENT LOCATION (STARTING POINT)
// ============================================================================

function displayCurrentLocation(spot) {
    if (!spot) return;
    
    const container = document.getElementById('current-location-display');
    if (!container) return;
    
    container.innerHTML = `
        <div class="current-location-card">
            <h3>Starting Point</h3>
            <p class="spot-name">${spot.spot_name}</p>
            <p class="spot-description">${spot.spot_description}</p>
            <p class="spot-rating">Rating: ${spot.spot_rating}/5</p>
            <p class="spot-coords">
                Location: (${spot.location_x.toFixed(4)}, ${spot.location_y.toFixed(4)})
            </p>
        </div>
    `;
}

// ============================================================================
// 3. DISPLAY OPTIMIZED ROUTE (NUMBERED 1-6)
// ============================================================================

function displayRouteSpots(spots) {
    const container = document.getElementById('route-list');
    if (!container) return;
    
    container.innerHTML = '';
    
    spots.forEach((spot, index) => {
        const order = spot.order || (index + 1);
        const isLast = (order === spots.length);
        
        const spotElement = document.createElement('div');
        spotElement.className = 'route-spot-item';
        spotElement.dataset.spotId = spot.spot_id;
        spotElement.dataset.order = order;
        
        spotElement.innerHTML = `
            <div class="spot-order-badge">${order}</div>
            <div class="spot-content">
                <h4>${spot.spot_name}</h4>
                <p class="spot-description">${spot.spot_description}</p>
                <p class="spot-details">
                    Rating: ${spot.spot_rating}/5 
                    ${spot.is_restaurant ? '| Restaurant: ' + spot.meal_type : ''}
                </p>
                <p class="spot-coords">
                    (${spot.location_x.toFixed(4)}, ${spot.location_y.toFixed(4)})
                </p>
            </div>
            <button class="btn-view-route" data-to-spot="${isLast ? 'start' : order + 1}">
                View Route
            </button>
        `;
        
        // Add click handler to view segment route
        spotElement.querySelector('.btn-view-route').addEventListener('click', function() {
            const currentSpotId = spot.spot_id;
            const nextOrder = order === spots.length ? 0 : order + 1;
            
            if (nextOrder === 0) {
                // Back to start
                showReturnRoute(currentSpotId, spots[0].spot_id);
            } else {
                const nextSpot = spots.find(s => s.order === nextOrder);
                if (nextSpot) {
                    showSegmentRoute(currentSpotId, nextSpot.spot_id);
                }
            }
        });
        
        container.appendChild(spotElement);
    });
}

// ============================================================================
// 4. LOAD INTERACTIVE MAP
// ============================================================================

async function loadInteractiveMap() {
    try {
        const mapContainer = document.getElementById('interactive-map');
        if (!mapContainer) return;
        
        // Fetch map HTML
        const response = await fetch('/api/map-html');
        if (!response.ok) throw new Error('Failed to load map');
        
        const mapHtml = await response.text();
        
        // Insert into DOM
        mapContainer.innerHTML = mapHtml;
        
        console.log('Interactive map loaded successfully');
    } catch (error) {
        console.error('Error loading map:', error);
        
        const mapContainer = document.getElementById('interactive-map');
        if (mapContainer) {
            mapContainer.innerHTML = `<p class="error">Error loading map: ${error.message}</p>`;
        }
    }
}

// ============================================================================
// 5. DISPLAY SEGMENT ROUTE DETAILS
// ============================================================================

async function showSegmentRoute(fromSpotId, toSpotId) {
    try {
        const response = await fetch(`/api/segment-route/${fromSpotId}/${toSpotId}`);
        if (!response.ok) throw new Error('Failed to load segment route');
        
        const data = await response.json();
        
        // Display segment details in modal or side panel
        displaySegmentRouteDetails(data);
        
        // Update map to show segment
        updateMapSegment(data);
        
    } catch (error) {
        console.error('Error loading segment route:', error);
        alert('Error loading route: ' + error.message);
    }
}

async function showReturnRoute(currentSpotId, startSpotId) {
    try {
        const response = await fetch(`/api/segment-route/${currentSpotId}/${startSpotId}`);
        if (!response.ok) throw new Error('Failed to load return route');
        
        const data = await response.json();
        
        displaySegmentRouteDetails({
            ...data,
            from_spot: {
                ...data.from_spot,
                spot_name: data.from_spot.spot_name + ' (Last stop)'
            },
            to_spot: {
                ...data.to_spot,
                spot_name: 'Return to ' + data.to_spot.spot_name + ' (Start)'
            }
        });
        
        updateMapSegment(data);
        
    } catch (error) {
        console.error('Error loading return route:', error);
    }
}

function displaySegmentRouteDetails(data) {
    const container = document.getElementById('segment-details');
    if (!container) return;
    
    const route = data.route;
    
    container.innerHTML = `
        <div class="segment-header">
            <h3>Route Details</h3>
            <button class="btn-close" onclick="closeSegmentDetails()">×</button>
        </div>
        
        <div class="segment-from">
            <h4>From:</h4>
            <p class="spot-name">${data.from_spot.spot_name}</p>
        </div>
        
        <div class="segment-to">
            <h4>To:</h4>
            <p class="spot-name">${data.to_spot.spot_name}</p>
        </div>
        
        <div class="segment-route">
            <h4>Route Information</h4>
            <p><strong>Distance:</strong> ${route.total_distance.toFixed(2)} km</p>
            <p><strong>Status:</strong> ${route.status}</p>
        </div>
        
        <div class="segment-instructions">
            <h4>Directions:</h4>
            <ol>
                ${route.instructions.map(instr => `<li>${instr}</li>`).join('')}
            </ol>
        </div>
        
        <div class="segment-coordinates">
            <h4>Route Coordinates:</h4>
            <ul>
                ${route.coordinates.map((coord, idx) => 
                    `<li>Point ${idx + 1}: (${coord[0].toFixed(4)}, ${coord[1].toFixed(4)})</li>`
                ).join('')}
            </ul>
        </div>
    `;
}

function closeSegmentDetails() {
    const container = document.getElementById('segment-details');
    if (container) {
        container.innerHTML = '';
    }
}

function updateMapSegment(data) {
    // This would update the Folium map to highlight the segment
    // Implementation depends on how the map is embedded
    console.log('Update map with segment:', data);
    
    // If using Folium directly in HTML, you might need to:
    // 1. Clear previous highlights
    // 2. Add new markers for from/to spots
    // 3. Draw new polyline for the segment
}

// ============================================================================
// 6. HTML STRUCTURE (to be added in UI2.html)
// ============================================================================

/*

<!-- Current Location Display -->
<div id="current-location-display" class="section">
    <!-- Populated by displayCurrentLocation() -->
</div>

<!-- Interactive Map -->
<div id="interactive-map" class="section map-container">
    <!-- Populated by loadInteractiveMap() -->
</div>

<!-- Route List (Numbered 1-6) -->
<div id="route-list" class="section route-list">
    <!-- Populated by displayRouteSpots() -->
</div>

<!-- Segment Route Details (Modal/Panel) -->
<div id="segment-details" class="section segment-details-panel">
    <!-- Populated by displaySegmentRouteDetails() -->
</div>

<!-- Error Display -->
<div id="route-error" class="error-display"></div>

*/

// ============================================================================
// 7. CSS STYLING (to be added in style.css)
// ============================================================================

/*

.current-location-card {
    background: #e8f5e9;
    padding: 15px;
    border-radius: 8px;
    border-left: 4px solid #4caf50;
    margin-bottom: 20px;
}

.route-spot-item {
    display: flex;
    align-items: center;
    padding: 15px;
    margin: 10px 0;
    background: #f5f5f5;
    border-radius: 8px;
    border-left: 4px solid #2196f3;
    cursor: pointer;
    transition: background 0.3s;
}

.route-spot-item:hover {
    background: #e3f2fd;
}

.spot-order-badge {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    background: #2196f3;
    color: white;
    border-radius: 50%;
    font-weight: bold;
    font-size: 18px;
    margin-right: 15px;
    flex-shrink: 0;
}

.spot-content {
    flex: 1;
}

.btn-view-route {
    background: #ff9800;
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 4px;
    cursor: pointer;
    margin-left: 15px;
}

.btn-view-route:hover {
    background: #f57c00;
}

.map-container {
    width: 100%;
    height: 600px;
    border: 1px solid #ddd;
    border-radius: 8px;
    overflow: hidden;
    margin: 20px 0;
}

.segment-details-panel {
    position: fixed;
    right: 0;
    top: 0;
    width: 400px;
    height: 100vh;
    background: white;
    box-shadow: -2px 0 8px rgba(0,0,0,0.2);
    overflow-y: auto;
    padding: 20px;
    z-index: 1000;
    display: none;
}

.segment-details-panel:not(:empty) {
    display: block;
}

.segment-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    border-bottom: 1px solid #ddd;
    padding-bottom: 15px;
}

.btn-close {
    background: none;
    border: none;
    font-size: 24px;
    cursor: pointer;
}

*/
