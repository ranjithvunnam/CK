package com.nunc.wisp.web.restservices.utils;

import java.io.Writer;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.log4j.Logger;

public class PaginationTaglib extends SimpleTagSupport {
	protected static final Logger LOG_R = Logger.getLogger(PaginationTaglib.class);
	private String uri;
	private int offset;
	private int count;
	private int max = 10;
	private int steps = 10;
	private String previous = "Previous";
	private String next = "Next";

	private Writer getWriter() {
		JspWriter out = getJspContext().getOut();
		return out;
	}

	@Override
	public void doTag() throws JspException {
		Writer out = getWriter();

		try {
			out.write("<nav>");
			out.write("<ul class=\"pagination\">");
			/*
			 * This is for previous button
			 * 
			 * */
			if (offset < steps){
				out.write(constructLink(1, previous, "disabled", true));
			}
			else{
				out.write(constructLink(offset - steps, previous, null, false));
			}
			
			/*
			 * This is for middle pages
			 * 
			 * */
			
			for (int itr = 0; itr < count; itr += steps) {
				if (offset == itr){
					/*
					 * if offset and select page equals the make it active
					 * 
					 * */
					out.write(constructLink((itr / 10 + 1) - 1 * steps,	String.valueOf(itr / 10 + 1), "active", true));
				}
				else{
					LOG_R.info("Loop not active page : "+itr / 10 * steps +" text : "+String.valueOf(itr / 10 + 1));
					out.write(constructLink(itr / 10 * steps, String.valueOf(itr / 10 + 1), null, false));
				}
			}
			/*
			 * This is for next button
			 * 
			 * */
			if (offset + steps >= count){
				out.write(constructLink(offset + steps, next, "disabled", true));
			}
			else{
				out.write(constructLink(offset + steps, next, null, false));
			}
			out.write("</ul>");
			out.write("</nav>");
		} catch (java.io.IOException ex) {
			throw new JspException("Error in Paginator tag", ex);
		}
	}

	private String constructLink(int page, String text, String className,
			boolean disabled) {
		StringBuilder link = new StringBuilder("<li");
		if (className != null) {
			link.append(" class=\"");
			link.append(className);
			link.append("\"");
		}
		if (disabled)
			link.append(">").append("<a href=\"javascript:function() { return false; }\">" + text + "</a></li>");
		else
			link.append(">").append(
					"<a href=\"" + uri + "?offset=" + page + "\">" + text
							+ "</a></li>");
		return link.toString();
	}

	public String getUri() {
		return uri;
	}

	public void setUri(String uri) {
		this.uri = uri;
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getMax() {
		return max;
	}

	public void setMax(int max) {
		this.max = max;
	}

	public String getPrevious() {
		return previous;
	}

	public void setPrevious(String previous) {
		this.previous = previous;
	}

	public String getNext() {
		return next;
	}

	public void setNext(String next) {
		this.next = next;
	}

	public int getSteps() {
		return steps;
	}

	public void setSteps(int steps) {
		this.steps = steps;
	}

}
