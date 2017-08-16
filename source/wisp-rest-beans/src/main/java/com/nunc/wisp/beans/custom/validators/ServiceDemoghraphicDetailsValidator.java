package com.nunc.wisp.beans.custom.validators;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.nunc.wisp.beans.request.ServiceCreationRequestBean;

@Component
public class ServiceDemoghraphicDetailsValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return ServiceCreationRequestBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		validateServiceDemoghraphicDetails(target, errors);
		validateServiceMediaDetails(target, errors);
	}
	
	public void validateServiceDemoghraphicDetails(Object target, Errors errors) {
		ValidationUtils.rejectIfEmpty(errors, "service_type", "Service type is required.");
		ValidationUtils.rejectIfEmpty(errors, "service_name", "Service name is required");
		ValidationUtils.rejectIfEmpty(errors, "service_description", "Service Description is required");
		ValidationUtils.rejectIfEmpty(errors, "service_phone", "Phone number is required");
		ValidationUtils.rejectIfEmpty(errors, "service_address1", "Address1 required");
		ValidationUtils.rejectIfEmpty(errors, "service_city", "City is required");
		ValidationUtils.rejectIfEmpty(errors, "service_state", "State is required");
		ValidationUtils.rejectIfEmpty(errors, "service_country", "Country is required");
		ValidationUtils.rejectIfEmpty(errors, "service_pin", "Pincode is required");
	}

	public void validateServiceMediaDetails(Object target, Errors errors) {
		ValidationUtils.rejectIfEmpty(errors, "amenityBean.price", "Please select price.");
		
	}
}
