package com.dao;

import java.util.List;
import com.beans.MenuInfo;
import com.jdbc.DBUtil;

public class MenuDao {

	/**
	 * 根据父级菜单id，查询子菜单
	 * @param parentId
	 * @return
	 */
	public List<MenuInfo> getMenuList(Integer parentId){
		List<MenuInfo> menuList=DBUtil.getList("select * from menuinfo where parentId=?", MenuInfo.class, parentId);
		
		for(MenuInfo m:menuList) {
			if(m.getParentId()==0) {
				m.setSubMenuList(getMenuList(m.getId()));
			}
		}
		
		return menuList;
	}
	
	//根据所选权限获取父子菜单
	public List<MenuInfo> getMenuList(int parentId,int roleId){		
		String sql="select * from menuInfo  where parentId=? and id in ( select menuId from  rolemenu where roleId=? )"; 
		List<MenuInfo> menuList=DBUtil.getList(sql, MenuInfo.class ,parentId,roleId);
		for(MenuInfo m:menuList) {
			if(m.getParentId()==0) {
				m.setSubMenuList(getMenuList(m.getId(),roleId));
			}
		}
		return menuList;
	}
}
