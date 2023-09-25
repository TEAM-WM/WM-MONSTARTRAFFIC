package com.monstar.traffic.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class MetroJamDto {
	private Double serial_number;		// 연번 - 일련번호
	private String dayofweekdivision;	// 요일구분 - 평일 토요일 공휴일 요일 구분 
	private int linename;			// 지하철 호선
	private Double externalstationcode; // 외부역 코드
	private String departurestation;	// 출발역 이름
	private String divisionname;		// 운행방향
	private Double am05_30;				// 5시30분 ~6시 혼잡도
	private Double am06_00;
	private Double am06_30;
	private Double am07_00;
	private Double am07_30;
	private Double am08_00;
	private Double am08_30;
	private Double am09_00;
	private Double am09_30;
	private Double am10_00;
	private Double am10_30;
	private Double am11_00;
	private Double am11_30;
	private Double pm12_00;
	private Double pm12_30;
	private Double pm13_00;
	private Double pm13_30;
	private Double pm14_00;
	private Double pm14_30;
	private Double pm15_00;
	private Double pm15_30;
	private Double pm16_00;
	private Double pm16_30;
	private Double pm17_00;
	private Double pm17_30;
	private Double pm18_00;
	private Double pm18_30;
	private Double pm19_00;
	private Double pm19_30;
	private Double pm20_00;
	private Double pm20_30;
	private Double pm21_00;
	private Double pm21_30;
	private Double pm22_00;
	private Double pm22_30;
	private Double pm23_00;
	private Double pm23_30;
	private Double am00_00;
	private Double am00_30;
}