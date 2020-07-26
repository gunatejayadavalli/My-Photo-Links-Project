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
	
	@Query(name="findPhotoLinksByUserName",nativeQuery = true)
	List<PhotoLink> findPhotoLinksByUserName(String userName);
	
	@Query(name="findUserPhotoLinksByQuery",nativeQuery = true)
	List<PhotoLink> findUserPhotoLinksByQuery(String userName, String keyword, Date fromDate, Date toDate, String selectedTag);
	
	@Query("SELECT COUNT(u) FROM User u WHERE u.userName=?1")
    int checkUserNameExist(String username);
	
	@Query("SELECT u.securityQues FROM User u WHERE u.userName=?1")
	String getSecQuesByUserName(String username);
	
	@Transactional
	@Modifying
	@Query("update User u set u.password=?1,u.updationTime=?2 where u.userName=?3")
	int updatePassword(String password, Date dateNow, String username);

	@Query("SELECT COUNT(u) FROM User u WHERE u.userName=?1 and u.securityAns=?2")
	int validateAnswer(String username, String answer);
}
