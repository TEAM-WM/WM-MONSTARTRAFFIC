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
//	(효슬) 서울시 지하철 출입구 리프트 위치정보
public class SubwayLiftDto {	
	private String type;			//노드링크 유형
	private String node_wkt;	//노드 WKT
	private int node_id;			//노드 ID
	private int node_code;		//노드 유형 코드
	private int sgg_cde;		//시군구코드
	private String sgg_nm;		//시군구명
	private int emd_cd;			//읍면동코드
	private String emd_nm;		//읍면동명
	private int sw_cd;			//지하철역코드
	private String sw_nm;		//지하철역명

}