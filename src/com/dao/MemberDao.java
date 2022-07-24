package com.dao;

import java.util.List;

import com.beans.MemberInfo;
import com.beans.PageInfo;
import com.jdbc.DBUtil;

public class MemberDao {

	//根据条件获取会员数量（分页）
	public long getMemberCount(String memberNo, String stratDate, String endDate) {
		String sql="select count(*) from memberinfo where 1=1";
		if(memberNo!=null&&memberNo!=""){
			sql+=" and memberNo='"+memberNo+"'";
		}
		if(stratDate!=null&&stratDate!="") {
			sql+=" and registerDate > '"+stratDate+"'";
		}
		if(endDate!=null&&endDate!="") {
			sql+=" and registerDate < '"+endDate+"'";
		}
		return DBUtil.getScalar(sql);
	}

	//根据条件获取会员list（分页）
	public List<MemberInfo> getMemberList(String memberNo, String stratDate, String endDate, PageInfo page) {
		String sql="select * from memberinfo where 1=1";
		if(memberNo!=null&&memberNo!=""){
			sql+=" and memberNo='"+memberNo+"'";
		}
		if(stratDate!=null&&stratDate!="") {
			sql+=" and registerDate > '"+stratDate+"'";
		}
		if(endDate!=null&&endDate!="") {
			sql+=" and registerDate < '"+endDate+"'";
		}
		sql+=" limit ?,?";
		return DBUtil.getList(sql, MemberInfo.class, page.getBeginRow(),page.getPageSize());
	}

	public MemberInfo getMemberById(int memberId) {
		return DBUtil.getSingleObj("select * from memberinfo where id=?",MemberInfo.class, memberId);
	}

	public void delMemberById(int memberId) {
		DBUtil.update("delete from memberinfo where id=?", memberId);
		
	}

	public void delAll(String idList) {
		String[] arrId=idList.split(",");
		for(int i=0;i<arrId.length;i++) {
			DBUtil.update("delete from memberinfo where id=?", arrId[i]);
		}
	}


}
