package com.monstar.traffic.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
//리연 작성 230920
@AllArgsConstructor
@NoArgsConstructor
@Data
public class MetroElevatorDto {
	private int sgg_count; //시군구별 엘레베이터 갯수
	private String type;     // 노드링크유형
	private String node_wkt; // 노드 위도 경도
	private Double node_id;    // 노드 id
	private Double node_code;  // 노드 유형코드
	private Double sgg_cd;     // 시군구 코드
	private String sgg_nm;   // 시군구명
	private Double emd_cd;     // 읍면동 코드
	private String emd_nm;   // 읍면동명
	private Double sw_cd;      // 지하철역코드
	private String sw_nm;    // 지하철역명
}