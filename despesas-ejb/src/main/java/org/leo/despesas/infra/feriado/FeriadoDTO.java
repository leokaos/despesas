package org.leo.despesas.infra.feriado;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class FeriadoDTO {

	private String date;
	private String localName;
	private Object counties;

	public FeriadoDTO() {
		super();
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getLocalName() {
		return localName;
	}

	public void setLocalName(String localName) {
		this.localName = localName;
	}

	public Object getCounties() {
		return counties;
	}

	public void setCounties(Object counties) {
		this.counties = counties;
	}

}
