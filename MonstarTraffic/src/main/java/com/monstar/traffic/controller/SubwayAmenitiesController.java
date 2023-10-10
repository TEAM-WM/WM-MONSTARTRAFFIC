package com.monstar.traffic.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.monstar.traffic.service.ServiceInterface;
import com.monstar.traffic.service.SubwayAmenitiesService;
import com.monstar.traffic.vopage.SearchVO;

@Controller
public class SubwayAmenitiesController {
	
	@Autowired	
	ServiceInterface odblrDspsnCvntl;

	@Autowired
	private SqlSession session;

	/* Java 1.8 코드 / 230921 효슬 추가 */
	// 서울시 지하철 역사 노약자 장애인 편의시설 현황
	@RequestMapping("/amenities")
	public String amenities(HttpServletRequest request, SearchVO searchVO, Model model) throws IOException {
			StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088/684f6b6d56726c6136336772595545/xml/OdblrDspsnCvntl/1/5/"); /*URL*/

			/* 인증키 (sample사용시에는 호출시 제한됩니다.) */
		    String key = "684f6b6d56726c6136336772595545";
		    urlBuilder.append("/" + URLEncoder.encode(key, "UTF-8"));

		    /* 요청파일타입 (xml,xmlf,xls,json) */
		    String type = "xml";
		    urlBuilder.append("/" + URLEncoder.encode(type, "UTF-8"));

		    /* 서비스명 (대소문자 구분 필수입니다.) */
		    String service = "OdblrDspsnCvntl";
		    urlBuilder.append("/" + URLEncoder.encode(service, "UTF-8"));

		    /* 요청시작위치 (sample인증키 사용시 5이내 숫자) */
		    int start_index = 1;
		    urlBuilder.append("/" + start_index);

		    /* 요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨) */
		    int end_index = 5;
		    urlBuilder.append("/" + end_index);
			// 상위 5개는 필수적으로 순서바꾸지 않고 호출해야 합니다.
		    
		    // 서비스별 추가 요청인자 (선택사항)
		    String line = "";	//호선
		    urlBuilder.append("/" + URLEncoder.encode(line, "UTF-8"));

		    String statn_nm = "";	//역명
		    urlBuilder.append("/" + URLEncoder.encode(statn_nm, "UTF-8"));
		    
		    URL url = new URL(urlBuilder.toString());
		    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		    conn.setRequestMethod("GET");
		    conn.setRequestProperty("Content-type", "application/xml");
		    System.out.println("Response code: " + conn.getResponseCode());
		    BufferedReader rd;

		    if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
		        rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		    } else {
		        rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		    }

		    StringBuilder sb = new StringBuilder();
		    String line1;
		    while ((line1 = rd.readLine()) != null) {
		        sb.append(line1);
		    }
		    rd.close();
		    conn.disconnect();

			model.addAttribute("request", request);
			model.addAttribute("searchVO", searchVO);
			
			odblrDspsnCvntl = new SubwayAmenitiesService(session);
			odblrDspsnCvntl.execute(model);
		    
		    return "common/convenience/subwayamenities";
		    
		}// subwaylift 종료

}// class 종료