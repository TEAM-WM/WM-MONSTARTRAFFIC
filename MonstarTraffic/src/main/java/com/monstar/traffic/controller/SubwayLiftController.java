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
import com.monstar.traffic.service.SubwayLiftService;
import com.monstar.traffic.vopage.SearchVO;

@Controller
public class SubwayLiftController {
	
	@Autowired
	ServiceInterface tbTraficEntrcLft;

	@Autowired
	private SqlSession session;

	/* Java 1.8 코드 / 230920 효슬 추가 */
	// 서울시 지하철 출입구 리프트 위치정보
	@RequestMapping("/subwaylift")
	public String subwaylift(HttpServletRequest request, Model model) throws IOException {
			StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088/6e4c6a625a726c6134364e4b4e7556/xml/tbTraficEntrcLft/1/5/"); /*URL*/

			 /* 인증키 (sample사용시에는 호출 시 제한됩니다.) */
		    String apiKey = "6e4c6a625a726c6134364e4b4e7556";
		    urlBuilder.append("/" + URLEncoder.encode(apiKey, "UTF-8"));

		    /* 요청파일타입 (xml,xmlf,xls,json) */
		    String requestType = "xml";
		    urlBuilder.append("/" + URLEncoder.encode(requestType, "UTF-8"));

		    /* 서비스명 (대소문자 구분 필수입니다.) */
		    String service = "tbTraficEntrcLft";
		    urlBuilder.append("/" + URLEncoder.encode(service, "UTF-8"));

		    /* 요청시작위치 (sample인증키 사용시 5이내 숫자) */
		    int startIndex = 1;
		    urlBuilder.append("/" + startIndex); 

		    /* 요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨) */
		    int endIndex = 5;
		    urlBuilder.append("/" + endIndex);
			// 상위 5개는 필수적으로 순서바꾸지 않고 호출해야 합니다.
		    
		    // 서비스별 추가 요청인자 (예시: 20220301)
//		    String additionalParam = "20220301";
//		    urlBuilder.append("/" + URLEncoder.encode(additionalParam, "UTF-8"));

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
		    String line;
		    while ((line = rd.readLine()) != null) {
		        sb.append(line);
		    }
		    rd.close();
		    conn.disconnect();

			model.addAttribute("request", request);
			
			tbTraficEntrcLft = new SubwayLiftService(session);
			tbTraficEntrcLft.execute(model);
		    
		    return "common/convenience/subwaylift";
		    
		}// subwaylift 종료

}// class 종료