package com.dao;

import java.sql.Date;
import java.util.List;

import com.beans.OrderGoodsInfo;
import com.beans.OrderInfo;
import com.beans.PageInfo;
import com.jdbc.DBUtil;

public class OrderDao {

	public long getOrderCount(String orderNo, String stratDate, String endDate, int orderState) {
		String sql="select count(*) from orderinfo where 1=1";
		if(orderNo!=null&&orderNo!=""){
			sql+=" and orderNo='"+orderNo+"'";
		}
		if(stratDate!=null&&stratDate!="") {
			sql+=" and orderDate > '"+stratDate+"'";
		}
		if(endDate!=null&&endDate!="") {
			sql+=" and orderDate < '"+endDate+"'";
		}
		if(orderState==0) {
			sql+=" and 1=1";
		}
		if(orderState==1) {
			sql+=" and orderState='已支付'";
		}
		if(orderState==2) {
			sql+=" and orderState='已发货'";
		}
		if(orderState==3) {
			sql+=" and orderState='未付款'";
		}

		return DBUtil.getScalar(sql);
	}

	public List<OrderInfo> getOrderList(String orderNo, String stratDate, String endDate, int orderState,PageInfo page) {
		String sql="select * from orderinfo where 1=1";
		if(orderNo!=null&&orderNo!=""){
			sql+=" and orderNo='"+orderNo+"'";
		}
		if(stratDate!=null&&stratDate!="") {
			sql+=" and orderDate > '"+stratDate+"'";
		}
		if(endDate!=null&&endDate!="") {
			sql+=" and orderDate < '"+endDate+"'";
		}
		if(orderState==0) {
			sql+=" and 1=1";
		}
		if(orderState==1) {
			sql+=" and orderState='已支付'";
		}
		if(orderState==2) {
			sql+=" and orderState='已发货'";
		}
		if(orderState==3) {
			sql+=" and orderState='未付款'";
		}
		sql+=" limit ?,?";
		return DBUtil.getList(sql, OrderInfo.class, page.getBeginRow(),page.getPageSize());
	}

	//获得对应订单id所在的订单商品表
	public List<OrderGoodsInfo> getOgList(int orderId) {
		return DBUtil.getList("select * from ordergoods where orderId=?", OrderGoodsInfo.class, orderId);
	}

	public OrderInfo getOrderById(int orderId) {
		return DBUtil.getSingleObj("select a.*,b.id,b.memberNo from orderinfo a left join memberinfo b on a.memberId=b.id where a.id=?", OrderInfo.class, orderId);
	}

	public void send(int orderId, Date date) {
		DBUtil.update("update orderinfo set orderState='已发货',sendDate=? where id=?",date, orderId);
		
	}

	public void delAll(String idList) {
		String[] arrId=idList.split(",");
		for(int i=0;i<arrId.length;i++) {
			DBUtil.update("delete from orderinfo where id=?", arrId[i]);
		}
	}
}
