package com.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.beans.CateInfo;
import com.dao.CateDao;

import net.sf.json.JSONArray;

@WebServlet("/CateServlet.do")
public class CateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CateDao cateDao = new CateDao();
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        String flag=request.getParameter("flag");

        if("link1".equals(flag)){
            link1(request,response);
        }else if("link2".equals(flag)){
            link2(request,response);
        }else if("manage".equals(flag)) {
        	manage(request,response);
        }else if("toupdate1".equals(flag)) {
        	toupdate1(request,response);
        }else if("toupdate2".equals(flag)) {
        	toupdate2(request,response);
        }else if("update1".equals(flag)) {
        	update1(request,response);
        }else if("update2".equals(flag)) {
        	update2(request,response);
        }else if("del1".equals(flag)) {
        	del1(request,response);
        }else if("del2".equals(flag)) {
        	del2(request,response);
        }else if("add1".equals(flag)) {
        	add1(request,response);
        }else if("add2".equals(flag)) {
        	add2(request,response);
        }
	
	}
	
	private void add2(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String cateName=request.getParameter("cateName");
		String des=request.getParameter("des");
		int parentId=Integer.parseInt(request.getParameter("parentId"));
		cateDao.add2(cateName,des,parentId);
		response.getWriter().print("添加成功");
	}

	private void add1(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String cateName=request.getParameter("cateName");
		String des=request.getParameter("des");
		cateDao.add1(cateName,des);
		response.getWriter().print("添加成功");
	}

	private void del2(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int cateId=Integer.parseInt(request.getParameter("cateId"));
		int count=(int) cateDao.getCountByGoods(cateId);
		//判断count如果大于0，则此分类下还有商品
		if(count!=0) {
			response.getWriter().print("0");
		}
		if(count==0) {
			cateDao.del1(cateId);
			response.getWriter().print("1");
		}
	}

	private void del1(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int cateId=Integer.parseInt(request.getParameter("cateId"));
		//查询父级id是cateId的数量
		int count=(int) cateDao.getCountByPid(cateId);
		//判断count如果大于0，则此分类下还有子分类
		if(count!=0) {
			response.getWriter().print("0");
		}
		if(count==0) {
			cateDao.del1(cateId);
			response.getWriter().print("1");
		}
	}

	private void update2(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int cateId=Integer.parseInt(request.getParameter("cateId"));
		String cateName=request.getParameter("cateName");
		String des=request.getParameter("des");
		int parentId=Integer.parseInt(request.getParameter("parentId"));
		cateDao.update2(cateId,cateName,des,parentId);
		response.getWriter().print("修改成功");
		
	}

	private void update1(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int cateId=Integer.parseInt(request.getParameter("cateId"));
		String cateName=request.getParameter("cateName");
		String des=request.getParameter("des");
		cateDao.update1(cateId,cateName,des);
		response.getWriter().print("修改成功");
	}

	private void toupdate2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cateId=Integer.parseInt(request.getParameter("cateId"));
		CateInfo cate=cateDao.getCateById(cateId);
		int pid=cateDao.getPid(cateId);
		request.setAttribute("cate", cate);
		request.setAttribute("pid", pid);
		request.getRequestDispatcher("cate/cate_update2.jsp").forward(request, response);
	}
	
	private void toupdate1(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cateId=Integer.parseInt(request.getParameter("cateId"));
		String cateName=request.getParameter("cateName");
		String des=request.getParameter("des");
		request.setAttribute("cateId", cateId);
		request.setAttribute("cateName", cateName);
		request.setAttribute("des", des);
		request.getRequestDispatcher("cate/cate_update1.jsp").forward(request, response);
	}

	private void manage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<CateInfo> cateList=cateDao.getCateList(0); 
		request.setAttribute("cateList", cateList);
		request.getRequestDispatcher("cate/cate_manage.jsp").forward(request, response);
	}

	//查询二级分类以json返回
	private void link2(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int parentId=Integer.parseInt(request.getParameter("parentId"));
        List<CateInfo> cateList2=cateDao.getCateList2(parentId);
        JSONArray jsonArray2=JSONArray.fromObject(cateList2);
        response.getWriter().print(jsonArray2);

    }

	//查询一级分类以json返回
    private void link1(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<CateInfo> cateList1=cateDao.getCateList1();
        JSONArray jsonArray1=JSONArray.fromObject(cateList1);
        response.getWriter().print(jsonArray1);
    }

}
