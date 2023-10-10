package com.monstar.traffic.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.monstar.traffic.dto.RiderAccidentVo;






public interface RiderAccidentDao {

	
	public List<RiderAccidentVo> manSex(Map<String, Object> map) ;
	
	public List<RiderAccidentVo> vehicleAccident(Map<String, Object> map) ;
	
	List<RiderAccidentVo> monthAccident(Map<String, Object> map);
	
	List<RiderAccidentVo> ageAccident(Map<String, Object> map);
	
	List<RiderAccidentVo> hourAccident(Map<String, Object> map);	

}
