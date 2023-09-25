package com.monstar.traffic.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.monstar.traffic.dao.SubwayAmenitiesDao;
import com.monstar.traffic.dto.SubwayAmenitiesDto;
import com.monstar.traffic.vo.SearchVO;

@Service
@Primary
public class SubwayAmenitiesService implements ServiceInterface {

	@Autowired
	private SqlSession session;

	public SubwayAmenitiesService(SqlSession session) {
		this.session = session;
	}

	@Override
	public void execute(Model model) {
		System.out.println(">>>편의시설 리스트 신호");
		Map<String, Object> map=model.asMap();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		SearchVO searchVO=(SearchVO) map.get("searchVO");
		
		SubwayAmenitiesDao dao = session.getMapper(SubwayAmenitiesDao.class);

		// DAO를 통해 데이터베이스에서 데이터 가져오기
		List<SubwayAmenitiesDto> amenityinfo = dao.amenities();
		List<SubwayAmenitiesDto> sumLine = dao.sumLine();
		
		JSONArray array = new JSONArray();
		for (SubwayAmenitiesDto amenity : amenityinfo) {
			JSONObject obj = new JSONObject();
			obj.put("line", amenity.getLine());
			obj.put("statn_nm", amenity.getStatn_nm());
			obj.put("elvtr", amenity.getElvtr());
			obj.put("escltr", amenity.getEscltr());
			obj.put("wheelchair_lift", amenity.getWheelchair_lift());
			obj.put("hrzntlty_atmc_ftpth", amenity.getHrzntlty_atmc_ftpth());

			if (obj != null)
				array.add(obj);
		}

		// 모델에 리프트 정보 및 JSON 배열 추가
		model.addAttribute("amenityinfo", amenityinfo);
		model.addAttribute("sumLine", sumLine);
		model.addAttribute("array", array);

		System.out.println("편의시설 정보 조회 완료");
	}
}
