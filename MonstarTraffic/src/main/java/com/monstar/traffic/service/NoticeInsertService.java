package com.monstar.traffic.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.monstar.traffic.dao.MetroDao;
import com.monstar.traffic.dto.NoticeDto;

@Service
public class NoticeInsertService implements ServiceInterface{

	@Autowired
	private SqlSession session;
	
	// 생성자
	public NoticeInsertService(SqlSession session) {
		this.session = session;
	}

	@Override
	public void execute(Model model) {
		MetroDao dao = session.getMapper(MetroDao.class);
		Map<String, Object> map = model.asMap();
		String content = (String)map.get("content");
		String title = (String)map.get("title");
		
		NoticeDto dto = new NoticeDto();
		dto.setTitle(title);
		dto.setContent(content);
		dao.insert(dto);
	}//method
}//class