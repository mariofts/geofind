<head>
	<title>Location [show]</title>
	<style type="text/css">
 		html { height: 100%; }
  		body { height: 100%; margin: 0; padding: 0; }
  		#map { height: 400px; }
	</style>
	<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
	<script type="text/javascript">
		function initialize() {
			var mapCanvas = document.getElementById("map-canvas");
			var mapPoint = new google.maps.LatLng(${geoLoc.lat}, ${geoLoc.lng});
			var mapOptions = { zoom: 16,
							   mapTypeId: google.maps.MapTypeId.ROADMAP,
							   center: mapPoint
							 };
			
			var mapShow = new google.maps.Map(mapCanvas, mapOptions);


			marker = new google.maps.Marker({
				map: mapShow,
				draggable: true,
				animation: google.maps.Animation.DROP,
				position: mapPoint
			});
		}
	</script>

</head>
<body>
	<a href="${pageContext.request.contextPath}/locations">Back</a>
	<div id="map-canvas" style="width:600px;height:400px;"></div>
	<script type="text/javascript">
		initialize();
	</script>
</body>