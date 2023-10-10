package com.monstar.traffic.dao;

import java.util.ArrayList;

import com.monstar.traffic.dto.BikeDto;

public interface BikeDao {
	// 초기 월별 대여, 반납 건수
	public ArrayList<BikeDto> pRentCntMonth();
	
	// 월별 대여, 반납 건수
	public ArrayList<BikeDto> rentCntMonth(String month);
	
	// 초기 자치구별 지도 대여, 반납 건수
	public ArrayList<BikeDto> stationGroName(String areaName, String areaName2);
		
	// 대여소 정보
	public ArrayList<BikeDto> stationInfo();

	// 공지사항 리스트
	public ArrayList<BikeDto> bikeNoticeList(int rowStart, int rowEnd, String search, String string);

	// 공지사항 글 갯수
	public int TotCount1(String search);
	public int TotCount2(String search);
	public int TotCount3(String search);
	public int TotCount4(String search);
	
	// 공지사항 디테일
	public BikeDto bikeNoticeDetail(int bikeno);

	// 공지사항 이전글 다음글
	public BikeDto movePage(int bikeno);

	


}//interface 종료