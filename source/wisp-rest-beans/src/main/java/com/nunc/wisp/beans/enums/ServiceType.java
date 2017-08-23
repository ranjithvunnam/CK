package com.nunc.wisp.beans.enums;


public enum ServiceType {

	SER_VENUE("Venue"), SER_CATERERS("Caterers"), SER_PHOTOGRAPHY("Photography"), SER_EVENT_PLANNERS(
			"EventPlanners"), SER_EVENT_DESIGNERS("EventDesigners"),SER_FLORIST("Florists"), SER_PANDITS(
			"Pandits"), SER_BAARAAT("Baaraat"), SER_DJ("D.J"), SER_ENTERTAINERS(
			"Entertainers"), SER_CARDS("CardDesigners"), SER_BEAUTICIANS("MakeupArtists"), SER_MEHANDI(
			"MehendiArtists"), SER_MUSICIANS("Musicians"), SER_CHOREOGRAPHERS(
			"Choreographer"), SER_TRAVEL("TravelAgency");

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
}
