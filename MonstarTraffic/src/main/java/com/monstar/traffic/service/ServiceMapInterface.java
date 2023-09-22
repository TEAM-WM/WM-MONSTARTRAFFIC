package com.monstar.traffic.service;

import java.util.Map;

import org.springframework.ui.Model;

public interface ServiceMapInterface {
	public Map<String, Object> execute(Model model);
}// interface 종료