package com.i_am_guna.repository;

import java.util.Date;
import java.util.List;
import javax.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import com.i_am_guna.entity.PhotoLink;
import com.i_am_guna.entity.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User findByUserName(String username);
	
	List<User> findAll();
	
	@Query(name="findPhotoLinksByUserName",nativeQuery = true)
	List<PhotoLink> findPhotoLinksByUserName(String userName);
	
	@Query(name="findUserPhotoLinksByQuery",nativeQuery = true)
	List<PhotoLink> findUserPhotoLinksByQuery(String userName, String keyword, Date fromDate, Date toDate, String selectedTag);
	
	@Query("SELECT COUNT(u) FROM User u WHERE u.userName=?1")
    int checkUserNameExist(String username);
	
	@Query("SELECT u.securityQues FROM User u WHERE u.userName=?1")
	String getSecQuesByUserName(String username);
	
	@Query("SELECT u.securityAns FROM User u WHERE u.userName=?1")
	String getSecQuesAnswer(String username);
	
	@Transactional
	@Modifying
	@Query("update User u set u.password=?1,u.updationTime=?2 where u.userName=?3")
	int updatePassword(String password, Date dateNow, String username);

	@Query("SELECT COUNT(u) FROM User u WHERE u.userName=?1 and u.securityAns=?2")
	int validateAnswer(String username, String answer);

	@Transactional
	@Modifying
	@Query("update User u set u.blockFlag=?1, u.blockReason=?2 where u.userName=?3")
	int blockUnblockUser(String blockFlag, String blockReason, String userName);
	
	@Query(value="SELECT COUNT(*) FROM users_roles WHERE user_id=?1 and role_id=?2",nativeQuery = true)
    int checkIfUserHasRole(int userId, int roleId);
	
	@Transactional
	@Modifying
	@Query(value="delete FROM users_roles WHERE user_id=?1 and role_id=?2",nativeQuery = true)
    int deleteUserRole(int userId, int roleId);
	
	@Transactional
	@Modifying
	@Query(value="insert into users_roles (user_id,role_id) values (?1,?2);",nativeQuery = true)
    int insertUserRole(int userId, int roleId);
	
	@Transactional
	@Modifying
	@Query("update User u set u.password=?1, u.firstName=?2, u.lastName=?3, u.email=?4, u.securityQues=?5, u.securityAns=?6, u.updationTime=?7 where u.userId=?8")
	int updateUserProfileWithPassword(String password, String firstName, String lastName, String email, String secQues, String answer, Date dateNow, int userId);
	
	@Transactional
	@Modifying
	@Query("update User u set u.firstName=?1, u.lastName=?2, u.email=?3, u.securityQues=?4, u.securityAns=?5, u.updationTime=?6 where u.userId=?7")
	int updateUserProfileWithNoPassword(String firstName, String lastName, String email, String secQues, String answer, Date dateNow, int userId);

	List<User> findAllByOrderByCreationTimeDesc();
}
