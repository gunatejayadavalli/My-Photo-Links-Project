package com.i_am_guna.entity;

import java.util.Arrays;
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
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonProperty.Access;

@Entity
@Table(name = "photo_links")
public class PhotoLink {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="event_id")
	private int eventId;
	
	@Column(name="event")
	private String event;
	
	@Column(name="from_date")
	private Date fromDate;
	
	@Column(name="to_date")
	private Date toDate;
	
	@Column(name="photos_link")
	private String photosLink;
	
	@Column(name="creation_time")
	@CreationTimestamp
	private Date creationTime;
	
	@Column(name="created_by")
	private String createdBy;
	
	@Column(name="updation_time")
	@UpdateTimestamp
	private Date updationTime;
	
	@Column(name="updated_by")
	private String updatedBy;
	
	@Transient
	private String tagIDs;
	
	@Transient
	private String tagNames;
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = {CascadeType.DETACH,CascadeType.MERGE,CascadeType.PERSIST,CascadeType.REFRESH})
	@JoinTable(name = "photolinks_tags", 
	joinColumns = {@JoinColumn(name = "event_id")}, 
	inverseJoinColumns = {@JoinColumn(name = "tag_id")})
	private Collection<Tag> tags;
	
	@Transient
	private int tagids[];

	public PhotoLink() {
	}

	public PhotoLink(String event, Date fromDate, Date toDate, String photosLink, Date creationTime, String createdBy,
			Date updationTime, String updatedBy) {
		this.event = event;
		this.fromDate = fromDate;
		this.toDate = toDate;
		this.photosLink = photosLink;
		this.creationTime = creationTime;
		this.createdBy = createdBy;
		this.updationTime = updationTime;
		this.updatedBy = updatedBy;
	}

	public PhotoLink(String event, Date fromDate, Date toDate, String photosLink, String createdBy, String updatedBy) {
		this.event = event;
		this.fromDate = fromDate;
		this.toDate = toDate;
		this.photosLink = photosLink;
		this.createdBy = createdBy;
		this.updatedBy = updatedBy;
	}


	public PhotoLink(int eventId, String event, Date fromDate, Date toDate, String photosLink, Date creationTime,
			String createdBy, Date updationTime, String updatedBy) {
		this.eventId = eventId;
		this.event = event;
		this.fromDate = fromDate;
		this.toDate = toDate;
		this.photosLink = photosLink;
		this.creationTime = creationTime;
		this.createdBy = createdBy;
		this.updationTime = updationTime;
		this.updatedBy = updatedBy;
	}
	
	
	public PhotoLink(int eventId, String event, Date fromDate, Date toDate, String photosLink, Date creationTime,
			String createdBy, Date updationTime, String updatedBy, String tagIDs, String tagNames) {
		this.eventId = eventId;
		this.event = event;
		this.fromDate = fromDate;
		this.toDate = toDate;
		this.photosLink = photosLink;
		this.creationTime = creationTime;
		this.createdBy = createdBy;
		this.updationTime = updationTime;
		this.updatedBy = updatedBy;
		this.tagIDs = tagIDs;
		this.tagNames = tagNames;
	}

	public int getEventId() {
		return eventId;
	}

	public void setEventId(int eventId) {
		this.eventId = eventId;
	}

	public String getEvent() {
		return event;
	}

	public void setEvent(String event) {
		this.event = event;
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

	public String getPhotosLink() {
		return photosLink;
	}

	public void setPhotosLink(String photosLink) {
		this.photosLink = photosLink;
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

	public Collection<Tag> getTags() {
		return tags;
	}

	public void setTags(Collection<Tag> tags) {
		this.tags = tags;
	}

	public int[] getTagids() {
		return tagids;
	}

	public void setTagids(int[] tagids) {
		this.tagids = tagids;
	}

	public String getTagIDs() {
		return tagIDs;
	}

	public void setTagIDs(String tagIDs) {
		this.tagIDs = tagIDs;
	}

	public String getTagNames() {
		return tagNames;
	}

	public void setTagNames(String tagNames) {
		this.tagNames = tagNames;
	}

	@Override
	public String toString() {
		return "PhotoLink [eventId=" + eventId + ", event=" + event + ", fromDate=" + fromDate + ", toDate=" + toDate
				+ ", photosLink=" + photosLink + ", creationTime=" + creationTime + ", createdBy=" + createdBy
				+ ", updationTime=" + updationTime + ", updatedBy=" + updatedBy + ", tagIDs=" + tagIDs + ", tagNames="
				+ tagNames + ", tags=" + tags + ", tagids=" + Arrays.toString(tagids) + "]";
	}

}
