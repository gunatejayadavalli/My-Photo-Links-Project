package com.i_am_guna.entity;

import java.util.Date;
import java.util.List;

public class LoginSuccessData {
	private String firstName;
	private String lastName;
	private String emailId;
	private String blockFlag;
	private String blockReason;
	private String token;
	private Date loggedInDate;
	private Date loginExpireDate;
	private List<String> roles;
	private List<String> tags;
	public LoginSuccessData() {
	}
	public LoginSuccessData(String firstName, String lastName, String emailId, String blockFlag, String blockReason,List<String> roles, List<String> tags) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.emailId = emailId;
		this.blockFlag = blockFlag;
		this.blockReason = blockReason;
		this.roles = roles;
		this.tags = tags;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getBlockFlag() {
		return blockFlag;
	}
	public void setBlockFlag(String blockFlag) {
		this.blockFlag = blockFlag;
	}
	public String getBlockReason() {
		return blockReason;
	}
	public void setBlockReason(String blockReason) {
		this.blockReason = blockReason;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public Date getLoggedInDate() {
		return loggedInDate;
	}
	public void setLoggedInDate(Date loggedInDate) {
		this.loggedInDate = loggedInDate;
	}
	public Date getLoginExpireDate() {
		return loginExpireDate;
	}
	public void setLoginExpireDate(Date loginExpireDate) {
		this.loginExpireDate = loginExpireDate;
	}
	public List<String> getRoles() {
		return roles;
	}
	public void setRoles(List<String> roles) {
		this.roles = roles;
	}
	public List<String> getTags() {
		return tags;
	}
	public void setTags(List<String> tags) {
		this.tags = tags;
	}
	@Override
	public String toString() {
		return "LoginSuccessData [firstName=" + firstName + ", lastName=" + lastName + ", emailId=" + emailId
				+ ", blockFlag=" + blockFlag + ", blockReason=" + blockReason + ", token=" + token + ", loggedInDate="
				+ loggedInDate + ", loginExpireDate=" + loginExpireDate + ", roles=" + roles + ", tags=" + tags + "]";
	}
}
