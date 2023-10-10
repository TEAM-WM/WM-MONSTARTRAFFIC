package com.monstar.traffic.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class BikeDto {
	// 월별 이용정보
	private int num; //순위
	private int cnt; //자치구별 수
	private String stationgrpname; //대여소그룹명(자치구명)
	private Date statmn; //년월
	private int rentcnt; //대여건수
	private int returncnt; //반납건수
	
	// 대여소 위치 정보
	private int sta_no; //대여소 번호
	private String sta_nm; //대여소명
	private String sta_loc; //자치구
	private String sta_addr; //상세주소
	private double sta_lat; //위도
	private double sta_long; //경도
	private Date sta_install; //설치시기
	private int lcd_cnt; //LCD 수
	private int qr_cnt; //QR 수
	private String sta_op; //운영방식
	
	// 공지사항
	private int bikeno; //글번호
	private String btitle; //글제목
	private String bcontent; //글내용
	private Date bdate; //작성일
	private String bimg; //이미지
	
	private int next; //다음글 번호
	private int last; //이전글 번호
	private String nexttitle; //다음글 제목
	private String lasttitle; //이전글 제목
}//BikeDto