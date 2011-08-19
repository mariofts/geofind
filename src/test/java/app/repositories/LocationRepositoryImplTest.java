package app.repositories;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;

public class LocationRepositoryImplTest {

    @Test public void fakeTest() {
  		assertNotNull("put something real.", new LocationRepositoryImpl(null));
  	}
}

