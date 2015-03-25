package org.leo.despesas.rest.infra;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

@ApplicationPath("/services")
public class WebServiceActivator extends Application {

	public WebServiceActivator() {
		super();
	}

}
