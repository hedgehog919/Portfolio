/**
 *  Leaflet Map
 */

$(document).ready(function() {

	doLeaflet();

})



function doLeaflet() {
	var map = L.map('map').setView([22.99920029558103, 120.21593935131331], 16);
	L.marker([22.99920029558103, 120.21593935131331]).bindPopup("<h6>台南市東區大學路1號</h6>").openPopup().addTo(map);

	L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
		maxZoom: 19,
		attribution: '© OpenStreetMap'
	}).addTo(map);
	

	
}
