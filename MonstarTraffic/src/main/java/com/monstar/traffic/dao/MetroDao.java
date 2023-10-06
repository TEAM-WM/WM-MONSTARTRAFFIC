package com.monstar.traffic.dao;

import java.util.ArrayList;

import com.monstar.traffic.dto.MetroElevatorDto;
import com.monstar.traffic.dto.MetroJamDto;
//리연 작성 230920~
public interface MetroDao {
	// =========== 지하철 엘레베이터
	public ArrayList<MetroElevatorDto> listElevator();// 지하철 엘레베이터 정보
	public ArrayList<MetroElevatorDto> listElevatorSGG();// 지하철 엘레베이터 구별 갯수
	// =========== 지하철 혼잡도
	public ArrayList<MetroJamDto> listJam(MetroJamDto dto); // 호선별 지하철 혼잡도 정보
	public ArrayList<MetroJamDto> listJamLine(MetroJamDto dto);// 호선별 역명
	public ArrayList<MetroJamDto> listJamLineHigh(MetroJamDto dto); // 각 호선별 혼잡도 높은 순위
	public ArrayList<MetroJamDto> listJamLineHighALL(); // 전체 호선 혼잡도 높은 순위
}//interface 종료