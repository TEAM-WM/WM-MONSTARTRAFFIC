package com.monstar.traffic.dao;

import java.util.ArrayList;

import com.monstar.traffic.dto.MetroElevatorDto;
import com.monstar.traffic.dto.MetroJamDto;

public interface MetroDao {
	public ArrayList<MetroElevatorDto> list();
	public ArrayList<MetroJamDto> list2();
}//interface 종료