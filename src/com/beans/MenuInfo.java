package com.beans;

import java.util.List;

public class MenuInfo {

	private Integer id;
	private String menuName;
	private String url;
	private String icon;
	private Integer parentId;
	private String target;
	private List<MenuInfo> subMenuList; //每个导航菜单的子菜单

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public List<MenuInfo> getSubMenuList() {
		return subMenuList;
	}

	public void setSubMenuList(List<MenuInfo> subMenuList) {
		this.subMenuList = subMenuList;
	}

}
