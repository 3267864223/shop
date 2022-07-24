package com.aop;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SessionFilter implements Filter{

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req=(HttpServletRequest)request;
		String uri=req.getRequestURI();
		//用户输入/shop/login.jsp 不用拦截、
		if(!uri.endsWith("login.jsp")) {
			HttpSession session=req.getSession();
			if(session.getAttribute("session_admin")==null) {
				//没有登录，返回login.jsp
				String contextPath=req.getContextPath();
				response.getWriter().print("<script>window.top.location.href='"+contextPath+"/login.jsp'</script>");
			}else {
				chain.doFilter(request,response);
			}
		}else {
			chain.doFilter(request,response);
		}
	}
	

}
