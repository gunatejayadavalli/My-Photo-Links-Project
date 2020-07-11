package com.i_am_guna.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Component;
import com.i_am_guna.entity.PhotoLink;
import com.i_am_guna.entity.User;

@Component("")
public interface UserRepository extends JpaRepository<User, Integer> {

	User findByUserName(String username);
	
	@Query(name="findPhotoLinksByUserName",nativeQuery = true)
	List<PhotoLink> findPhotoLinksByUserName(String userName);
}
