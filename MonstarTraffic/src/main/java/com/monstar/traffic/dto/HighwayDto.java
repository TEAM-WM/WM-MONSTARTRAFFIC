package com.monstar.traffic.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class HighwayDto {
	
	private int year;
	private int month;
	private String way;
	private int dayavgcount;
	private int avgspeed;
	private int monday;
	private int tuesday;
	private int wednesday;
	private int thursday;
	private int friday;
	private int saturday;
	private int sunday;
	
	private int way_sum;
}//ExDto