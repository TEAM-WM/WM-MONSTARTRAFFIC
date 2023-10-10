package com.monstar.traffic.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.monstar.traffic.dao.MetroDao;
import com.monstar.traffic.dto.NoticeDto;
import com.monstar.traffic.vo.SearchVO;

@Service
public class NoticeService implements ServiceInterface {

	@Autowired
	private SqlSession session;

	// 생성자
	public NoticeService(SqlSession session) {
		this.session = session;
	}

	@Override
	public void execute(Model model) {
		MetroDao dao = session.getMapper(MetroDao.class);
//		ArrayList<NoticeDto> dto = dao.listNotice();
		// asMap = 인덱스 번호도 같이 가져올수있다.
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String strPage = request.getParameter("page");

		// 시작 페이지 값이 없다면 1로 변경해준다.
		if (strPage == null) {
			strPage = "1";
		}
		System.out.println("page : " + strPage);
		int page = Integer.parseInt(strPage);

		// 검색 vo에 페이지값 담아주기
		SearchVO searchVO = new SearchVO();
		searchVO.setPage(page);
//		NoticeDto dto = new NoticeDto();
		// 검색
		// 저장할 변수 선언
		String title = "";
		String content = "";
		String[] searchType = request.getParameterValues("searchType");
		System.out.println("mtitle : " + Arrays.toString(searchType));
		// 출력되는지 테스트
		if (searchType != null) {// null 이 아닐때만 돌아주세용
			for (int i = 0; i < searchType.length; i++) {
				System.out.println("mtitle : " + searchType[i]);
			}
		}

		// 변수에 저장하기
		if (searchType != null) {// null 이 아닐때만 돌아주세용
			for (String var : searchType) {
				if (var.equals("title")) {
					title = "title";
					model.addAttribute("title", "true");
				} else if (var.equals("content")) {
					content = "content";
					model.addAttribute("content", "true");
				}
			}
		}

		// 페이징에 검색결과유지
		String searchTitle = request.getParameter("title");
		String searchContent = request.getParameter("content");
//				변수에 저장
		if (searchTitle != null) {// null이 아닐때만 돌아라
			if (searchTitle.equals("title")) {
				title = searchTitle;
				model.addAttribute("title", "true");
			}
		}
		if (searchContent != null) {// null이 아닐때만 돌아라
			if (searchContent.equals("content")) {
				content = searchContent;
				model.addAttribute("content", "true");
			}
		}
		// sk 값 Search Keyword 검색어 가져오기
		String searchKeyword = request.getParameter("sk");
		// 검색어 널값 처리
		if (searchKeyword == null) {
			searchKeyword = "";
		}
		System.out.println("검색어 : " + searchKeyword);
		// 검색에 따른 총갯수 변형
		int total = 0;
//				4개의 경우의 수로 총갯수를 구하기
		if (title.equals("title") && content.equals("")) {
			total = dao.selectBoardTotCount1(searchKeyword);
		} else if (title.equals("") && content.equals("content")) {
			total = dao.selectBoardTotCount2(searchKeyword);
		} else if (title.equals("title") && content.equals("content")) {
			total = dao.selectBoardTotCount3(searchKeyword);
		} else if (title.equals("") && title.equals("")) {
			total = dao.selectBoardTotCount4(searchKeyword);
		}
		// 총 갯수
		System.out.println("total cnt: " + total);
		searchVO.pageCalculate(total);
		/* 페이징 글 번호 전달 */
		int rowStart = searchVO.getRowStart();
		int rowEnd = searchVO.getRowEnd();
//				ArrayList<BoardDto> dto = dao.list(rowStart, rowEnd);
		ArrayList<NoticeDto> dto = null;
		// 리스트에 임의 값 추가
		if (title.equals("title") && content.equals("")) {
			dto = dao.listNotice(rowStart, rowEnd, searchKeyword, "1");
		} else if (title.equals("") && content.equals("content")) {
			dto = dao.listNotice(rowStart, rowEnd, searchKeyword, "2");
		} else if (title.equals("title") && content.equals("content")) {
			dto = dao.listNotice(rowStart, rowEnd, searchKeyword, "3");
		} else if (title.equals("") && content.equals("")) {
			dto = dao.listNotice(rowStart, rowEnd, searchKeyword, "4");
		}
		/* 계산 결과 출력하기 */
		System.out.println("total row: " + total);
		// 모델에 전달하기
		model.addAttribute("searchKey", searchKeyword);
		model.addAttribute("totRowcnt", total);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("list", dto);
	}// method
}// class