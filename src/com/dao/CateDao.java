package com.dao;

import java.util.List;

import com.beans.CateInfo;
import com.jdbc.DBUtil;

public class CateDao {

	//获取一级分类list（parentId为0）
	public List<CateInfo> getCateList1(){
		return DBUtil.getList("select * from cateinfo where parentId=0",CateInfo.class);
	}

	//获取二级分类list（parentId为一级菜单的id）
    public List<CateInfo> getCateList2(int parentId){
        return DBUtil.getList("select * from cateinfo where parentId=?",CateInfo.class,parentId);
    }

    //获取一级分类和与之对应的二级分类list
	public List<CateInfo> getCateList(Integer parentId) {
		List<CateInfo> cateList=DBUtil.getList("select * from cateinfo where parentId=?", CateInfo.class, parentId);
		
		for(CateInfo c:cateList) {
			if(c.getParentId()==0) {
				c.setSubCateList(getCateList(c.getId()));
			}
		}
		
		return cateList;
	}

	//修改一级分类
	public void update1(int cateId, String cateName, String des) {
		DBUtil.update("update cateinfo set cateName=?,des=? where id=?", cateName,des,cateId);
		
	}

	//根据分类id获取分类信息
	public CateInfo getCateById(int cateId) {
		return DBUtil.getSingleObj("select * from cateinfo where id=?", CateInfo.class, cateId);
	}

	//获取当前分类的parentId
	public int getPid(int cateId) {
		return DBUtil.getScalar("select parentId from cateinfo where id=?", cateId);
	}

	//修改二级分类
	public void update2(int cateId, String cateName, String des, int parentId) {
		DBUtil.update("update cateinfo set cateName=?,des=?,parentId=? where id=?", cateName,des,parentId,cateId);
		
	}

	//主要用于获取一级分类下二级分类的数量
	public long getCountByPid(int cateId) {
		return DBUtil.getScalar("select count(*) from cateinfo where parentId=?", cateId);
	}

	public void del1(int cateId) {
		DBUtil.update("delete from cateinfo where id=?", cateId);
	}

	//关联goodsinfo获取二级分类下商品的数量
	public long getCountByGoods(int cateId) {
		String sql="select count(*) from (select b.smallCateId,a.id from cateinfo a join goodsinfo b on a.id=b.smallCateId)temp where id=?";
		return DBUtil.getScalar(sql, cateId);
	}

	//添加一级分类
	public void add1(String cateName, String des) {
		String sql="insert into cateinfo(cateName,des,parentId) values(?,?,0)";
		DBUtil.update(sql, cateName,des);
		
	}

	//添加二级分类
	public void add2(String cateName, String des, int parentId) {
		String sql="insert into cateinfo(cateName,des,parentId) values(?,?,?)";
		DBUtil.update(sql, cateName,des,parentId);
		
	}
}
