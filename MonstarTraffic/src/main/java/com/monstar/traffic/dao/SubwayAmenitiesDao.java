package com.monstar.traffic.dao;

import java.util.List;

import com.monstar.traffic.dto.SubwayAmenitiesDto;

public interface SubwayAmenitiesDao {

	public List<SubwayAmenitiesDto> amenities();
	public List<SubwayAmenitiesDto> sumLine();
	
}//interface 종료