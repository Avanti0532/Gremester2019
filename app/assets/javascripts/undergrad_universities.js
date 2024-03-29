var map;

function initialize() {
    // Create a map centered in United States
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: 36.2153013, lng: -113.6920816},
        zoom: 5
    });

    // Search for university's location
    var request = {
        location: map.getCenter(),
        radius: '500',
        query: document.getElementById('uni_name').innerText
    };

    var service = new google.maps.places.PlacesService(map);
    service.textSearch(request, callback);
}

// Checks that the PlacesServiceStatus is OK, and adds a marker
// using the place ID and location from the PlacesService.
function callback(results, status) {
    if (status == google.maps.places.PlacesServiceStatus.OK) {
        var marker = new google.maps.Marker({
            map: map,
            place: {
                placeId: results[0].place_id,
                location: results[0].geometry.location
            }
        });
        map.setCenter(results[0].geometry.location);
        map.setZoom(14);
    }
}