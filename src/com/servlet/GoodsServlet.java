package com.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.beans.GoodsInfo;
import com.beans.PageInfo;
import com.dao.GoodsDao;
import com.jdbc.PageUtil;

@WebServlet("/GoodsServlet.do") @MultipartConfig
public class GoodsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	GoodsDao goodsDao = new GoodsDao();

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String flag=request.getParameter("flag");
		
		if("add".equals(flag)) {
			add(request,response);
		}
		else if("manage".equals(flag)) {
			manage(request,response);
		}else if("showPicture".equals(flag)) {
			showPicture(request,response);
		}else if("showp".equals(flag)) {
			showp(request,response);
		}else if("delete".equals(flag)) {
			delete(request,response);
		}else if("toupdate".equals(flag)) {
			toupdate(request,response);
		}else if("update".equals(flag)) {
			update(request,response);
		}else if("delAll".equals(flag)) {
			delAll(request,response);
		}
		
	}

	private void delAll(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String IdList=request.getParameter("arrId");
		goodsDao.delAll(IdList);
		response.getWriter().print("删除成功");
		
	}

	private void update(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		int goodsId=Integer.parseInt(request.getParameter("goodsId"));
		String goodsName=request.getParameter("goodsName");
  		int bigCateId=Integer.parseInt(request.getParameter("bigCateId"));
		int smallCateId=Integer.parseInt(request.getParameter("smallCateId"));
		float price=Float.parseFloat(request.getParameter("price"));
		String des=request.getParameter("des");
		String unit=request.getParameter("unit");
		String producter=request.getParameter("producter");
		//得到上传的图片的数据,把它放到字节数组中
		Part part=request.getPart("picture");
		
		InputStream in =part.getInputStream();
		
		byte [] pictureData=new byte [in.available()];
		
		in.read(pictureData);
		
		GoodsInfo goods=new GoodsInfo();
		goods.setId(goodsId);
		goods.setGoodsName(goodsName);
		goods.setBigCateId(bigCateId);
		goods.setSmallCateId(smallCateId);
		goods.setPrice(price);
		goods.setDes(des);
		goods.setUnit(unit);
		goods.setProducter(producter);
		goods.setPictureData(pictureData);

		goodsDao.update(goodsId,goods);
		request.setAttribute("msg", "商品信息修改成功");
		request.setAttribute("goods", goods);

		request.getRequestDispatcher("goods/goods_update.jsp").forward(request, response);
	}

	private void toupdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int goodsId=Integer.parseInt(request.getParameter("goodsId"));
		GoodsInfo goods=goodsDao.getGoodsById(goodsId);
		request.setAttribute("goods", goods);
		request.getRequestDispatcher("/goods/goods_update.jsp").forward(request, response);
		
	}

	private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int goodsId=Integer.parseInt(request.getParameter("goodsId"));
		goodsDao.delGoodsById(goodsId);
		response.getWriter().print("商品已删除");
		
	}

	//显示图片
	private void showp(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int goodsId=Integer.parseInt(request.getParameter("goodsId"));
		GoodsInfo goods=goodsDao.getGoodsById(goodsId);
  		response.setContentType("image/jpg");
  		ServletOutputStream outstream=response.getOutputStream();
  		outstream.write(goods.getPictureData());
  		outstream.flush();
	}

	//预览图片
	private void showPicture(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int goodsAutoId=(int)goodsDao.getGoodsAutoId();
		if(goodsAutoId!=0) {
			GoodsInfo goods=  goodsDao.getGoodsById(goodsAutoId);
	  		response.setContentType("image/jpg");
	  		ServletOutputStream outstream=response.getOutputStream();
	  		outstream.write(goods.getPictureData());
	  		outstream.flush();
		}
	}

	private void manage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bigCateId=request.getParameter("bigCateId")==null?0:Integer.parseInt(request.getParameter("bigCateId"));
		int smallCateId=request.getParameter("smallCateId")==null?0:Integer.parseInt(request.getParameter("smallCateId"));
		int pageIndex=request.getParameter("pageIndex")==null?1:Integer.parseInt(request.getParameter("pageIndex"));
		String goodsName=request.getParameter("goodsName"); 
		
		long rowCount=goodsDao.getGoodsCount(bigCateId,smallCateId,goodsName);
		
		PageInfo page=PageUtil.getPageInfo(10, pageIndex, rowCount);
		List<GoodsInfo> goodsList= goodsDao.getGoodsList(bigCateId,smallCateId,goodsName,page);
		request.setAttribute("goodsList", goodsList);
		request.setAttribute("page", page);
		request.setAttribute("bigCateId", bigCateId);
		request.setAttribute("smallCateId", smallCateId);
		request.setAttribute("goodsName", goodsName);
		
		request.getRequestDispatcher("/goods/goods_manage.jsp").forward(request, response);
	}

	private void add(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String goodsName=request.getParameter("goodsName");
		int bigCateId=Integer.parseInt(request.getParameter("bigCateId"));
		int smallCateId=Integer.parseInt(request.getParameter("smallCateId"));
		float price=Float.parseFloat(request.getParameter("price"));
		String des=request.getParameter("des");
		String unit=request.getParameter("unit");
		String producter=request.getParameter("producter");
		
		
		//得到上传的图片的数据,把它放到字节数组中
		Part part=request.getPart("picture");
		
		InputStream in =part.getInputStream();
		
		byte [] pictureData=new byte [in.available()];
		
		in.read(pictureData);
		
		GoodsInfo goods=new GoodsInfo();
		goods.setGoodsName(goodsName);
		goods.setBigCateId(bigCateId);
		goods.setSmallCateId(smallCateId);
		goods.setPrice(price);
		goods.setDes(des);
		goods.setUnit(unit);
		goods.setProducter(producter);
		goods.setPictureData(pictureData);

		goodsDao.add(goods);
		
		request.setAttribute("msg", "商品添加成功");
		request.setAttribute("goods", goods);
		request.setAttribute("bigCateId", goods.getBigCateId());
		request.setAttribute("smallCateId", goods.getSmallCateId());
		request.getRequestDispatcher("goods/goods_add.jsp").forward(request, response);
		
	}

}
