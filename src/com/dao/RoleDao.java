package com.dao;

import java.util.List;

import com.beans.AdminInfo;
import com.beans.PageInfo;
import com.beans.RoleInfo;
import com.jdbc.DBUtil;

public class RoleDao {

	
	public List<RoleInfo> getRoleList(){
		return DBUtil.getList("select * from roleinfo",RoleInfo.class);
	}

	public String getRoleMenuIdStr(int roleId) {
		List<Integer> menuIdList=DBUtil.getColumn("select menuId from roleMenu where roleId=?", roleId);
		String str="";
		for(int i=0;i<menuIdList.size();i++) {
			if(i<menuIdList.size()-1) {
				str+=menuIdList.get(i)+",";
			}else {
				str+=menuIdList.get(i);
			}
		}
		return str;
	}
	

	public void updateRoleMenu(int roleId, String[] menuIdList) {
	
		//先删除原有菜单
		DBUtil.update("delete from roleMenu where roleId=?", roleId);
		
		//再添加新菜单
		for(String menuId:menuIdList) {
			DBUtil.update("insert into roleMenu(roleId,menuId) values(?,?)", roleId,menuId);
		}
		
		
	}

	//关联roleinfo中的roleName获取用户list
	public List<AdminInfo> getAdminList(PageInfo page) {
		String sql="select a.id,a.adminName,a.state,a.roleId,b.roleName,a.editDate from admininfo a left join roleinfo b on a.roleId=b.id where a.state!=0 limit ?,?";
		return DBUtil.getList(sql, AdminInfo.class,page.getBeginRow(),page.getPageSize());
	}

	public long getCount() {
		String sql="select count(*) from admininfo where state!=0";
		return DBUtil.getScalar(sql);
	}

	//修改用户角色
	public void updateAdminRole(int roleId,int adminId) {
		String sql="update admininfo set roleId=? where id=?";
		DBUtil.update(sql,roleId,adminId);
		
	}

	public void addRole(String roleName, String des) {
		DBUtil.update("insert into roleinfo(roleName,des) values(?,?)", roleName,des);
		
	}

	public void updateRole(int roleId, String roleName, String des) {
		DBUtil.update("update roleinfo set roleName=?,des=? where id=?", roleName,des,roleId);
		
	}

	public void deleteRoleById(int roleId) {
		DBUtil.update("delete from roleinfo where id=?", roleId);
		
	}

	//获取角色关联用户数量
	public long getCountByRole(int roleId) {
		String sql="select count(*) from (select a.roleId,b.id from admininfo a join roleinfo b on a.roleId=b.id)temp where id=?";
		return DBUtil.getScalar(sql, roleId);
	}

}
