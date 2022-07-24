package com.dao;

import java.util.List;

import com.beans.AdminInfo;
import com.beans.PageInfo;
import com.jdbc.DBUtil;

public class AdminDao {
	
	/**
	 * 	登录，查询状态不为0的用户
	 * @param adminName
	 * @param password
	 * @return AdminInfo
	 */
	public AdminInfo login(String adminName,String password){
		return DBUtil.getSingleObj("select * from adminInfo where adminName=? and password=? and state!=0 limit 1", AdminInfo.class, adminName,password);
	}

	//根据用户账号获取用户信息
	public AdminInfo getAdminByName(String adminName) {
		return DBUtil.getSingleObj("select * from admininfo where adminName=?", AdminInfo.class, adminName);
	}

	//添加用户，默认state为1正常
	public void addAdmin(String note, String password, String adminName) {
		DBUtil.update("insert into admininfo(note,password,adminName,state) values(?,?,?,1)",note,password,adminName);
		
	}

	//获取state不为0（以删除）的用户数量
	public long getAdminCount() {
		return DBUtil.getScalar("select count(*) from admininfo where state!=0");
	}

	//获取state不为0的用户list，分页查询
	public List<AdminInfo> getAdminList(PageInfo page) {
		return DBUtil.getList("select * from admininfo where state!=0 limit ?,?",AdminInfo.class, page.getBeginRow(), page.getPageSize());
	}

	//设置用户的state为2，锁定用户
	public void lockAdmin(int adminId) {
		DBUtil.update("update admininfo set state=2 where id=?", adminId);
		
	}

	//解锁用户，将state置为1
	public void unlockAdmin(int adminId) {
		DBUtil.update("update admininfo set state=1 where id=?", adminId);
		
	}

	//根据id删除用户（将state置位0）
	public void delAdmin(int adminId) {
		DBUtil.update("update admininfo set state=0 where id=?", adminId);
		
	}

	//修改用户的备注
	public void updateAdmin(String adminName, String note) {
		DBUtil.update("update admininfo set note=? where adminName=?", note,adminName);
		
	}

	//修改用户密码
	public void editPwd(String adminName, String password) {
		DBUtil.update("update admininfo set password=? where adminName=?", password,adminName);
		
	}
	
	//删除所选用户（状态改为0）
	public void delAll(String idList) {
		String[] arrId=idList.split(",");
		for(int i=0;i<arrId.length;i++) {
			DBUtil.update("update admininfo set state='0' where id=?", arrId[i]);
		}
	}

}
