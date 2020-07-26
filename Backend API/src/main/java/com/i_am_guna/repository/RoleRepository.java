package com.i_am_guna.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.i_am_guna.entity.Role;

public interface RoleRepository extends JpaRepository<Role, Integer> {
	
    Role findByRoleName(String roleName);

}
