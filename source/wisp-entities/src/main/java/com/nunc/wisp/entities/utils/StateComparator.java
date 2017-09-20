package com.nunc.wisp.entities.utils;

import java.util.Comparator;

public class StateComparator implements Comparator<StatesEntity>{

	@Override
	public int compare(StatesEntity a, StatesEntity b) {
		return a.getState_name().compareToIgnoreCase(b.getState_name());
	}

}
