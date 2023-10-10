package com.monstar.traffic.dto;

import java.util.Date;

public class RiderAccidentVo {


	private String accidentRegion ;
	private String regionDetail ;
	private String accidentDay ;
	private String accidentHour ;
	private String accidentvehicle ;
	private String manSex ;
	private int manAge ;
	private int deadNum ;
	private int injuryNum ;
	
	private int sexSum ;
	private int vehicleSum ;
	
	private String yyyymm;
	private int  injurySum;
	private int deadSum;
	
	
	public String getYyyymm() {
		return yyyymm;
	}
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	public int getInjurySum() {
		return injurySum;
	}
	public void setInjurySum(int injurySum) {
		this.injurySum = injurySum;
	}
	public int getDeadSum() {
		return deadSum;
	}
	public void setDeadSum(int deadSum) {
		this.deadSum = deadSum;
	}
	public int getVehicleSum() {
		return vehicleSum;
	}
	public void setVehicleSum(int vehicleSum) {
		this.vehicleSum = vehicleSum;
	}
	public int getSexSum() {
		return sexSum;
	}
	public void setSexSum(int sexSum) {
		this.sexSum = sexSum;
	}
	public String getAccidentRegion() {
		return accidentRegion;
	}
	public void setAccidentRegion(String accidentRegion) {
		this.accidentRegion = accidentRegion;
	}
	public String getRegionDetail() {
		return regionDetail;
	}
	public void setRegionDetail(String regionDetail) {
		this.regionDetail = regionDetail;
	}
	public String getAccidentDay() {
		return accidentDay;
	}
	public void setAccidentDay(String accidentDay) {
		this.accidentDay = accidentDay;
	}
	public String getAccidentHour() {
		return accidentHour;
	}
	public void setAccidentHour(String accidentHour) {
		this.accidentHour = accidentHour;
	}
	public String getAccidentvehicle() {
		return accidentvehicle;
	}
	public void setAccidentvehicle(String accidentvehicle) {
		this.accidentvehicle = accidentvehicle;
	}
	public String getManSex() {
		return manSex;
	}
	public void setManSex(String manSex) {
		this.manSex = manSex;
	}
	public int getManAge() {
		return manAge;
	}
	public void setManAge(int manAge) {
		this.manAge = manAge;
	}
	public int getDeadNum() {
		return deadNum;
	}
	public void setDeadNum(int deadNum) {
		this.deadNum = deadNum;
	}
	public int getInjuryNum() {
		return injuryNum;
	}
	public void setInjuryNum(int injuryNum) {
		this.injuryNum = injuryNum;
	}

	
	
	
	
	
	
}
