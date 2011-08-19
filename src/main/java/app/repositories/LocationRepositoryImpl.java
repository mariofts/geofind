package app.repositories;

import javax.persistence.EntityManager;

import br.com.caelum.vraptor.ioc.Component;
import app.models.Location;

@Component
public class LocationRepositoryImpl 
    extends Repository<Location, Long>
    implements LocationRepository {

	LocationRepositoryImpl(EntityManager entityManager) {
		super(entityManager);
	}
}
