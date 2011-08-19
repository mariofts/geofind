package app.models;

@javax.persistence.Entity
public class Location extends Entity {
	
	private String query;
	
	public void setQuery(String query) {
		this.query = query;
	}
	
	public String getQuery() {
		return query;
	}
	
}
