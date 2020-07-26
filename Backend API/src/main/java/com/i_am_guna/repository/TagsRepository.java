package com.i_am_guna.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import com.i_am_guna.entity.Tag;

public interface TagsRepository extends JpaRepository<Tag, Integer> {

	@Query(name="findTagsByEventId",nativeQuery = true)
	List<Tag> findTagsByEventId(int eventId);
}
