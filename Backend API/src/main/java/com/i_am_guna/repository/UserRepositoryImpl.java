package com.i_am_guna.repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

public abstract class UserRepositoryImpl implements UserRepository {
	
	@PersistenceContext
    private EntityManager em;
	
	
}
