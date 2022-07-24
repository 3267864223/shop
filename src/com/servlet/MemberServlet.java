package com.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.beans.MemberInfo;
import com.beans.PageInfo;
import com.dao.MemberDao;
import com.jdbc.PageUtil;

@WebServlet("/MemberServlet.do")
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberDao memberDao = new MemberDao();
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String flag=request.getParameter("flag");
		
		if("manage".equals(flag)) {
			manage(request,response);
		}else if("info".equals(flag)) {
			info(request,response);
		}else if("del".equals(flag)) {
			del(request,response);
		}else if("delAll".equals(flag)) {
			delAll(request,response);
		}
		
	}

	private void delAll(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String IdList=request.getParameter("arrId");
		memberDao.delAll(IdList);
		response.getWriter().print("删除成功");
	}

	private void del(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int memberId=Integer.parseInt(request.getParameter("memberId"));
		memberDao.delMemberById(memberId);
		response.getWriter().print("会员已删除");
	}

	private void info(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberId=Integer.parseInt(request.getParameter("memberId"));
		MemberInfo member=memberDao.getMemberById(memberId);
		request.setAttribute("member", member);
		request.getRequestDispatcher("/member/member_info.jsp").forward(request, response);
	}

	private void manage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pageIndex=request.getParameter("pageIndex")==null?1:Integer.parseInt(request.getParameter("pageIndex"));
		String memberNo=request.getParameter("memberNo");
		String stratDate=request.getParameter("stratDate");
		String endDate=request.getParameter("endDate");
		
		long rowCount=memberDao.getMemberCount(memberNo,stratDate,endDate);
		PageInfo page=PageUtil.getPageInfo(10, pageIndex, rowCount);
		List<MemberInfo> memberList= memberDao.getMemberList(memberNo,stratDate,endDate,page);
		request.setAttribute("memberList", memberList);
		request.setAttribute("page", page);
		request.setAttribute("memberNo", memberNo);
		request.setAttribute("stratDate", stratDate);
		request.setAttribute("endDate", endDate);
		
		request.getRequestDispatcher("/member/member_manage.jsp").forward(request, response);
	}

}
