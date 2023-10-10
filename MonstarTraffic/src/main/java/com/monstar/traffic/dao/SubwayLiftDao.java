package com.monstar.traffic.dao;

import java.util.List;

import com.monstar.traffic.dto.SubwayLiftDto;

public interface SubwayLiftDao {

//	페이징 처리 전
	public List<SubwayLiftDto> subwaylift();
//	페이징 처리 후
//	public List<SubwayLiftDto> subwaylift(int rowStart, int rowEnd, String sk, String selNum);
	
//	public int selectBoardTotCount1(String searchKeyword);
//	public int selectBoardTotCount2(String searchKeyword);
//	public int selectBoardTotCount3(String searchKeyword);
//	public int selectBoardTotCount4(String searchKeyword);


	
}//interface 종료