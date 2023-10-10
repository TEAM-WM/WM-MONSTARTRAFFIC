package com.monstar.traffic.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Data
//	(효슬) 서울 지하철 내 엘리베이터, 휠체어리프트 등 노약자, 장애인 편의시설 현황
public class SubwayAmenitiesDto {

	private String line;	//지하철 호선
	private String statn_nm;	//지하철 역명
	private int elvtr;	//엘리베이터 개수
	private int escltr;	//에스컬레이터
	private int wheelchair_lift;	//휠체어리프트
	private int hrzntlty_atmc_ftpth;	//수평자동보도

	private int total_elevator;	//총 엘리베이터 개수
	private int total_escalator;
	private int total_wheelchair_lift;
	private int total_hrzntlty_atmc_ftpth;

}