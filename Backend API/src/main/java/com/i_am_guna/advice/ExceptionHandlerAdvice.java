package com.i_am_guna.advice;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import com.i_am_guna.entity.CustomErrorResponse;

@ControllerAdvice
public class ExceptionHandlerAdvice {
	
	@ExceptionHandler
	public ResponseEntity<CustomErrorResponse> GenericExceptionHandler(Exception exc){
		CustomErrorResponse error = new CustomErrorResponse(HttpStatus.BAD_REQUEST.value(), exc.getMessage(), System.currentTimeMillis());
		return new ResponseEntity<>(error,HttpStatus.BAD_REQUEST);
	}

}
