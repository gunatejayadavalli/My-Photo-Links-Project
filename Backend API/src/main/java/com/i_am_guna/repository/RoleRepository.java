package com.i_am_guna.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.CrossOrigin;

import com.i_am_guna.entity.Role;

@CrossOrigin
public interface RoleRepository extends JpaRepository<Role, Integer> {
	
    Role findByRoleName(String roleName);

}
