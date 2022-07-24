package com.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.beans.AdminInfo;
import com.beans.MenuInfo;
import com.beans.PageInfo;
import com.beans.RoleInfo;
import com.dao.MenuDao;
import com.dao.RoleDao;
import com.jdbc.PageUtil;

@WebServlet("/RoleServlet.do")
public class RoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RoleDao roleDao = new RoleDao();
	private MenuDao menuDao = new MenuDao();
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String flag=request.getParameter("flag");
		
		if("manage".equals(flag)) {
			manage(request,response);
		}else if("roleAllot".equals(flag)) {
			roleAllot(request,response);
		}else if("updateRole".equals(flag)) {
			updateRole(request,response);
		}else if("listadmin".equals(flag)) {
			listadmin(request,response);
		}else if("roleAllot2".equals(flag)) {
			roleAllot2(request,response);
		}else if("updateRole2".equals(flag)) {
			updateRole2(request,response);
		}else if("add".equals(flag)) {
			add(request,response);
		}else if("toUpdate".equals(flag)) {
			toUpdate(request,response);
		}else if("update".equals(flag)) {
			update(request,response);
		}else if("delete".equals(flag)) {
			delete(request,response);
		}
	}

	private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int roleId=Integer.parseInt(request.getParameter("roleId"));
		int count=(int) roleDao.getCountByRole(roleId);
		//判断count如果大于0，则此角色还有用户绑定
		if(count!=0) {
			response.getWriter().print("0");
		}
		if(count==0) {
			roleDao.deleteRoleById(roleId);
			response.getWriter().print("1");
		}
	}

	//修改角色信息
	private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int roleId=Integer.parseInt(request.getParameter("roleId"));
		String roleName=request.getParameter("roleName");
		String des=request.getParameter("des");
		roleDao.updateRole(roleId, roleName, des);
		request.setAttribute("roleId", roleId);
		request.setAttribute("roleName", roleName);
		request.setAttribute("des", des);
		request.setAttribute("msg", "角色信息修改成功");
		request.getRequestDispatcher("/perm/role_update.jsp").forward(request, response);
	}

	//去往修改界面
	private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int roleId=Integer.parseInt(request.getParameter("roleId"));
		String roleName=request.getParameter("roleName");
		String des=request.getParameter("des");
		request.setAttribute("roleId", roleId);
		request.setAttribute("roleName", roleName);
		request.setAttribute("des", des);
		request.getRequestDispatcher("/perm/role_update.jsp").forward(request, response);
		
	}

	private void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String roleName=request.getParameter("roleName");
		String des=request.getParameter("des");
		roleDao.addRole(roleName,des);
		request.setAttribute("msg", "添加角色成功");
		request.setAttribute("roleName", roleName);
		request.setAttribute("des", des);
		request.getRequestDispatcher("/perm/role_add.jsp").forward(request, response);		
	}

	//处理管理员的角色分配
	private void updateRole2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		int roleId=Integer.parseInt(request.getParameter("roleId"));
		int adminId=Integer.parseInt(request.getParameter("adminId"));
		roleDao.updateAdminRole(roleId,adminId);
		request.setAttribute("msg", "角色授权成功");
		roleAllot2(request,response);
	}

	//进入管理员的角色分配界面
	private void roleAllot2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int adminId=Integer.parseInt(request.getParameter("adminId"));
		int roleId=request.getParameter("roleId")==""?0:Integer.parseInt(request.getParameter("roleId"));
		String adminName=request.getParameter("adminName");
		
		List<RoleInfo> roleList=roleDao.getRoleList();
		request.setAttribute("roleList", roleList);
		request.setAttribute("adminId", adminId);
		request.setAttribute("roleId", roleId);
		request.setAttribute("adminName", adminName);
		request.getRequestDispatcher("/perm/role_allot2.jsp").forward(request, response);
	}

	//用户角色管理界面
	private void listadmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pageIndex=request.getParameter("pageIndex")==null?1:Integer.parseInt(request.getParameter("pageIndex"));
		long rowCount=roleDao.getCount();
		
		PageInfo page=PageUtil.getPageInfo(10, pageIndex, rowCount);
		List<AdminInfo> adminList=roleDao.getAdminList(page);
		request.setAttribute("adminList", adminList);
		request.setAttribute("page", page);
		request.getRequestDispatcher("/perm/role_listadmin.jsp").forward(request, response);
		
	}

	//处理角色权限的分配
	private void updateRole(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int roleId=Integer.parseInt(request.getParameter("roleId"));
		String[] menuIdList=request.getParameterValues("ids");
		roleDao.updateRoleMenu(roleId,menuIdList);
		request.setAttribute("msg", "角色授权成功");
		roleAllot(request,response);
		
	}

	//进入角色权限管理界面
	private void roleAllot(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int roleId=Integer.parseInt(request.getParameter("roleId"));
		String roleName=request.getParameter("roleName");
		List<MenuInfo> menuList=menuDao.getMenuList(0); 
		//查出角色对应菜单id，拼成一个字符串
		String roleMenuIdStr=roleDao.getRoleMenuIdStr(roleId);

		request.setAttribute("menuList", menuList);
		request.setAttribute("roleId", roleId);
		request.setAttribute("roleName", roleName);
		request.setAttribute("roleMenuIdStr", roleMenuIdStr);
		request.getRequestDispatcher("/perm/role_allot.jsp").forward(request, response);
	}

	//角色管理界面
	private void manage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<RoleInfo> roleList=roleDao.getRoleList();
		request.setAttribute("roleList", roleList);
		request.getRequestDispatcher("/perm/role_manage.jsp").forward(request, response);
	}

}
