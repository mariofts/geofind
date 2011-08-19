# JRuby Embedded
### RedBridge

1 - Criar uma pasta para o projeto

	$> mkdir geofind
	$> cd geofind

2 - Criar uma pasta para as gems

	$> mkdir gemdeps
	$> cd gemdeps

3 - Download do JRuby (complete):

	$> curl -O http://jruby.org.s3.amazonaws.com/downloads/1.6.3/jruby-complete-1.6.3.jar

4 - Baixar as gems "vraptor-scaffold", "json_pure" e "geokit"

	$> java -jar jruby-complete-1.6.3.jar -S gem install -i ./vraptor-scaffold vraptor-scaffold
	$> java -jar jruby-complete-1.6.3.jar -S gem install -i ./json_pure json_pure
	$> java -jar jruby-complete-1.6.3.jar -S gem install -i ./geokit geokit

5 - Embutir as gems no jar

	$> jar -uf jruby-complete-1.6.3.jar -C vraptor-scaffold/ .
	$> jar -uf jruby-complete-1.6.3.jar -C json_pure/ .
	$> jar -uf jruby-complete-1.6.3.jar -C geokit/ .

6 - Criar um projeto do VRaptor

	$> cd ../..
	$> java -jar geofind/gemdeps/jruby-complete-1.6.3.jar -S vraptor new geofind
	$> cd geofind

... se necessário, "ant resolve" para baixar as dependências

7 - Colocar o JRuby no caminho da aplicação

	$> cp gemdeps/jruby-complete-1.6.3.jar src/main/webapp/WEB-INF/lib

8 - Importar o projeto para o Eclipse e rodar (It works!)

9 - Gerar scaffold do "location"

	$> vraptor scaffold location query:string

10 - Criar interface para o objeto que retorna do Ruby com os métodos que precisamos

	package app.geokit;
	
	public interface GeoLoc {
		double getLat();
		double getLng();
	}

11 - Criar a classe que executa a chamada para o JRuby e devolve um objeto GeoLoc

	package app.geokit;
	
	import org.jruby.embed.ScriptingContainer;
	import br.com.caelum.vraptor.ioc.Component;
	import app.models.Location;
	
	@Component
	public class GeoCoder {
		public GeoLoc geocode(Location location) {
			// container para contexto da execução
			ScriptingContainer container = new ScriptingContainer();
			
			// script a ser executado
			String rubyScript = "require 'rubygems'\n" +
								"require 'geokit'\n" +
								"Geokit::Geocoders::GoogleGeocoder.geocode('" + location.getQuery() + "')"; 
	
			// rodar o script
			Object geoCodedLocation = container.runScriptlet(rubyScript);
			
			// retornar o objeto convertido para um GeoLoc
			return container.getInstance(geoCodedLocation, GeoLoc.class);
		}
	}
	
12 - Alterar o controller para retornar um GeoLoc no "show"

		// adicionar propriedade ao Controller
	public class LocationController {
	
		private final Result result;
		private final LocationRepository repository;
		private final Validator validator;
		private GeoCoder geocoder;
		
		LocationController(Result result, LocationRepository repository, Validator validator, GeoCoder geocoder) {
			this.result = result;
			this.repository = repository;
			this.validator = validator;
			this.geocoder = geocoder;
		}
	...
		// Modificar action "show"
		@Get("/locations/{location.id}")
		public GeoLoc show(Location location) {
			return geocoder.geocode(repository.find(location.getId()));
		}
	...
	}

13 - Modificar view do "show" para mostrar um mapa a partir da localização

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

14 - VOILÀ

:)