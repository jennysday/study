package com.spring.test.service.common;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class Common {
	/*** alert 메세지 ***/
	public void alertAndGo(HttpServletResponse response, String msg, String url) {
	    try {
	        response.setContentType("text/html; charset=utf-8");
	        PrintWriter w = response.getWriter();
	        w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	        w.flush();
	        w.close();
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	}
}
