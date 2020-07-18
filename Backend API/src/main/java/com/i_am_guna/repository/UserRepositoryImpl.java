package com.i_am_guna.repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.stereotype.Component;

@Component
public abstract class UserRepositoryImpl implements UserRepository {
	
	@PersistenceContext
    private EntityManager em;
	
}
