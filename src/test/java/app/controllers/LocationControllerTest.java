package app.controllers;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;

public class LocationControllerTest {

	@Test public void fakeTest() {
		assertNotNull("put something real.", new LocationController(null, null, null, null));
 	}
}
