package com.monstar.traffic.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.monstar.traffic.dao.MetroDao;
import com.monstar.traffic.dto.NoticeDto;

@Service
public class NoticeViewService implements ServiceInterface{

	@Autowired
	private SqlSession session;
	
	// 생성자
	public NoticeViewService(SqlSession session) {
		this.session = session;
	}

	@Override
	public void execute(Model model) {
		MetroDao dao = session.getMapper(MetroDao.class);
		Map<String, Object> asMap = model.asMap();
		int no = (Integer)asMap.get("no");
		System.out.println(no);
		NoticeDto dto = dao.getData(no);
		dao.upHit(no);
		model.addAttribute("dto", dto);
	}//method
}//class