package com.i_am_guna.entity;

import java.util.Date;
import java.util.Collection;

public class LoginSuccessData {
	private int userId;
	private String firstName;
	private String lastName;
	private String emailId;
	private String blockFlag;
	private String blockReason;
	private String token;
	private Date loggedInDate;
	private Date tokenExpirationDate;
	private Collection<Role> roles;
	private Collection<Tag> tags;
	public LoginSuccessData() {
	}
	
	public LoginSuccessData(int userId, String firstName, String lastName, String emailId, String blockFlag, String blockReason,Collection<Role> roles, Collection<Tag> tags) {
		this.userId = userId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.emailId = emailId;
		this.blockFlag = blockFlag;
		this.blockReason = blockReason;
		this.roles = roles;
		this.tags = tags;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
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

	public Date getTokenExpirationDate() {
		return tokenExpirationDate;
	}

	public void setTokenExpirationDate(Date tokenExpirationDate) {
		this.tokenExpirationDate = tokenExpirationDate;
	}

	public Collection<Role> getRoles() {
		return roles;
	}

	public void setRoles(Collection<Role> roles) {
		this.roles = roles;
	}

	public Collection<Tag> getTags() {
		return tags;
	}

	public void setTags(Collection<Tag> tags) {
		this.tags = tags;
	}

	@Override
	public String toString() {
		return "LoginSuccessData [userId=" + userId + ", firstName=" + firstName + ", lastName=" + lastName
				+ ", emailId=" + emailId + ", blockFlag=" + blockFlag + ", blockReason=" + blockReason + ", token="
				+ token + ", loggedInDate=" + loggedInDate + ", tokenExpirationDate=" + tokenExpirationDate + ", roles="
				+ roles + ", tags=" + tags + "]";
	}
	
	
}
