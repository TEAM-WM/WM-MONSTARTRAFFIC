package com.monstar.traffic.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.monstar.traffic.dao.RiderAccidentDao;
import com.monstar.traffic.dto.RiderAccidentVo;
import com.monstar.traffic.dto.SearchVo;

//import dbConn.Accident;





@Service
public class RiderAccidentService implements  ServiceInterface{
	
	//@Autowired
	private SqlSession sqlSession;
	
	public RiderAccidentService(SqlSession sqlSession) {
		// TODO Auto-generated constructor stub
		this.sqlSession=sqlSession;
	}

	@Override
	public void execute(Model model) {
		System.out.println(">>>riderAccident service>>>");
		//----------
		Map<String, Object> map2=model.asMap();
		SearchVo keyWord=   (SearchVo) map2.get("keyWord");
		System.out.println("11>>"+(SearchVo) map2.get("keyWord"));
		//if(true) return null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("searchRegion>>"+keyWord.getSearchRegion());
		String searchRegion = keyWord.getSearchRegion();
		String searchYear = keyWord.getSearchYear();

		if (searchRegion==null){
			searchRegion="관악";
		}
		if (searchYear==null){
			searchYear="2020";
		}
		
		map.put("searchRegion",searchRegion);
		map.put("searchYear",searchYear);
		
		System.out.println("searchRegion>>"+searchRegion);
		System.out.println("searchYear>>"+searchYear);
		
		Object arr1=maninfo(map,sqlSession);
		Object arr2=accidentvehicle(map, sqlSession);
		Object arr3=monthAccident(map, sqlSession);
		Object arr4=ageAccident(map, sqlSession);		
		Object arr5=hourAccident(map, sqlSession);
		

		//
		model.addAttribute("arr1",arr1 );
		model.addAttribute("arr2",arr2 );
		model.addAttribute("arr3",arr3 );
		model.addAttribute("arr4",arr4 );
		model.addAttribute("arr5",arr5 );
		
		//return null;
	
		
	}
	
	 @SuppressWarnings("unchecked")
	public static Object maninfo(Map<String, Object> map,
			 SqlSession sqlSession) {
		 
		String searchRegion=(String) map.get("searchRegion");
		String searchYear=(String) map.get("searchYear"); 
		RiderAccidentDao dao = sqlSession.getMapper(RiderAccidentDao.class);	
		List<RiderAccidentVo> manSex = dao.manSex(map);
			
		//남여 성별
		String sql="select manSex,count(manSex) as sexSum from rider_accident";
		sql=sql+" where accidentRegion like '%"+searchRegion+"%' and manSex not in('기타불명') and";
		sql=sql+" accidentDay BETWEEN TO_DATE('"+searchYear+"-01-01', 'YYYY-MM-DD') and ";
		sql=sql+" TO_DATE('"+searchYear+"-12-31', 'YYYY-MM-DD') and ";
		sql=sql+" manSex not in('없음') ";
		sql=sql+" group by manSex  ";
			
			
			System.out.println("sql"+sql);

			JSONArray arr1=new JSONArray();
			//Gson gson = new Gson();
			for(RiderAccidentVo man : manSex) {
				JSONObject obj=new JSONObject();
				String manSex2=man.getManSex();
				int sexSum=man.getSexSum();
				
				System.out.println("manSex"+manSex2);
				System.out.println("sexSum"+sexSum);
				obj.put("manSex",manSex2);
				obj.put("sexSum",sexSum);
				
				if(obj!=null){
					arr1.add(obj);
				}
			}
		return  arr1;
	
	 }
	 
	 
	@SuppressWarnings("unchecked")
	public static Object accidentvehicle(Map<String, Object> map,
			SqlSession sqlSession) {
		//가해자 차량종류
		String searchRegion=(String) map.get("searchRegion");
		String searchYear=(String) map.get("searchYear"); 
		
		String sql="select accidentvehicle,count(accidentvehicle) as vehicleSum from rider_accident ";
		sql=sql+" where accidentRegion like '%"+searchRegion+"%' and ";
		sql=sql+" accidentDay BETWEEN TO_DATE('"+searchYear+"-01-01', 'YYYY-MM-DD') and ";
		sql=sql+" TO_DATE('"+searchYear+"-12-31', 'YYYY-MM-DD') ";
		sql=sql+" and accidentRegion not in('불명')  ";
		sql=sql+" group by accidentvehicle  ";
		System.out.println("sql"+sql);
		//if(true) return;
		//pstmt=conn.prepareStatement(sql);
		//rs=pstmt.executeQuery();
		RiderAccidentDao dao = sqlSession.getMapper(RiderAccidentDao.class);
		List<RiderAccidentVo> vehicleAccident = dao.vehicleAccident(map);
		JSONArray arr2=new JSONArray();
		for(RiderAccidentVo vehicle : vehicleAccident) {
			JSONObject obj=new JSONObject();
			String accidentvehicle=vehicle.getAccidentvehicle();
			int vehicleSum=vehicle.getVehicleSum();
			
			System.out.println("accidentvehicle"+accidentvehicle);
			System.out.println("vehicleSum"+vehicleSum);
			obj.put("accidentvehicle",accidentvehicle);
			obj.put("vehicleSum",vehicleSum);
			
			if(obj!=null){
				arr2.add(obj);
			}	
		}
		return   arr2;
	 }
	public static Object monthAccident(Map<String, Object> map,
			SqlSession sqlSession) {
		
	String searchRegion=(String) map.get("searchRegion");
	String searchYear=(String) map.get("searchYear"); 
		
	String sql="SELECT TO_CHAR(accidentDay, 'YYYY-MM') AS yyyymm  ,";
	sql=sql+" sum(injuryNum) injurySum,sum(deadNum) deadSum FROM rider_accident";
	sql=sql+" WHERE accidentRegion like '%"+searchRegion+"%' and accidentDay BETWEEN  ";
	sql=sql+" TO_DATE('"+searchYear+"-01-01', 'YYYY-MM-DD')  ";
	sql=sql+" AND TO_DATE('"+searchYear+"-12-31', 'YYYY-MM-DD') ";
	sql=sql+" GROUP BY TO_CHAR(accidentDay, 'YYYY-MM') ";	
	sql=sql+" ORDER BY yyyymm ";	
	System.out.println("sql"+sql);
	
	RiderAccidentDao dao = sqlSession.getMapper(RiderAccidentDao.class);
	List<RiderAccidentVo> monthAccident = dao.monthAccident(map);
	//pstmt=conn.prepareStatement(sql);
	//rs=pstmt.executeQuery();
	
	JSONArray arr3=new JSONArray();
	for(RiderAccidentVo m : monthAccident) {
	//while(rs.next()){
		JSONObject obj=new JSONObject();

		String yyyymm=m.getYyyymm();
		int injurySum=m.getInjurySum();
		int deadSum=m.getDeadSum();
		System.out.println("yyyymm"+yyyymm);
		System.out.println("injurySum"+injurySum);
		System.out.println("deadSum"+deadSum);
		
		obj.put("yyyymm",yyyymm);
		obj.put("injurySum",injurySum);
		obj.put("deadSum",deadSum);
		
		if(obj!=null){
			arr3.add(obj);
		}

	}
	return   arr3;
	}
	
	public static Object ageAccident(Map<String, Object> map,
			SqlSession sqlSession) {	
	//연령별 사망사고 건수
	int manHour1=0;
	int manHour2=0;
	int manHour3=0;
	int manHour4=0;
	int manHour5=0;
	int manHour6=0;
	int manHour7=0;
	int manHour8=0;
	int manHour9=0;
	int manHour10=0;

	String searchRegion=(String) map.get("searchRegion");
	String searchYear=(String) map.get("searchYear"); 
	
	String sql="select to_number(manAge) as manAge  from rider_accident ";
	sql=sql+" where accidentRegion like '%"+searchRegion+"%' and  ";
	sql=sql+" manAge not in('불명','없음') and ";
	sql=sql+" accidentDay BETWEEN TO_DATE('"+searchYear+"-01-01', 'YYYY-MM-DD') ";
	sql=sql+" AND TO_DATE('"+searchYear+"-12-31', 'YYYY-MM-DD')";
	sql=sql+"     order by accidentRegion asc";
	System.out.println("manAge"+sql);
	//if(true) return;
	
	RiderAccidentDao dao = sqlSession.getMapper(RiderAccidentDao.class);
	List<RiderAccidentVo> ageAccident = dao.ageAccident(map);
	//pstmt=conn.prepareStatement(sql);
	//rs=pstmt.executeQuery();
	JSONArray arr4=new JSONArray();
	JSONObject obj=new JSONObject();
	for(RiderAccidentVo age : ageAccident) {
		
	//while(rs.next()){
		System.out.println("manAge:"+age.getManAge());
	//	
	if(age.getManAge()>=0 &&age.getManAge()<=9){
		manHour1=manHour1+1;
		
		System.out.println("manHour1:"+manHour1);
		
	}else if(age.getManAge()>=10 && age.getManAge()<=19){
		manHour2=manHour2+1;
		
		System.out.println("manHour2:"+manHour2);

	}else if(age.getManAge()>=20 && age.getManAge()<=29){
		manHour3=manHour3+1;
		
		System.out.println("manHour3:"+manHour3);

	}else if(age.getManAge()>=30 && age.getManAge()<=39){
		manHour4=manHour4+1;
		
		System.out.println("manHour4:"+manHour4);
		
	}else if(age.getManAge()>=40 && age.getManAge()<=49){
		manHour5=manHour5+1;
		
		System.out.println("manHour5:"+manHour5);

		
	}else if(age.getManAge()>=50 && age.getManAge()<=59){
		manHour6=manHour6+1;
		
		System.out.println("manHour6:"+manHour6);

	}else if(age.getManAge()>=60 && age.getManAge()<=69){
		manHour7=manHour7+1;
		
		System.out.println("manHour7:"+manHour7);

		
	}else if(age.getManAge()>=70 && age.getManAge()<=79){
		manHour8=manHour8+1;
		
		System.out.println("manHour8:"+manHour8);

	}else if(age.getManAge()>=80 && age.getManAge()<=89){
		manHour9=manHour9+1;
		
		System.out.println("manHour9:"+manHour9);

	}else if(age.getManAge()>=90 && age.getManAge()<=99){
		manHour10=manHour10+1;
		
		System.out.println("manHour10:"+manHour10);

	}

	}

	obj.put("manHour1",manHour1);
	obj.put("manHour2",manHour2);
	obj.put("manHour3",manHour3);
	obj.put("manHour4",manHour4);
	obj.put("manHour5",manHour5);
	obj.put("manHour6",manHour6);
	obj.put("manHour7",manHour7);
	obj.put("manHour8",manHour8);
	obj.put("manHour9",manHour9);
	obj.put("manHour10",manHour10);
	arr4.add(obj);
	
	return   arr4;
	}
	
	@SuppressWarnings("unchecked")
	public static Object hourAccident(Map<String, Object> map,
			SqlSession sqlSession) {	
	//시간별 사망사고 건수시작
		
	String searchRegion=(String) map.get("searchRegion");
	String searchYear=(String) map.get("searchYear");	
		
	String sql="select accidentHour,injuryNum,deadNum from ";
	sql=sql+" rider_accident where accidentRegion like '%"+searchRegion+"%' ";
	sql=sql+" and accidentDay ";
	sql=sql+" BETWEEN TO_DATE('"+searchYear+"-01-01', 'YYYY-MM-DD') ";
	sql=sql+" AND TO_DATE('"+searchYear+"-12-31', 'YYYY-MM-DD')";
	sql=sql+"     order by accidentRegion asc";
	sql=sql+" ";
	sql=sql+" ";

	RiderAccidentDao dao = sqlSession.getMapper(RiderAccidentDao.class);
	List<RiderAccidentVo> hourAccident = dao.hourAccident(map);
	//conn=DBcon.getConnection();
	 //pstmt=conn.prepareStatement(sql);
	 //rs=pstmt.executeQuery();

	 int injuryHour1=0;
	 int injuryHour3=0;
	 int injuryHour5=0;
	 int injuryHour7=0;
	 int injuryHour9=0;
	 int injuryHour11=0;
	 int injuryHour13=0;
	 int injuryHour15=0;
	 int injuryHour17=0;
	 int injuryHour19=0;
	 int injuryHour21=0;
	 int injuryHour23=0;

	 int deadHour1=0;
	 int deadHour3=0;
	 int deadHour5=0;
	 int deadHour7=0;
	 int deadHour9=0;
	 int deadHour11=0;
	 int deadHour13=0;
	 int deadHour15=0;
	 int deadHour17=0;
	 int deadHour19=0;
	 int deadHour21=0;
	 int deadHour23=0;

	 JSONArray arr5=new JSONArray();
	 JSONObject obj=new JSONObject();
	 
	for(RiderAccidentVo hour : hourAccident) {
	 //while(rs.next()){
	 	
//	 	System.out.println(rs.getString("goods")+" : "+rs.getInt(2));
	 if(hour.getAccidentHour().equals("01시") || hour.getAccidentHour().equals("02시")){
	 	injuryHour1=injuryHour1+hour.getInjuryNum();
	 	deadHour1=deadHour1+hour.getDeadNum();
	 	System.out.println(injuryHour1);
	 	
	 }else if(hour.getAccidentHour().equals("03시") || hour.getAccidentHour().equals("04시")){
	 	injuryHour3=injuryHour3+hour.getInjuryNum();
	 	deadHour3=deadHour3+hour.getDeadNum();
	 	System.out.println(injuryHour3);

	 }else if(hour.getAccidentHour().equals("05시") || hour.getAccidentHour().equals("06시")){
	 	injuryHour5=injuryHour5+hour.getInjuryNum();
	 	deadHour5=deadHour5+hour.getDeadNum();
	 	System.out.println(injuryHour5);

	 }else if(hour.getAccidentHour().equals("07시") || hour.getAccidentHour().equals("08시")){
	 	injuryHour7=injuryHour7+hour.getInjuryNum();
	 	deadHour7=deadHour7+hour.getDeadNum();
	 	System.out.println(injuryHour7);
	 	
	 }else if(hour.getAccidentHour().equals("09시") || hour.getAccidentHour().equals("10시")){
	 	injuryHour9=injuryHour9+hour.getInjuryNum();
	 	deadHour9=deadHour9+hour.getDeadNum();
	 	System.out.println(injuryHour9);

	 	
	 }else if(hour.getAccidentHour().equals("11시") || hour.getAccidentHour().equals("12시")){
	 	injuryHour11=injuryHour11+hour.getInjuryNum();
	 	deadHour11=deadHour11+hour.getDeadNum();
	 	System.out.println(injuryHour11);

	 }else if(hour.getAccidentHour().equals("13시") || hour.getAccidentHour().equals("14시")){
	 	injuryHour13=injuryHour13+hour.getInjuryNum();
	 	deadHour13=deadHour13+hour.getDeadNum();
	 	System.out.println(injuryHour13);
	 	
	 	
	 }else if(hour.getAccidentHour().equals("15시") || hour.getAccidentHour().equals("16시")){
	 	injuryHour15=injuryHour15+hour.getInjuryNum();
	 	deadHour15=deadHour15+hour.getDeadNum();
	 		System.out.println(injuryHour15);

	 }else if(hour.getAccidentHour().equals("17시") || hour.getAccidentHour().equals("18시")){
	 	injuryHour17=injuryHour17+hour.getInjuryNum();
	 	deadHour17=deadHour17+hour.getDeadNum();
	 	System.out.println(injuryHour17);
	 	
	 }else if(hour.getAccidentHour().equals("19시") || hour.getAccidentHour().equals("20시")){
	 	injuryHour19=injuryHour19+hour.getInjuryNum();
	 	deadHour19=deadHour19+hour.getDeadNum();
	 	System.out.println(injuryHour19);
	 	


	 }else if(hour.getAccidentHour().equals("21시") || hour.getAccidentHour().equals("22시")){
	 	injuryHour21=injuryHour21+hour.getInjuryNum();
	 	deadHour21=deadHour21+hour.getDeadNum();
	 	System.out.println(injuryHour21);
	 	
	 }else if(hour.getAccidentHour().equals("23시") || hour.getAccidentHour().equals("24시")){
	 	injuryHour23=injuryHour23+hour.getInjuryNum();
	 	deadHour23=deadHour23+hour.getDeadNum();
	 	System.out.println(injuryHour23);	
	 }
	}
	
	obj.put("injuryHour1",injuryHour1);
	obj.put("injuryHour3",injuryHour3);
	obj.put("injuryHour5",injuryHour5);
	obj.put("injuryHour7",injuryHour7);
	obj.put("injuryHour9",injuryHour9);
	obj.put("injuryHour11",injuryHour11);
	obj.put("injuryHour13",injuryHour13);
	obj.put("injuryHour15",injuryHour15);
	obj.put("injuryHour17",injuryHour17);
	obj.put("injuryHour19",injuryHour19);
	obj.put("injuryHour21",injuryHour21);
	obj.put("injuryHour23",injuryHour23);

	obj.put("deadHour1",deadHour1);
	obj.put("deadHour3",deadHour3);	
	obj.put("deadHour5",deadHour5);	
	obj.put("deadHour7",deadHour7);	
	obj.put("deadHour9",deadHour9);	
	obj.put("deadHour11",deadHour11);	
	obj.put("deadHour13",deadHour13);	
	obj.put("deadHour15",deadHour15);	
	obj.put("deadHour17",deadHour17);
	obj.put("deadHour19",deadHour19);	
	obj.put("deadHour21",deadHour21);	
	obj.put("deadHour23",deadHour23);	

	arr5.add(obj);
	return   arr5;
	}

}
