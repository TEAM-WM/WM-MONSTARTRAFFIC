package com.monstar.traffic.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.monstar.traffic.dao.BikeDao;
import com.monstar.traffic.dto.BikeDto;

public class BikeNoticeDetailService implements ServiceInterface {

	@Autowired
	private SqlSession sqlSession;

	public BikeNoticeDetailService() {
	}

	public BikeNoticeDetailService(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		System.out.println(">>>BikeNoticeDetailService");
		
		Map<String, Object> map=model.asMap();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		
		int bikeno = Integer.parseInt(request.getParameter("no"));
		
		BikeDao dao=sqlSession.getMapper(BikeDao.class);
		BikeDto dto = dao.bikeNoticeDetail(bikeno);
		BikeDto move = dao.movePage(bikeno);
		
		model.addAttribute("dto",dto);
		model.addAttribute("move",move);
	}// method

}// service