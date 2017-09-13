package com.nunc.wisp.entities.listbeans;

import java.io.Serializable;
import java.util.List;

import com.nunc.wisp.entities.MainSliderEntity;

public class MainSliderResponseBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3258698018689131615L;
	
	private List<MainSliderEntity> mainSlider;

	public List<MainSliderEntity> getMainSlider() {
		return mainSlider;
	}

	public void setMainSlider(List<MainSliderEntity> mainSlider) {
		this.mainSlider = mainSlider;
	}
}
