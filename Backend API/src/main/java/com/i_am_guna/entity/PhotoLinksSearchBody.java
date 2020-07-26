package com.i_am_guna.entity;

import java.util.Date;

public class PhotoLinksSearchBody {
	
	private String keyword;
	private Date fromDate;
	private Date toDate;
	private int selectedTag;
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public Date getFromDate() {
		return fromDate;
	}
	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}
	public Date getToDate() {
		return toDate;
	}
	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}
	public int getSelectedTag() {
		return selectedTag;
	}
	public void setSelectedTag(int selectedTag) {
		this.selectedTag = selectedTag;
	}
	@Override
	public String toString() {
		return "PhotoLinksSearchBody [keyword=" + keyword + ", fromDate=" + fromDate + ", toDate=" + toDate
				+ ", selectedTag=" + selectedTag + "]";
	}
}
