package com.beans;

import java.util.List;

public class CateInfo {

	private Integer id;
	private String cateName;
	private String des;
	private Integer parentId;
	
	private List<CateInfo> subCateList; //每个一级分类的子分类
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCateName() {
		return cateName;
	}
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public List<CateInfo> getSubCateList() {
		return subCateList;
	}
	public void setSubCateList(List<CateInfo> subCateList) {
		this.subCateList = subCateList;
	}

}
