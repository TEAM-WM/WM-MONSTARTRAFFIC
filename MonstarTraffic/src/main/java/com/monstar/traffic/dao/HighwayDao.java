package com.monstar.traffic.dao;

import java.util.ArrayList;

import com.monstar.traffic.dto.HighwayDto;

public interface HighwayDao {
	
	public ArrayList<HighwayDto> sumCountByWay(); //도로별 교통량 합
	public ArrayList<HighwayDto> avgSpeedbyMonth();
//	public ArrayList<HighwayDto> avgSpeedbyMonth(String selWay);
	
}//interface 종료