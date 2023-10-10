package com.monstar.traffic.dao;

import java.util.ArrayList;

import com.monstar.traffic.dto.MetroElevatorDto;
import com.monstar.traffic.dto.MetroJamDto;
import com.monstar.traffic.dto.NoticeDto;
//리연 작성 230920~
public interface MetroDao {
	// =========== 공지사항
	public void insert(NoticeDto dto);// 글작성
	public ArrayList<NoticeDto> listNotice();//글목록
	public NoticeDto getData(int no);//글 상세
	public void upHit(int no);// 조회수 증가
	// 페이징 처리를 위한 메소드
	// 검색처리를 위해 메소드에 파라미터 값 추가
	public int selectBoardTotCount1(String searchKeyword);// 글제목으로만
	public int selectBoardTotCount2(String searchKeyword);// 글내용으로만
	public int selectBoardTotCount3(String searchKeyword);// 둘 다 존재
	public int selectBoardTotCount4(String searchKeyword);// 둘 다 없음
	public ArrayList<NoticeDto> listNotice(int rowStart, int rowEnd, String searchKeyword, String setNum);
	// =========== 지하철 엘레베이터
	public ArrayList<MetroElevatorDto> listElevator();// 지하철 엘레베이터 정보
	public ArrayList<MetroElevatorDto> listElevatorSGG();// 지하철 엘레베이터 구별 갯수
	// =========== 지하철 혼잡도
	public ArrayList<MetroJamDto> listJam(MetroJamDto dto); // 호선별 지하철 혼잡도 정보
	public ArrayList<MetroJamDto> listJamLine(MetroJamDto dto);// 호선별 역명
	public ArrayList<MetroJamDto> listJamLineHigh(MetroJamDto dto); // 각 호선별 혼잡도 높은 순위
	public ArrayList<MetroJamDto> listJamLineHighALL(); // 전체 호선 혼잡도 높은 순위
}//interface 종료