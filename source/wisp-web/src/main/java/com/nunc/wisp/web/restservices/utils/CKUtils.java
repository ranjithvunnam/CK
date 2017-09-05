package com.nunc.wisp.web.restservices.utils;

import java.net.URISyntaxException;
import java.util.Iterator;
import java.util.List;

import org.apache.http.NameValuePair;
import org.apache.http.client.utils.URIBuilder;
import org.springframework.stereotype.Component;

@Component
public class CKUtils {
	
	public String removeQueryString(String url, String parameterName) throws URISyntaxException {
		URIBuilder uriBuilder = new URIBuilder(url);
		List<NameValuePair> queryParameters = uriBuilder.getQueryParams();
		for (Iterator<NameValuePair> queryParameterItr = queryParameters.iterator(); queryParameterItr.hasNext();) {
	        NameValuePair queryParameter = queryParameterItr.next();
	        if (queryParameter.getName().equals(parameterName)) {
	            queryParameterItr.remove();
	        }
	    }
	    uriBuilder.setParameters(queryParameters);
	    return uriBuilder.build().toString();
	}
}
