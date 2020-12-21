package com.ftw.error.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/error")
public class ErrorController {
	
	private final String MODULE = "error/";
	
	@GetMapping("/access.do")
	public String accessDenied(Authentication auth) {
		
		log.info("access Denied:" + auth);
		
		return MODULE + "access";
	}

}
