package com.i_am_guna.entity;

import javax.persistence.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import java.util.Collection;
import java.util.Date;

@Entity
@Table(name = "users")
@SqlResultSetMapping(
	    name = "photoLinksByUserNameDataMapping",
	    classes = @ConstructorResult(
	            targetClass = PhotoLink.class,
	            columns = {
	            		@ColumnResult(name = "eventId"),
	                    @ColumnResult(name = "event"),
	                    @ColumnResult(name = "fromDate"),
	                    @ColumnResult(name = "toDate"),
	                    @ColumnResult(name = "photosLink")
	            }
	    )
	)
@NamedNativeQuery(
		name = "findPhotoLinksByUserName", 
		query = "select distinct pl.event_id as eventId, pl.event as event, pl.from_date as fromDate, pl.to_date as toDate, pl.photos_link as photosLink from photo_links pl " + 
				"inner join photolinks_tags plt on plt.event_id = pl.event_id " + 
				"inner join users_tags ut on ut.tag_id = plt.tag_id " + 
				"inner join users u on u.user_id = ut.user_id " + 
				"where u.username = ?1 order by pl.from_date desc", 
		resultClass = PhotoLink.class, 
		resultSetMapping = "photoLinksByUserNameDataMapping")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "user_id")
	private int userId;

	@Column(name = "username")
	private String userName;

	@Column(name = "password")
	private String password;

	@Column(name = "first_name")
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

	@Column(name = "email")
	private String email;
	
	@Column(name = "security_ques")
	private String securityQues;
	
	@Column(name = "security_ans")
	private String securityAns;
	
	@Column(name = "block_flag")
	private String blockFlag;
	
	@Column(name = "block_reason")
	private String blockReason;
	
	@Column(name="creation_time")
	@CreationTimestamp
	private Date creationTime;
	
	@Column(name="updation_time")
	@UpdateTimestamp
	private Date updationTime;

	@ManyToMany(fetch = FetchType.EAGER, cascade = {CascadeType.DETACH,CascadeType.MERGE,CascadeType.PERSIST,CascadeType.REFRESH})
	@JoinTable(name = "users_roles", 
	joinColumns = {@JoinColumn(name = "user_id")}, 
	inverseJoinColumns = {@JoinColumn(name = "role_id")})
	private Collection<Role> roles;
	
	@ManyToMany(fetch = FetchType.LAZY, cascade = {CascadeType.DETACH,CascadeType.MERGE,CascadeType.PERSIST,CascadeType.REFRESH})
	@JoinTable(name = "users_tags", 
	joinColumns = {@JoinColumn(name = "user_id")}, 
	inverseJoinColumns = {@JoinColumn(name = "tag_id")})
	private Collection<Tag> tags;

	public User() {
	}

	public User(String userName, String password, String firstName, String lastName, String email, String securityQues,
			String securityAns, String blockFlag, String blockReason, Date creationTime, Date updationTime) {
		this.userName = userName;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.securityQues = securityQues;
		this.securityAns = securityAns;
		this.blockFlag = blockFlag;
		this.blockReason = blockReason;
		this.creationTime = creationTime;
		this.updationTime = updationTime;
	}

	public User(String userName, String password, String firstName, String lastName, String email, String securityQues,
			String securityAns, String blockFlag, String blockReason) {
		this.userName = userName;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.securityQues = securityQues;
		this.securityAns = securityAns;
		this.blockFlag = blockFlag;
		this.blockReason = blockReason;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSecurityQues() {
		return securityQues;
	}

	public void setSecurityQues(String securityQues) {
		this.securityQues = securityQues;
	}

	public String getSecurityAns() {
		return securityAns;
	}

	public void setSecurityAns(String securityAns) {
		this.securityAns = securityAns;
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

	public Date getCreationTime() {
		return creationTime;
	}

	public void setCreationTime(Date creationTime) {
		this.creationTime = creationTime;
	}

	public Date getUpdationTime() {
		return updationTime;
	}

	public void setUpdationTime(Date updationTime) {
		this.updationTime = updationTime;
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
		return "User [userId=" + userId + ", userName=" + userName + ", password=" + password + ", firstName="
				+ firstName + ", lastName=" + lastName + ", email=" + email + ", securityQues=" + securityQues
				+ ", securityAns=" + securityAns + ", blockFlag=" + blockFlag + ", blockReason=" + blockReason
				+ ", creationTime=" + creationTime + ", updationTime=" + updationTime + ", roles=" + roles + ", tags="
				+ tags + "]";
	}

}
