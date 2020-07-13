package com.i_am_guna.entity;

import java.util.Collection;
import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "tags")
public class Tag {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="tag_id")
	private int tagId;
	
	@Column(name="tag_name")
	private String tagName;
	
	@Column(name="creation_time")
	@CreationTimestamp
	@JsonIgnore
	private Date creationTime;
	
	@Column(name="created_by")
	@JsonIgnore
	private String createdBy;
	
	@Column(name="updation_time")
	@UpdateTimestamp
	@JsonIgnore
	private Date updationTime;
	
	@Column(name="updated_by")
	@JsonIgnore
	private String updatedBy;
	
	@ManyToMany(fetch = FetchType.LAZY, cascade = {CascadeType.DETACH,CascadeType.MERGE,CascadeType.PERSIST,CascadeType.REFRESH})
	@JoinTable(name = "photolinks_tags", 
	joinColumns = {@JoinColumn(name = "tag_id")}, 
	inverseJoinColumns = {@JoinColumn(name = "event_id")})
	@JsonIgnore
	private Collection<PhotoLink> photoLinks;
	
	@ManyToMany(fetch = FetchType.LAZY, cascade = {CascadeType.DETACH,CascadeType.MERGE,CascadeType.PERSIST,CascadeType.REFRESH})
	@JoinTable(name = "users_tags", 
	joinColumns = {@JoinColumn(name = "tag_id")}, 
	inverseJoinColumns = {@JoinColumn(name = "user_id")})
	@JsonIgnore
	private Collection<User> users;
	
	public Tag() {
	}

	public Tag(String tagName, Date creationTime, String createdBy, Date updationTime, String updatedBy) {
		this.tagName = tagName;
		this.creationTime = creationTime;
		this.createdBy = createdBy;
		this.updationTime = updationTime;
		this.updatedBy = updatedBy;
	}

	public Tag(String tagName, String createdBy, String updatedBy) {
		this.tagName = tagName;
		this.createdBy = createdBy;
		this.updatedBy = updatedBy;
	}

	public int getTagId() {
		return tagId;
	}

	public void setTagId(int tagId) {
		this.tagId = tagId;
	}

	public String getTagName() {
		return tagName;
	}

	public void setTagName(String tagName) {
		this.tagName = tagName;
	}

	public Date getCreationTime() {
		return creationTime;
	}

	public void setCreationTime(Date creationTime) {
		this.creationTime = creationTime;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public Date getUpdationTime() {
		return updationTime;
	}

	public void setUpdationTime(Date updationTime) {
		this.updationTime = updationTime;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

	public Collection<PhotoLink> getPhotoLinks() {
		return photoLinks;
	}

	public void setPhotoLinks(Collection<PhotoLink> photoLinks) {
		this.photoLinks = photoLinks;
	}

	public Collection<User> getUsers() {
		return users;
	}

	public void setUsers(Collection<User> users) {
		this.users = users;
	}

	@Override
	public String toString() {
		return "Tag [tagId=" + tagId + ", tagName=" + tagName + ", creationTime=" + creationTime + ", createdBy="
				+ createdBy + ", updationTime=" + updationTime + ", updatedBy=" + updatedBy + ", photoLinks="
				+ photoLinks + ", users=" + users + "]";
	}

}
