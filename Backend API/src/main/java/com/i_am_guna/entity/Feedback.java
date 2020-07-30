package com.i_am_guna.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name="feedbacks")
public class Feedback {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="feedback_id")
	private int feedbackId;
	
	@Column(name="user_id")
	private int userId;

	@Column(name="feedback_type")
	private String feedbackType;

	@Column(name="feedback_msg")
	private String feedbackMsg;

	@Column(name="submitted_date")
	@CreationTimestamp
	private Date submittedDate;

	@Column(name="submitted_by")
	private String submittedBy;
	
	@Column(name="read_date")
	private Date readDate;
	
	@Column(name="read_by")
	private String readBy;
	
	@Column(name="resolved_date")
	private Date resolvedDate;
	
	@Column(name="resolved_by")
	private String resolvedBy;
	
	@Column(name="resolution_msg")
	private String resolutionMsg;

	public Feedback() {
	}

	public Feedback(int userId, String feedbackType, String feedbackMsg, Date submittedDate, String submittedBy,
			Date readDate, String readBy, Date resolvedDate, String resolvedBy, String resolutionMsg) {
		this.userId = userId;
		this.feedbackType = feedbackType;
		this.feedbackMsg = feedbackMsg;
		this.submittedDate = submittedDate;
		this.submittedBy = submittedBy;
		this.readDate = readDate;
		this.readBy = readBy;
		this.resolvedDate = resolvedDate;
		this.resolvedBy = resolvedBy;
		this.resolutionMsg = resolutionMsg;
	}

	public int getFeedbackId() {
		return feedbackId;
	}

	public void setFeedbackId(int feedbackId) {
		this.feedbackId = feedbackId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getFeedbackType() {
		return feedbackType;
	}

	public void setFeedbackType(String feedbackType) {
		this.feedbackType = feedbackType;
	}

	public String getFeedbackMsg() {
		return feedbackMsg;
	}

	public void setFeedbackMsg(String feedbackMsg) {
		this.feedbackMsg = feedbackMsg;
	}

	public Date getSubmittedDate() {
		return submittedDate;
	}

	public void setSubmittedDate(Date submittedDate) {
		this.submittedDate = submittedDate;
	}

	public String getSubmittedBy() {
		return submittedBy;
	}

	public void setSubmittedBy(String submittedBy) {
		this.submittedBy = submittedBy;
	}

	public Date getReadDate() {
		return readDate;
	}

	public void setReadDate(Date readDate) {
		this.readDate = readDate;
	}

	public String getReadBy() {
		return readBy;
	}

	public void setReadBy(String readBy) {
		this.readBy = readBy;
	}

	public Date getResolvedDate() {
		return resolvedDate;
	}

	public void setResolvedDate(Date resolvedDate) {
		this.resolvedDate = resolvedDate;
	}

	public String getResolvedBy() {
		return resolvedBy;
	}

	public void setResolvedBy(String resolvedBy) {
		this.resolvedBy = resolvedBy;
	}

	public String getResolutionMsg() {
		return resolutionMsg;
	}

	public void setResolutionMsg(String resolutionMsg) {
		this.resolutionMsg = resolutionMsg;
	}

	@Override
	public String toString() {
		return "Feedback [feedbackId=" + feedbackId + ", userId=" + userId + ", feedbackType=" + feedbackType
				+ ", feedbackMsg=" + feedbackMsg + ", submittedDate=" + submittedDate + ", submittedBy=" + submittedBy
				+ ", readDate=" + readDate + ", readBy=" + readBy + ", resolvedDate=" + resolvedDate + ", resolvedBy="
				+ resolvedBy + ", resolutionMsg=" + resolutionMsg + "]";
	}
	
}
