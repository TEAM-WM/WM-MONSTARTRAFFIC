package com.monstar.traffic.dao;

import java.util.ArrayList;

import com.monstar.traffic.dto.HighwayDto;

public interface HighwayDao {
	
	public ArrayList<HighwayDto> sumCountByWay(); //도로별 교통량 합
	public ArrayList<HighwayDto> avgSpeedbyMonth00();
	public ArrayList<HighwayDto> avgSpeedbyMonth01(String way);
	
}//interface 종료