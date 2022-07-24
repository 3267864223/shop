package com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.beans.AdminInfo;
import com.common.Des;
import com.dao.AdminDao;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminDao adminDao = new AdminDao();

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String flag=request.getParameter("flag");
		if("login".equals(flag)) {
			login(request,response);
		}else if("exit".equals(flag)) {
			exit(request,response);
		}
		
	}

	private void exit(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session=request.getSession();
		session.invalidate();		
	}

	private void login(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String adminName=request.getParameter("adminName");
		String password=request.getParameter("password");
		//加密登录
		String encryptPwd =Des.encStr(password);
		AdminInfo admin=adminDao.login(adminName, encryptPwd);
		
		//如果用户存在
		if(admin!=null) {
			//判断state
			//为1，存储session，正常登录
			if(admin.getState().contentEquals("1")) {
				request.getSession().setAttribute("session_admin",admin);
				response.getWriter().print("1");
			}
			//为2，用户为锁定状态
			else if(admin.getState().contentEquals("2")) {
				response.getWriter().print("2");
			}else {
				response.getWriter().print("0");
			}
		}
	}
}
