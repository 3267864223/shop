package com.dao;

import java.util.List;

import com.beans.GoodsInfo;
import com.beans.PageInfo;
import com.jdbc.DBUtil;

public class GoodsDao {
	
	//根据条件获取商品数量（分页）
	public long getGoodsCount(int bigCateId,int smallCateId,String goodsName) {
		String sql="select count(*) from goodsinfo where 1=1";
		if(bigCateId!=0){
			sql+=" and bigCateId="+bigCateId;
		}
		if(smallCateId!=0) {
			sql+=" and smallCateId="+smallCateId;
		}
		if(goodsName!=null&&goodsName!="") {
			sql+=" and goodsName like '%"+goodsName+"%'";
		}
		return DBUtil.getScalar(sql);
	}

	public void add(GoodsInfo goods) {
		DBUtil.update("insert into goodsinfo(goodsName,bigCateId,smallCateId,price,des,unit,producter,pictureData) values(?,?,?,?,?,?,?,?)", goods.getGoodsName(),goods.getBigCateId(),goods.getSmallCateId(),goods.getPrice(),goods.getDes(),goods.getUnit(),goods.getProducter(),goods.getPictureData());	
	}

	//根据条件获取商品list（分页）
	public List<GoodsInfo> getGoodsList(int bigCateId, int smallCateId, String goodsName, PageInfo page) {
		String sql="select temp.*,b.cateName as smallCateName from "
				+"(select a.*,b.cateName as bigCateName from goodsinfo a left join cateinfo b on a.bigCateId=b.id) temp " 
				+" left join cateinfo b on temp.smallCateId=b.id where 1=1 ";
		if(bigCateId!=0){
			sql+=" and bigCateId="+bigCateId;
		}
		if(smallCateId!=0) {
			sql+=" and smallCateId="+smallCateId;
		}
		if(goodsName!=null&&goodsName!="") {
			sql+=" and goodsName like '%"+goodsName+"%'";
		}
		sql+=" order by editDate desc limit ?,?";
		return DBUtil.getList(sql, GoodsInfo.class, page.getBeginRow(),page.getPageSize());
	}

	public GoodsInfo getGoodsById(int goodsId) {
		return DBUtil.getSingleObj("select * from goodsinfo where id=?", GoodsInfo.class, goodsId);
	}
	
	//获取自增主键id
	public long getGoodsAutoId() {
		return DBUtil.getScalar("select @@identity");
	}

	public void delGoodsById(int goodsId) {
		DBUtil.update("delete from goodsinfo where id=?", goodsId);
		
	}

	public void update(int goodsId, GoodsInfo goods) {
		String sql="update goodsinfo set goodsName=?,bigCateId=?,smallCateId=?,price=?,des=?,unit=?,producter=?,pictureData=? where id=?";
		DBUtil.update(sql, goods.getGoodsName(),goods.getBigCateId(),goods.getSmallCateId(),goods.getPrice(),goods.getDes(),goods.getUnit(),goods.getProducter(),goods.getPictureData(),goodsId);
	}
	
	//删除所选商品
	public void delAll(String idList) {
		String[] arrId=idList.split(",");
		for(int i=0;i<arrId.length;i++) {
			DBUtil.update("delete from goodsinfo where id=?", arrId[i]);
		}
	}

}
