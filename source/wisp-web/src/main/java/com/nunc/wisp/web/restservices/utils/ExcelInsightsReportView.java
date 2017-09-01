package com.nunc.wisp.web.restservices.utils;

import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.nunc.wisp.beans.vendor.ServiceAccessHitsDownlodResponseBean;

public class ExcelInsightsReportView extends AbstractExcelView{
	
	protected static final Logger LOG_R = Logger.getLogger(ExcelInsightsReportView.class);
	
	@Override
	protected void buildExcelDocument(Map model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// change the file name
        response.setHeader("Content-Disposition", "attachment; filename=\"my-xlsx-file.xlsx\"");
		List<ServiceAccessHitsDownlodResponseBean> insightsData = (List<ServiceAccessHitsDownlodResponseBean>) model.get("insightsData");
		//create a wordsheet
		HSSFSheet sheet = workbook.createSheet("InsightsReport");
		HSSFRow header = sheet.createRow(0);
		header.createCell(0).setCellValue("S.No");
		header.createCell(1).setCellValue("Name");
		header.createCell(2).setCellValue("Email");
		header.createCell(3).setCellValue("Phone");
		header.createCell(4).setCellValue("Location");
		header.createCell(5).setCellValue("Service Name");
		header.createCell(6).setCellValue("Visited Date");

		int rowNum = 1;
		for (ServiceAccessHitsDownlodResponseBean bean : insightsData) {
			//create the row data
			rowNum = rowNum++;
			HSSFRow row = sheet.createRow(rowNum);
			row.createCell(0).setCellValue(rowNum);
			row.createCell(1).setCellValue(bean.getUser_name());
			row.createCell(2).setCellValue(bean.getEmail());
			row.createCell(3).setCellValue(bean.getPhone());
			row.createCell(4).setCellValue(bean.getLocation());
			row.createCell(5).setCellValue(bean.getService_name());
			Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String s = formatter.format(bean.getDate());
			row.createCell(6).setCellValue(s);
        }
	}

}
