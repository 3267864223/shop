package com.beans;

import java.sql.Timestamp;

public class GoodsInfo {

	private int id;
	private String goodsName; //商品名称
	private String unit; //计量单位
	private float price; //商品价格
	private String des; //商品描述
	private String producter; //生产厂商
	private int bigCateId; //所属大分类
	private int smallCateId; //所属小分类
	private Timestamp editDate; //最后更新日期 ,数据库中的默认值为 CURRENT_TIMESTAMP
	private byte[] pictureData;  //用于存放图片数据
	
	//关联查询cateinfo中的cateName
	private String bigCateName;  //大分类名称
	private String smallCateName; //小分类名称
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	public String getProducter() {
		return producter;
	}
	public void setProducter(String producter) {
		this.producter = producter;
	}
	public int getBigCateId() {
		return bigCateId;
	}
	public void setBigCateId(int bigCateId) {
		this.bigCateId = bigCateId;
	}
	public int getSmallCateId() {
		return smallCateId;
	}
	public void setSmallCateId(int smallCateId) {
		this.smallCateId = smallCateId;
	}
	public Timestamp getEditDate() {
		return editDate;
	}
	public void setEditDate(Timestamp editDate) {
		this.editDate = editDate;
	}
	public byte[] getPictureData() {
		return pictureData;
	}
	public void setPictureData(byte[] pictureData) {
		this.pictureData = pictureData;
	}
	public String getBigCateName() {
		return bigCateName;
	}
	public void setBigCateName(String bigCateName) {
		this.bigCateName = bigCateName;
	}
	public String getSmallCateName() {
		return smallCateName;
	}
	public void setSmallCateName(String smallCateName) {
		this.smallCateName = smallCateName;
	}
	
}
