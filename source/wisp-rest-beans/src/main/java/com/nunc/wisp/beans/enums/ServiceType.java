package com.nunc.wisp.beans.enums;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public enum ServiceType {

	SER_VENUE("venue"), SER_CATERERS("caterers"), SER_PHOTOGRAPHY("photography"), SER_EVENT_PLANNERS(
			"event_planners"), SER_EVENT_DESIGNERS("event_designers"),SER_FLORIST("florists"), SER_PANDITS(
			"pandits"), SER_BAARAAT("baaraat"), SER_DJ("dj"), SER_ENTERTAINERS(
			"entertainers"), SER_CARDS("cards"), SER_BEAUTICIANS("beauticians"), SER_MEHANDI(
			"mehandi"), SER_MUSICIANS("musicians"), SER_CHOREOGRAPHERS(
			"choreographers"), SER_TRAVEL("travel");

	private String description;
	
	public String getValue() {
		return name();
	}

	public void setValue(String value) {
	}

	private ServiceType(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public static ServiceType getNameByCode(String code) {
		for (int i = 0; i < ServiceType.values().length; i++) {
			if (code.equals(ServiceType.values()[i].description))
				return ServiceType.values()[i];
		}
		return null;
	}

	public static List<ServiceVenueFiltersEnum> getAmenities(String service_type) {
		List<ServiceVenueFiltersEnum> amenities = new ArrayList<ServiceVenueFiltersEnum>();
		switch (service_type) {
		case "venue":
			amenities = Arrays.asList(ServiceVenueFiltersEnum.values());
			break;

		default:
			break;
		}
		return amenities;
	}
}
