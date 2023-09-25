package com.monstar.traffic.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.monstar.traffic.dao.SubwayLiftDao;
import com.monstar.traffic.dto.SubwayLiftDto;

@Service
public class SubwayLiftService implements ServiceInterface {

	@Autowired
	private SqlSession session;

	public SubwayLiftService(SqlSession session) {
		this.session = session;
	}

	@Override
	public void execute(Model model) {
		System.out.println(">>>리프트 리스트 신호");

		SubwayLiftDao dao = session.getMapper(SubwayLiftDao.class);

		// DAO를 통해 데이터베이스에서 데이터 가져오기
		List<SubwayLiftDto> liftinfo = dao.subwaylift();

		JSONArray arr = new JSONArray();
		for (SubwayLiftDto lift : liftinfo) {
			JSONObject obj = new JSONObject();
			obj.put("type", lift.getType());
			obj.put("node_wkt", lift.getNode_wkt());
			obj.put("node_id", lift.getNode_id());
			obj.put("node_code", lift.getNode_code());
			obj.put("sgg_cde", lift.getSgg_cde());
			obj.put("sgg_nm", lift.getSgg_nm());
			obj.put("node_code", lift.getEmd_cd()); // 주의: 중복된 키 사용, 수정 필요
			obj.put("emd_nm", lift.getEmd_nm());
			obj.put("sw_cd", lift.getSw_cd());
			obj.put("sw_nm", lift.getSw_nm());

			if (obj != null)
				arr.add(obj);
		}

		// 모델에 리프트 정보 및 JSON 배열 추가
		model.addAttribute("liftinfo", liftinfo);
		model.addAttribute("arr", arr);

		System.out.println("리프트 정보 조회 완료");
	}
}
