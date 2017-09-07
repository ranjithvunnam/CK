package com.nunc.wisp.services.handlers;

import java.io.File;
import java.io.IOException;
import java.net.URL;

import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.nunc.wisp.services.exception.WISPServiceException;

@Component
public class FileUploadService {
	
	protected static final Logger LOG_R = Logger.getLogger(FileUploadService.class);
	
	private String UPLOAD_IMAGES_DIRECTORY = "C:\\Apache24\\htdocs\\wisp\\service_images";
	private String ACCESS_IMAGES_DIRECTORY = "http://202.53.86.14/wisp/service_images/";
	
	private String UPLOAD_VIDEOS_DIRECTORY = "C:\\Apache24\\htdocs\\wisp\\service_videos";
	private String ACCESS_VIDEOS_DIRECTORY = "http://202.53.86.14/wisp/service_videos/";
	
	private String UPLOAD_TEMP_IMAGES_DIRECTORY = "C:\\Apache24\\htdocs\\wisp\\service_temp_images\\";
	//private String ACCESS_TEMP_IMAGES_DIRECTORY = "http://202.53.86.11/wisp/service_temp_images/";
	
	private String UPLOAD_TEMP_VIDEOS_DIRECTORY = "C:\\Apache24\\htdocs\\wisp\\service_temp_videos\\";
	//private String ACCESS_TEMP_VIDEOS_DIRECTORY = "http://202.53.86.11/wisp/service_temp_videos/";
	
	
	@Autowired
	ServletContext servletContext;

	public String uploadImages(String tempPath) throws WISPServiceException {
		File destination = null;
		String fileName = null;
		try {
			File newDirectory = new File(UPLOAD_IMAGES_DIRECTORY);
			if (!newDirectory.isDirectory()) {
				boolean success = newDirectory.mkdirs();
				LOG_R.debug("leftImage directory created - " + success);
			}
			URL dl = new URL(tempPath);
			destination = new File(newDirectory + "/" + FilenameUtils.getName(dl.getPath()));
			if(destination.exists() && !destination.isDirectory()) { 
			    
			} else {
				FileUtils.copyURLToFile(dl, destination);
			}
			//source.delete();
			fileName = ACCESS_IMAGES_DIRECTORY+destination.getName();
			File fileToDelete = FileUtils.getFile(UPLOAD_TEMP_IMAGES_DIRECTORY+destination.getName());
			if(fileToDelete.exists()) {
				FileUtils.forceDelete(fileToDelete);
			}
		} catch (IOException e) {
			throw new WISPServiceException(e);
		}
		return fileName;
	}
	
	public String uploadVideos(String tempPath) throws WISPServiceException {
		File destination = null;
		String fileName = null;
		try {
			File newDirectory = new File(UPLOAD_VIDEOS_DIRECTORY);
			if (!newDirectory.isDirectory()) {
				boolean success = newDirectory.mkdirs();
				LOG_R.debug("leftImage directory created - " + success);
			}
			URL dl = new URL(tempPath);
			destination = new File(newDirectory + "/" + FilenameUtils.getName(dl.getPath()));
			if(destination.exists() && !destination.isDirectory()) { 
			    
			} else {
				FileUtils.copyURLToFile(dl, destination);
			}
			//source.delete();
			fileName = ACCESS_VIDEOS_DIRECTORY+destination.getName();
			File fileToDelete = FileUtils.getFile(UPLOAD_TEMP_VIDEOS_DIRECTORY+destination.getName());
			if(fileToDelete.exists()) {
				FileUtils.forceDelete(fileToDelete);
			}
		} catch (IOException e) {
			throw new WISPServiceException(e);
		}
		return fileName;
	}
	
	public boolean deleteImageFile(String tempPath) throws WISPServiceException {
		boolean status = false;
		try {
			URL dl = new URL(tempPath);
			if(tempPath != null && tempPath.contains("service_images")) {
				File fileToDelete = new File(UPLOAD_IMAGES_DIRECTORY + "/" + FilenameUtils.getName(dl.getPath()));
				if(fileToDelete.exists()) {
					FileUtils.forceDelete(fileToDelete);
				}
				status = true;
			} else {
				File fileToDelete = new File(UPLOAD_TEMP_IMAGES_DIRECTORY + "/" + FilenameUtils.getName(dl.getPath()));
				if(fileToDelete.exists()) {
					FileUtils.forceDelete(fileToDelete);
				}
				status = true;
			}
		} catch (IOException e) {
			status = false;
			throw new WISPServiceException(e);
		}
		return status;
	}

	public boolean deleteVideoFile(String videotempPath)  throws WISPServiceException {
		boolean status = false;
		try {
			URL dl = new URL(videotempPath);
			if(videotempPath != null && videotempPath.contains("service_videos")) {
				File fileToDelete = new File(UPLOAD_VIDEOS_DIRECTORY + "/" + FilenameUtils.getName(dl.getPath()));
				if(fileToDelete.exists()) {
					FileUtils.forceDelete(fileToDelete);
				}
				status = true;
			} else {
				File fileToDelete = new File(UPLOAD_TEMP_VIDEOS_DIRECTORY + "/" + FilenameUtils.getName(dl.getPath()));
				if(fileToDelete.exists()) {
					FileUtils.forceDelete(fileToDelete);
				}
				status = true;
			}
		} catch (IOException e) {
			status = false;
			throw new WISPServiceException(e);
		}
		return status;
	}
}
