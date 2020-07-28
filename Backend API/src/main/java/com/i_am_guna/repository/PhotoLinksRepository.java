package com.i_am_guna.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.CrossOrigin;
import com.i_am_guna.entity.PhotoLink;

@CrossOrigin
public interface PhotoLinksRepository extends JpaRepository<PhotoLink, Integer> {
	
	List<PhotoLink> findAll();
	
}
