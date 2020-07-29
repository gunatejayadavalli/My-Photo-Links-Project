package com.i_am_guna.repository;

import java.util.List;
import javax.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import com.i_am_guna.entity.Tag;

public interface TagsRepository extends JpaRepository<Tag, Integer> {

	@Query(name="findTagsByEventId",nativeQuery = true)
	List<Tag> findTagsByEventId(int eventId);
	
	@Transactional
	@Modifying
	@Query(value="delete FROM users_tags WHERE tag_id=?1",nativeQuery = true)
    int deleteUserTag(int tagId);
	
	@Transactional
	@Modifying
	@Query(value="delete FROM users_tags WHERE user_id=?1",nativeQuery = true)
    int deleteAllUserTags(int userId);
	
	@Transactional
	@Modifying
	@Query(value="delete FROM photolinks_tags WHERE tag_id=?1",nativeQuery = true)
    int deletePhotoLinkTag(int tagId);
	
	@Transactional
	@Modifying
	@Query(value="delete FROM tags WHERE tag_id=?1",nativeQuery = true)
    int deleteTag(int tagId);

	List<Tag> findAllByOrderByCreationTimeDesc();

	@Query(value="select user_id FROM users_roles WHERE role_id=?1",nativeQuery = true)
	Object[] getUserIdsWithRole(int roleId);
	
	@Transactional
	@Modifying
	@Query(value="insert into users_tags (user_id,tag_id) values (?1,?2);",nativeQuery = true)
    int insertUserTag(int userId, int tagId);

}
