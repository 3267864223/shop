package com.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.beans.AdminInfo;
import com.beans.PageInfo;
import com.common.Des;
import com.dao.AdminDao;
import com.jdbc.PageUtil;

@WebServlet("/AdminServlet.do")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	AdminDao adminDao = new AdminDao();
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String flag=request.getParameter("flag");
		
		if("checkAdminName".equals(flag)) {
			checkAdminName(request,response);
		}else if("add".equals(flag)) {
			add(request,response);
		}else if("manage".equals(flag)) {
			manage(request,response);
		}else if("refresh".equals(flag)) {
			refresh(request,response);
		}else if("lockAdmin".equals(flag)) {
			lockAdmin(request,response);
		}else if("unlockAdmin".equals(flag)) {
			unlockAdmin(request,response);
		}else if("delete".equals(flag)) {
			delete(request,response);
		}else if("toupdate".equals(flag)) {
			toupdate(request,response);
		}else if("update".equals(flag)) {
			update(request,response);
		}else if("info".equals(flag)) {
			info(request,response);
		}else if("edit".equals(flag)) {
			edit(request,response);
		}else if("editpassword".equals(flag)) {
			editpassword(request,response);
		}else if("checkPwd".equals(flag)) {
			checkPwd(request,response);
		}else if("delAll".equals(flag)) {
			delAll(request,response);
		}
	}
	
	//删除所选
	private void delAll(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String IdList=request.getParameter("arrId");
		adminDao.delAll(IdList);
		response.getWriter().print("删除成功");
		
	}

	//检查旧密码是否正确
	private void checkPwd(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String adminName=request.getParameter("adminName");
		String oldpassword=request.getParameter("oldpassword");
		String encryptOldPwd =Des.encStr(oldpassword);
		AdminInfo admin=adminDao.getAdminByName(adminName);
		if(admin.getPassword().equals(encryptOldPwd)) {
			response.getWriter().print("0");
		}else {
			response.getWriter().print("1");
		}
		
	}

	//修改密码
	private void editpassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String adminName=request.getParameter("adminName");
		String password=request.getParameter("password");
		String encryptPwd =Des.encStr(password);
		adminDao.editPwd(adminName,encryptPwd);
		response.getWriter().print("密码修改成功");
	}

	//去往密码修改
	private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		AdminInfo admin= (AdminInfo)session.getAttribute("session_admin");
		session.setAttribute("session_admin", admin);
		request.getRequestDispatcher("admin/password_edit.jsp").forward(request, response);
	}

	//去往显示用户信息
	private void info(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		AdminInfo admin= (AdminInfo)session.getAttribute("session_admin");
		session.setAttribute("session_admin", admin);
		request.getRequestDispatcher("admin/admin_info.jsp").forward(request, response);
	}

	private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String adminName=request.getParameter("adminName");
		String note=request.getParameter("note");
		adminDao.updateAdmin(adminName,note);
		response.getWriter().print("用户修改成功");
		
	}

	private void toupdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String adminName=request.getParameter("adminName");
		String note=request.getParameter("note");
		request.setAttribute("adminName", adminName);
		request.setAttribute("note", note);
		request.getRequestDispatcher("admin/admin_update.jsp").forward(request, response);
		
	}

	private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int adminId=Integer.parseInt(request.getParameter("adminId"));
		adminDao.delAdmin(adminId);
		response.getWriter().print("用户已删除");
		
	}

	//解锁用户
	private void unlockAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int adminId=Integer.parseInt(request.getParameter("adminId"));
		adminDao.unlockAdmin(adminId);
		response.getWriter().print("用户已解锁");
	}

	//锁定用户
	private void lockAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int adminId=Integer.parseInt(request.getParameter("adminId"));
		adminDao.lockAdmin(adminId);
		response.getWriter().print("用户已锁定");
		
	}

	//保持session不变，刷新时间
	private void refresh(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session=request.getSession();
		AdminInfo admin= (AdminInfo)session.getAttribute("session_admin");
		session.setAttribute("session_admin", admin);
		
		Date date=new Date();
		String time=new SimpleDateFormat("yyyy-MM-dd E HH:mm").format(date);

		response.getWriter().print(time);
	}

	private void manage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		int pageIndex=request.getParameter("pageIndex")==null?1:Integer.parseInt(request.getParameter("pageIndex"));
		long rowCount=adminDao.getAdminCount();
		PageInfo page=PageUtil.getPageInfo(10, pageIndex, rowCount);
		List<AdminInfo> adminList=adminDao.getAdminList(page);
		HttpSession session=request.getSession();
		AdminInfo admin= (AdminInfo)session.getAttribute("session_admin");
		
		session.setAttribute("session_admin", admin);
		request.setAttribute("adminList", adminList);
		request.setAttribute("page", page);
		request.getRequestDispatcher("admin/admin_manage.jsp").forward(request, response);
		
	}

	private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String adminName=request.getParameter("adminName");
		String password=request.getParameter("password");
		//加密
		String encryptPwd =Des.encStr(password);
		String note=request.getParameter("txtarea");
		adminDao.addAdmin(note,encryptPwd,adminName);
		response.getWriter().print("用户添加成功");
		
	}

	//检查用户名是否重复
	private void checkAdminName(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String adminName=request.getParameter("adminName");
		AdminInfo admin=adminDao.getAdminByName(adminName);
		if(admin!=null) {
			response.getWriter().print("0");
		}
	}

}
