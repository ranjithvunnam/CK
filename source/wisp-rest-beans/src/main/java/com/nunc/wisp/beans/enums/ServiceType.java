package com.nunc.wisp.beans.enums;


public enum ServiceType {

	SER_VENUE("Venue","Venue"), SER_CATERERS("Caterers","Caterers"), SER_PHOTOGRAPHY("Photography", "Photography"), SER_EVENT_PLANNERS(
			"EventPlanners", "Event Planners"), SER_EVENT_DESIGNERS("EventDesigners", "Event Designers"),SER_FLORIST("Florists", "Florists"), SER_PANDITS(
			"Pandits", "Pandits"), SER_BAARAAT("Baaraat", "Baaraat"), SER_DJ("D.J", "D.J"), SER_ENTERTAINERS(
			"Entertainers", "Entertainers"), SER_CARDS("CardDesigners", "Card Designers"), SER_BEAUTICIANS("MakeupArtists", "Makeup Artists"), SER_MEHANDI(
			"MehendiArtists", "Mehendi Artists"), SER_MUSICIANS("Musicians", "Musicians"), SER_CHOREOGRAPHERS(
			"Choreographer", "Choreographer"), SER_TRAVEL("TravelAgency", "Travel Agency");

	private String description;
	
	private String displayName;
	
	public String getValue() {
		return name();
	}

	public void setValue(String value) {
	}

	private ServiceType(String description, String displayName) {
		this.description = description;
		this.displayName = displayName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public static ServiceType getNameByCode(String code) {
		for (int i = 0; i < ServiceType.values().length; i++) {
			if (code.equals(ServiceType.values()[i].description))
				return ServiceType.values()[i];
		}
		return null;
	}
	
	public static boolean contains(String token) {
	    for (ServiceType c : ServiceType.values()) {
	        if (c.name().equals(token)) {
	            return true;
	        }
	    }
	    return false;
	}
}
