package app.geokit;

import org.jruby.embed.ScriptingContainer;
import br.com.caelum.vraptor.ioc.Component;
import app.models.Location;

@Component
public class GeoCoder {
	public GeoLoc geocode(Location location) {
		ScriptingContainer container = new ScriptingContainer();
		String rubyScript = "require 'rubygems'\n" +
							"require 'geokit'\n" +
							"Geokit::Geocoders::GoogleGeocoder.geocode('" + location.getQuery() + "')"; 
		Object geoCodedLocation = container.runScriptlet(rubyScript);
		
		return container.getInstance(geoCodedLocation, GeoLoc.class);
	}
}
