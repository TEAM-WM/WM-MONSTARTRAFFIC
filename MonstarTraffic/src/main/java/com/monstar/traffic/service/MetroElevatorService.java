package com.monstar.traffic.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.monstar.traffic.dao.MetroDao;
import com.monstar.traffic.dto.MetroElevatorDto;

//리연 작성 230920
//http://openapi.seoul.go.kr:8088/6e4d4d4d53666c643936687a64457a/json/tbTraficElvtr/1/1000/
public class MetroElevatorService implements ServiceInterface {

	@Autowired
	private SqlSession sqlSession;

	public MetroElevatorService() {
	}

	public MetroElevatorService(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}

//	@SuppressWarnings("unchecked")
	@Override
	public void execute(Model model) {
		MetroDao dao = sqlSession.getMapper(MetroDao.class);
		
		ArrayList<MetroElevatorDto> dtoSGG = dao.listElevatorSGG();
		ArrayList<JSONObject> jsonSGGList = new ArrayList<JSONObject>(); // JSON 객체를 담을 리스트
		
		for (MetroElevatorDto d : dtoSGG) {
			Map<Object, Object> map = new HashMap<>();
			map.put("sgg_count", d.getSgg_count());
			map.put("sgg_nm", d.getSgg_nm());
			
			JSONObject obj = new JSONObject(map);
			jsonSGGList.add(obj);
		} // for
//		// 차트
////		JSONArray jsonArray = new JSONArray();
//		ArrayList<MetroElevatorDto> dto = dao.listElevator();
//
//		ArrayList<JSONObject> jsonList = new ArrayList<JSONObject>(); // JSON 객체를 담을 리스트
//		
//		for (MetroElevatorDto d : dto) {
//			Map<Object, Object> map = new HashMap<>();
//			map.put("type", d.getType());
//			map.put("node_wkt", d.getNode_wkt());
//			map.put("node_id", d.getNode_id());
//			map.put("node_code", d.getNode_code());
//			map.put("sgg_cd", d.getSgg_cd());
//			map.put("sgg_nm", d.getSgg_nm());
//			map.put("emd_cd", d.getEmd_cd());
//			map.put("emd_nm", d.getEmd_nm());
//			map.put("sw_cd", d.getSw_cd());
//			map.put("sw_nm", d.getSw_nm());
//			
//			JSONObject obj = new JSONObject(map);
//			jsonList.add(obj);
//		} // for

		JSONParser parser = new JSONParser(); // 파싱하기 위한 JSONParser 객체
		HttpURLConnection conn = null;
		BufferedReader rd = null;
		try {
			StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088"); /* URL */
			urlBuilder.append("/"
					+ URLEncoder.encode("6e4d4d4d53666c643936687a64457a", "UTF-8")); /* 인증키 (sample사용시에는 호출시 제한됩니다.) */
			urlBuilder.append("/" + URLEncoder.encode("json", "UTF-8")); /* 요청파일타입 (xml,xmlf,xls,json) */
			urlBuilder.append("/" + URLEncoder.encode("tbTraficElvtr", "UTF-8")); /* 서비스명 (대소문자 구분 필수입니다.) */
			urlBuilder.append("/" + URLEncoder.encode("1", "UTF-8")); /* 요청시작위치 (sample인증키 사용시 5이내 숫자) */
			urlBuilder.append("/" + URLEncoder.encode("1000", "UTF-8")); /* 요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨) */
			// 상위 5개는 필수적으로 순서바꾸지 않고 호출해야 합니다.

			// 서비스별 추가 요청 인자이며 자세한 내용은 각 서비스별 '요청인자'부분에 자세히 나와 있습니다.
			urlBuilder.append("/" + URLEncoder.encode("20220301", "UTF-8")); /* 서비스별 추가 요청인자들 */

			URL url = new URL(urlBuilder.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/xml");
			System.out.println("Response code: " + conn.getResponseCode()); /* 연결 자체에 대한 확인이 필요하므로 추가합니다. */

			// 서비스코드가 정상이면 200~300사이의 숫자가 나옵니다.
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
//			System.out.println(sb.toString());

			// JSON 응답 파싱
			Object obj = parser.parse(sb.toString());
			JSONObject jsonResponse = (JSONObject) obj;

			// "tbTraficElvtr" 객체 추출
			JSONObject trafficElevator = (JSONObject) jsonResponse.get("tbTraficElvtr");

			// "row" 배열 추출
			JSONArray row = (JSONArray) trafficElevator.get("row");

			// 저장할리스트생성
			ArrayList<JSONObject> elevatorList = new ArrayList<>();

			// "row" 배열을 반복하며 데이터를 추출하여 리스트에 추가합니다.
			for (int i = 0; i < row.size(); i++) {
				JSONObject data = (JSONObject) row.get(i);
				elevatorList.add(data);
			}

			// 읍면동 이름
			HashSet<String> emdSet = new HashSet<String>();

			// elevatorList를 반복하면서 EMD_NM 값 추출
			for (JSONObject data : elevatorList) {
				String emd_nm = (String) data.get("EMD_NM");
				
				if (emd_nm != null && !emd_nm.isEmpty())emdSet.add(emd_nm);
			}
			
			//  위도 경도 좌표 리스트
			ArrayList<JSONObject> jsonList = new ArrayList<JSONObject>();
			// 위도 경도 포인트
//			String nodeWkt = "POINT(127.01744971746365 37.57329704981851)";// 읍면동 이름
			for (JSONObject data : elevatorList) {
//				String sggCd = (String) data.get("SGG_CD");
				String sgg_nm = (String) data.get("SGG_NM");
				String nodeWkt = (String) data.get("NODE_WKT");
				// 포인트 제거
				String nodeWkt2 = nodeWkt.substring("POINT(".length(), nodeWkt.length() - 1);
				String[] nodeWktArr = nodeWkt2.split(" ");
//				System.out.println(Arrays.toString(nodeWktArr));
				// 경도
				double longitude = Double.parseDouble(nodeWktArr[0]);
				// 위도
				double latitude = Double.parseDouble(nodeWktArr[1]);
//				System.out.println(longitude);
//				System.out.println(latitude);
				 // 소수점 6자리까지 포맷
				String longitude2 = String.format("%.6f", longitude);
				String latitude2 = String.format("%.6f", latitude);

//				System.out.println("Longitude: " + longitude2);
//				System.out.println("Latitude: " + latitude2);
				
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("sgg_nm",sgg_nm);
				jsonObj.put("longitude",longitude2);
				jsonObj.put("latitude",latitude2);
				jsonList.add(jsonObj);
			}
			// emdset 을 리스트로 반환
			ArrayList<String> emdList = new ArrayList<String>(emdSet);
//			System.out.println("emdList: " + emdList);

			// 시군구 json list
			model.addAttribute("jsonSGGList",jsonSGGList);
			// 엘레베이터 목록
			model.addAttribute("list", elevatorList);
			// 읍면동 이름
			model.addAttribute("emdList", emdList);
			// 좌표 리스트
			model.addAttribute("jsonlist",jsonList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rd.close();
			} catch (IOException e) {
			}
			conn.disconnect();
		}
	}// method
}// service