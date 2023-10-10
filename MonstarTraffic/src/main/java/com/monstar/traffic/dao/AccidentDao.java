package com.monstar.traffic.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.monstar.traffic.dto.AccidentDto;

public interface AccidentDao {
	
	ArrayList<AccidentDto> get2019stats();
	
	//ArrayList<AccidentDto> get2019stats(String year);
	
	ArrayList<AccidentDto> get2020stats(String year);
	
	ArrayList<AccidentDto> getstats(@Param("tablename") String tablename, @Param("columnname") String columnname);
}
