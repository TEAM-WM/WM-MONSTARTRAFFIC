package com.monstar.traffic.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.monstar.traffic.service.NoticeInsertService;
import com.monstar.traffic.service.NoticeService;
import com.monstar.traffic.service.NoticeViewService;
import com.monstar.traffic.service.ServiceInterface;

//리연 작성 230920
@Controller
public class NoticeController {

	@Autowired
	private SqlSession sqlSession;

	ServiceInterface service;

	@RequestMapping("/notice")
	public String notice(Model model, HttpServletRequest request) {
		service = new NoticeService(sqlSession);
		model.addAttribute("request",request);
		service.execute(model);
		return "common/notice/list";
	}// method

	@RequestMapping("/notice/form")
	public String noticeInsertForm(Model model) {
		return "common/notice/insertForm";
	}// method

	@PostMapping("/notice/insert")
	public String noticeInsert(RedirectAttributes redirectAttributes, Model model,
			@RequestParam("content") String content, @RequestParam("title") String title) {
		model.addAttribute("content", content);
		model.addAttribute("title", title);
		// 데이터를 RedirectAttributes에 추가
		redirectAttributes.addFlashAttribute("content", content);
		redirectAttributes.addFlashAttribute("title", title);
		service = new NoticeInsertService(sqlSession);
		service.execute(model);
		return "redirect:/notice";
	}// method

	@RequestMapping("/notice/view")
	public String noticeView(Model model, @RequestParam("no") int no) {
		service = new NoticeViewService(sqlSession);
		model.addAttribute("no", no);
		service.execute(model);
		return "common/notice/view";
	}// method
	
	@RequestMapping("/notice/ckUpload")
	public void ckUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam("upload") MultipartFile file)
			throws Exception {
		PrintWriter printWriter = null;
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		if (file != null && !file.isEmpty()) {
			String fileName1 = file.getOriginalFilename();
			String fileName2 = UUID.randomUUID().toString();
			String fileName = fileName2+fileName1;
			// 파일 업로드 경로 설정
			String localPath = "/Users/klyeon/git/WM-MONSTARTRAFFIC/MonstarTraffic/src/main/webapp";
			String uploadPath = localPath + "/resources/ckeditor";

			// 파일 저장
			File uploadFile = new File(uploadPath, fileName);
			file.transferTo(uploadFile);

			// 파일 URL 구성
			String fileUrl = request.getContextPath() + "/resources/ckeditor/" + fileName; // URL 경로
			System.out.println("fileUrl :" + fileUrl);

			printWriter = response.getWriter();

			// 메타데이터 JSON 파일 저장
			JsonObject json = new JsonObject();
			json.addProperty("uploaded", 1);
			json.addProperty("fileName", fileName);
			json.addProperty("url", fileUrl);
			printWriter.print(json);
			System.out.println(json);
		}
	}// method
}// home