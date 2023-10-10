package com.monstar.traffic.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
//리연 작성 231006
@AllArgsConstructor
@NoArgsConstructor
@Data
public class NoticeDto {
	private int no;
	private String title;
	private String content;
	private Date regdate;
	private int hit;
}