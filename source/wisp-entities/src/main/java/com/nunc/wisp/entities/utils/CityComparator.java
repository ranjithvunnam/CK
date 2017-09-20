package com.nunc.wisp.entities.utils;

import java.util.Comparator;

public class CityComparator implements Comparator<CitiesEntity>{

	@Override
	public int compare(CitiesEntity a, CitiesEntity b) {
		return a.getCity_name().compareToIgnoreCase(b.getCity_name());
	}

}
