package com.nunc.wisp.repository.utils;

public enum ServiceTypeTokens {
	
	SER_VENUE("Venues"),
	SER_CATERERS("Caterers, catering"), 
	SER_PHOTOGRAPHY("Photography, photographers"), 
	SER_EVENT_PLANNERS("Event Planners"), 
	SER_EVENT_DESIGNERS("Event Designers"), 
	SER_FLORIST("Florists"), 
	SER_PANDITS("Pandits"), 
	SER_BAARAAT("Baaraat"),
	SER_DJ("D.J, disc jockey"), 
	SER_ENTERTAINERS("Entertainers"), 
	SER_CARDS("Card Designers"), 
	SER_BEAUTICIANS("Makeup Artists, beauticians"), 
	SER_MEHANDI("Mehendi Artists"), 
	SER_MUSICIANS("Musicians"), 
	SER_CHOREOGRAPHERS("Choreographers, dancers"), 
	SER_TRAVEL("Travel Agency");
	
	private String tokens;
	
	ServiceTypeTokens(String tokens){
		this.tokens = tokens;
	}
	
	public String tokens() {
        return tokens;
    }
	
    public static String fromString(String code) {
    	for (int i = 0; i < ServiceTypeTokens.values().length; i++) {
            if (code.equals(ServiceTypeTokens.values()[i].name()))
                return ServiceTypeTokens.values()[i].tokens;
        }
        return null;
    }
}
