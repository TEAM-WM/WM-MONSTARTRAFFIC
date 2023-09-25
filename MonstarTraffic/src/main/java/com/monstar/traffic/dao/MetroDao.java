package com.monstar.traffic.dao;

import java.util.ArrayList;

import com.monstar.traffic.dto.MetroElevatorDto;
import com.monstar.traffic.dto.MetroJamDto;

public interface MetroDao {
	public ArrayList<MetroElevatorDto> listElevator();
	public ArrayList<MetroJamDto> listJam(MetroJamDto dto);
	public ArrayList<MetroJamDto> listJamLine(MetroJamDto dto);
}//interface 종료