package com.servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.beans.OrderGoodsInfo;
import com.beans.OrderInfo;
import com.beans.PageInfo;
import com.dao.OrderDao;
import com.jdbc.PageUtil;

@WebServlet("/OrderServlet.do")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	OrderDao orderDao=new OrderDao();

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String flag=request.getParameter("flag");
		
		if("manage".equals(flag)) {
			manage(request,response);
		}else if("info".equals(flag)) {
			info(request,response);
		}else if("send".equals(flag)) {
			send(request,response);
		}else if("delAll".equals(flag)) {
			delAll(request,response);
		}
		
	}

	private void delAll(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String IdList=request.getParameter("arrId");
		orderDao.delAll(IdList);
		response.getWriter().print("删除成功");
	}

	//发货操作
	private void send(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int orderId=Integer.parseInt(request.getParameter("orderId"));
		Date date = new Date(System.currentTimeMillis());
		orderDao.send(orderId,date);
		response.getWriter().print("订单已发货");
		
	}

	//显示详情信息
	private void info(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int orderId=Integer.parseInt(request.getParameter("orderId"));
		List<OrderGoodsInfo> ogList=orderDao.getOgList(orderId);
		OrderInfo order= orderDao.getOrderById(orderId);
		request.setAttribute("ogList", ogList);
		request.setAttribute("order", order);
		request.getRequestDispatcher("/order/order_info.jsp").forward(request, response);
		
	}

	private void manage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pageIndex=request.getParameter("pageIndex")==null?1:Integer.parseInt(request.getParameter("pageIndex"));
		String orderNo=request.getParameter("orderNo");
		String stratDate=request.getParameter("stratDate");
		String endDate=request.getParameter("endDate");
		int orderState=request.getParameter("orderState")==null?0:Integer.parseInt(request.getParameter("orderState"));
		
		long rowCount=orderDao.getOrderCount(orderNo,stratDate,endDate,orderState);
		PageInfo page=PageUtil.getPageInfo(10, pageIndex, rowCount);
		List<OrderInfo> orderList= orderDao.getOrderList(orderNo,stratDate,endDate,orderState,page);
		request.setAttribute("orderList",orderList);
		request.setAttribute("page", page);
		request.setAttribute("orderNo", orderNo);
		request.setAttribute("stratDate", stratDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("orderState", orderState);
		request.getRequestDispatcher("/order/order_manage.jsp").forward(request, response);
		
	}

}
