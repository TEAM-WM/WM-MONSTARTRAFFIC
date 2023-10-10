package com.monstar.traffic.service;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.monstar.traffic.dao.BikeDao;
import com.monstar.traffic.dto.BikeDto;
import com.monstar.traffic.vopage.SearchVO;

public class BikeNoticeService implements ServiceInterface {

	@Autowired
	private SqlSession sqlSession;

	public BikeNoticeService() {
	}

	public BikeNoticeService(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		System.out.println(">>>BikeNoticeService");
		
		Map<String, Object> map=model.asMap();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		SearchVO searchVO=(SearchVO) map.get("searchVO");
		
		BikeDao dao=sqlSession.getMapper(BikeDao.class);
		
//		searching
		String btitcon = "";
		String btitle = "";
		String bcontent = "";
		String[] searchType = request.getParameterValues("searchType");

//		변수에 저장
		if (searchType != null) {//null이 아닐때만 돌아라
			for (String var : searchType) {
				if(var.equals("btitcon")) {
					btitcon="btitcon";
					model.addAttribute("btitcon","true");
				}else if(var.equals("btitle")) {
					btitle="btitle";
					model.addAttribute("btitle","true");
				}else if(var.equals("bcontent")) {
					bcontent="bcontent";
					model.addAttribute("bcontent","true");
				}
			}
		}
		
//		검색결과유지
		String btc = request.getParameter("btitcon");
		String bt = request.getParameter("btitle");
		String bc = request.getParameter("bcontent");
		
//		변수에 저장
		if (btc != null) {
			if(btc.equals("btitcon")) {
				btitcon=btc;
				model.addAttribute("btitcon","true");
			}			
		}
		if (bt != null) {
			if(bt.equals("btitle")) {
				btitle=bt;
				model.addAttribute("btitle","true");
			}			
		}
		if (bc != null) {
			if(bc.equals("bcontent")) {
				bcontent=bc;
				model.addAttribute("bcontent","true");
			}			
		}
		
//		검색 값 가져오기
		String searchValue = request.getParameter("searchValue");
		if(searchValue == null) {
			searchValue = "";
		}
		model.addAttribute("searchValue",searchValue);
		System.out.println("search : " + searchValue);
		
//		paging
		String strPage = request.getParameter("page");
//		처음 null처리
		if(strPage == null) 
			strPage="1";
		
		int page = Integer.parseInt(strPage);
		searchVO.setPage(page);
		
//		검색에 따른 총 갯수 변형
		int total = 0;

//		4개의 경우의 수로 총갯수 구하기
		if(btitcon.equals("btitcon")) {
			total = dao.TotCount1(searchValue);
		}else if(btitle.equals("btitle")) {
			total = dao.TotCount2(searchValue);
		}else if(bcontent.equals("bcontent")) {
			total = dao.TotCount3(searchValue);
		}else if(btitcon.equals("") && btitle.equals("") && bcontent.equals("")) {
			total = dao.TotCount4(searchValue);
		}
		
		searchVO.pageCalculate(total);
		
//		페이징 글 번호 전달
		int rowStart = searchVO.getRowStart();
		int rowEnd = searchVO.getRowEnd();
		
//		ArrayList<BikeDto> dto = dao.bikeNoticeList();
		ArrayList<BikeDto> dto = null;
		if(btitcon.equals("btitcon")) {
			model.addAttribute("dto",dao.bikeNoticeList(rowStart,rowEnd,searchValue,"1"));
			model.addAttribute("searchType","btitcon");
		}else if(btitle.equals("btitle")) {
			model.addAttribute("dto",dao.bikeNoticeList(rowStart,rowEnd,searchValue,"2"));
			model.addAttribute("searchType","btitle");
		}else if(bcontent.equals("bcontent")) {
			model.addAttribute("dto",dao.bikeNoticeList(rowStart,rowEnd,searchValue,"3"));
			model.addAttribute("searchType","bcontent");
		}else if(btitcon.equals("") && btitle.equals("") && bcontent.equals("")) {
			model.addAttribute("dto",dao.bikeNoticeList(rowStart,rowEnd,searchValue,"4"));
		}
		
		model.addAttribute("totRowcnt",total);
		model.addAttribute("searchVO",searchVO);
	}// method

}// service