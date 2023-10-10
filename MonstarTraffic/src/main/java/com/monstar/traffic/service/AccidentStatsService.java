package com.monstar.traffic.service;

import java.util.ArrayList;
import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.monstar.traffic.dao.AccidentDao;
import com.monstar.traffic.dto.AccidentDto;

@Service
public class AccidentStatsService implements ServiceInterface2 {

    private SqlSession sqlSession;

    @Autowired
    public AccidentStatsService(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }
    
	/*
	 * @Override public void execute(Model model) { return; }
	 */
    @Override
    public void execute(Model model, String year) {
        AccidentDao dao = sqlSession.getMapper(AccidentDao.class);
        
        ArrayList<AccidentDto> dto = dao.getstats("ACCIDENT"+year, "YEAR"+year);

        List<JSONObject> jsonList = new ArrayList<>();

        // AccidentDto 객체를 JSON 객체로 변환하여 리스트에 추가
        for (AccidentDto accidentDto : dto) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("sum", accidentDto.getSum());
            jsonObject.put("january", accidentDto.getJanuary());
            jsonObject.put("february", accidentDto.getFebruary());
            jsonObject.put("march", accidentDto.getMarch());
            jsonObject.put("april", accidentDto.getApril());
            jsonObject.put("may", accidentDto.getMay());
            jsonObject.put("june", accidentDto.getJune());
            jsonObject.put("july", accidentDto.getJuly());
            jsonObject.put("august", accidentDto.getAugust());
            jsonObject.put("september", accidentDto.getSeptember());
            jsonObject.put("october", accidentDto.getOctober());
            jsonObject.put("november", accidentDto.getNovember());
            jsonObject.put("december", accidentDto.getDecember());

            jsonList.add(jsonObject);
        }

        // 모델에 JSON 데이터 리스트 추가
        model.addAttribute("jsonList", jsonList);
        model.addAttribute("year", year);
        System.out.println("리스트 보낸다" + jsonList);
    }
}
