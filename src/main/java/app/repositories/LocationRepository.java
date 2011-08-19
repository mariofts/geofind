package app.repositories;

import java.util.List;

import app.models.Location;

public interface LocationRepository {
	/*
	 * Delete the methods you don't want to expose
	 */
	 
	void create(Location entity);
	
	void update(Location entity);
	
	void destroy(Location entity);
	
	Location find(Long id);
	
	List<Location> findAll();

}
