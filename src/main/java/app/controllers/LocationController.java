package app.controllers;

import java.util.List;

import app.geokit.GeoCoder;
import app.geokit.GeoLoc;
import app.models.Location;
import app.repositories.LocationRepository;
import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Put;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;

@Resource
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
	
	@Get("/locations")
	public List<Location> index() {
		return repository.findAll();
	}
	
	@Post("/locations")
	public void create(Location location) {
		validator.validate(location);
		validator.onErrorUsePageOf(this).newLocation();
		repository.create(location);
		result.redirectTo(this).index();
	}
	
	@Get("/locations/new")
	public Location newLocation() {
		return new Location();
	}
	
	@Put("/locations")
	public void update(Location location) {
		validator.validate(location);
		validator.onErrorUsePageOf(this).edit(location);
		repository.update(location);
		result.redirectTo(this).index();
	}
	
	@Get("/locations/{location.id}/edit")
	public Location edit(Location location) {
		return repository.find(location.getId());
	}

	@Get("/locations/{location.id}")
	public GeoLoc show(Location location) {
		return geocoder.geocode(repository.find(location.getId()));
	}

	@Delete("/locations/{location.id}")
	public void destroy(Location location) {
		repository.destroy(repository.find(location.getId()));
		result.redirectTo(this).index();  
	}
}