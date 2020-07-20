package com.i_am_guna.repository;

import java.util.List;
import javax.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.web.bind.annotation.CrossOrigin;
import com.i_am_guna.entity.PhotoLink;
import com.i_am_guna.entity.User;

@CrossOrigin
public interface UserRepository extends JpaRepository<User, Integer> {

	User findByUserName(String username);
	
	@Query(name="findPhotoLinksByUserName",nativeQuery = true)
	List<PhotoLink> findPhotoLinksByUserName(String userName);
	
	@Query("SELECT COUNT(u) FROM User u WHERE u.userName=?1")
    int checkUserNameExist(String username);
	
	@Query("SELECT u.securityQues FROM User u WHERE u.userName=?1")
	String getSecQuesByUserName(String username);
	
	@Transactional
	@Modifying
	@Query("update User u set u.password=?1 where u.userName=?2")
	int updatePassword(String password, String username);

	@Query("SELECT COUNT(u) FROM User u WHERE u.userName=?1 and u.securityAns=?2")
	int validateAnswer(String username, String answer);
}
