package com.ftw.member.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ftw.member.service.MemberService;
import com.ftw.member.vo.MemberVO;

import lombok.extern.log4j.Log4j;
import net.webjjang.util.PageObject;

@Controller
@RequestMapping("/member/*")
@Log4j
public class MemberController {

	@Qualifier("ms")
	@Autowired
	private MemberService service;
	private final String MODULE = "member/";
	@Autowired
	private PasswordEncoder pwencoder;

	// 로그인
	@GetMapping("/login.do")
	public String loginForm(String error, Model model) {

		log.info("error:" + error);

		if (error != null) {
			model.addAttribute("error", "로그인에 실패했습니다. 비밀번호나 아이디를 확인해주세요.");
		}

		return MODULE + "login";
	}

	// 로그아웃
	@GetMapping("/logout.do")
	public String logout() {

		return "sendRedirect:/main/index.do";
	}

	// 회원 리스트
	@GetMapping("/list.do")
	public String list(Model model, PageObject pageObject) {

		model.addAttribute("list", service.list(pageObject));
		model.addAttribute("pageObject", pageObject);
		log.info("admin only");

		return MODULE + "list";
	}

	// 회원 정보
	@GetMapping("/view.do")
	public String view(Model model, PageObject pageObject, String userid) {

		log.info("view.userid:" + userid);
		model.addAttribute("vo", service.view(userid));
		model.addAttribute("pageObject", pageObject);

		return MODULE + "view";
	}

	// 내 정보
	@GetMapping("/my.do")
	public String my(Model model, String userid) {

		log.info("my.userid:" + userid);
		MemberVO vo = new MemberVO();
		vo = service.view(userid);

		// 이메일 분리
		String email = vo.getEmail();
		String[] emailL = email.split("@");
		String email1 = emailL[0];
		String email2 = emailL[1];
		log.info("email1:" + email1);
		log.info("email2:" + email2);
		vo.setEmail1(email1);
		vo.setEmail2(email2);

		// 지역 분리
		String local1 = vo.getLocal1();
		String sido1 = "";
		String gugun1 = "";
		String local2 = vo.getLocal2();
		String sido2 = "";
		String gugun2 = "";
		String local3 = vo.getLocal3();
		String sido3 = "";
		String gugun3 = "";

		if (local1 != null) {
			String[] local1L = local1.split(" ");
			sido1 = local1L[0];
			gugun1 = local1L[1];
		}
		if (local2 != null) {
			String[] local2L = local2.split(" ");
			sido2 = local2L[0];
			gugun2 = local2L[1];
		}
		if (local3 != null) {
			String[] local3L = local3.split(" ");
			sido3 = local3L[0];
			gugun3 = local3L[1];
		}
		log.info("sido1 + gugun1" + sido1 + "+" + gugun1);
		log.info("sido2 + gugun2" + sido2 + "+" + gugun2);
		log.info("sido3 + gugun3" + sido3 + "+" + gugun3);
		vo.setSido1(sido1);
		vo.setSido2(sido2);
		vo.setSido3(sido3);
		vo.setGugun1(gugun1);
		vo.setGugun1(gugun2);
		vo.setGugun1(gugun3);

		model.addAttribute("vo", vo);

		return MODULE + "my";
	}

	// 회원 가입
	@GetMapping("/join.do")
	public String joinForm() {
		log.info("joinForm()");

		return MODULE + "join";
	}

	@PostMapping("/join.do")
	public String join(MemberVO vo) {

		String rawPw = vo.getUserpw();
		log.info("join.rawPW:" + rawPw);
		vo.setUserpw(pwencoder.encode(rawPw));

		String sido1 = vo.getSido1();
		String sido2 = vo.getSido2();
		String sido3 = vo.getSido3();
		log.info("sido3" + sido3);
		if (sido1 != null) {
			if (!sido1.equals("시/도 선택")) {
				vo.setLocal1(vo.getSido1() + " " + vo.getGugun1());
			}
		}
		else {
			vo.setLocal1("");
		}
		if (sido2 != null) {
			if (!sido2.equals("시/도 선택")) {
				vo.setLocal2(vo.getSido2() + " " + vo.getGugun2());
			}
		}
		else {
			vo.setLocal2("");
		}
		if (sido3 != null) {
			if (!sido3.equals("시/도 선택")) {
				vo.setLocal3(vo.getSido3() + " " + vo.getGugun3());
			}
		}else {
			vo.setLocal3("");
		}
		log.info("join.local1" + vo.getLocal1());
		log.info("join.local2" + vo.getLocal2());
		log.info("join.local3" + vo.getLocal3());

		log.info(vo);
		service.join(vo);
		return "redirect:welcome.do";
	}

	@GetMapping("/welcome.do")
	public String welecome() {

		return MODULE + "welcome";
	}

	// 내 정보 수정
	@PostMapping("/update.do")
	public String update(MemberVO vo, Model model) {

		String sido1 = vo.getSido1();
		String sido2 = vo.getSido2();
		String sido3 = vo.getSido3();
		if(sido1 != null) {
			vo.setLocal1(vo.getSido1() + " " + vo.getGugun1());
		}
		if(sido2 != null) {
			vo.setLocal2(vo.getSido2() + " " + vo.getGugun2());
		}
		if(sido3 != null) {
			vo.setLocal3(vo.getSido3() + " " + vo.getGugun3());
		}
		log.info("join.local1" + vo.getLocal1());
		log.info("join.local2" + vo.getLocal2());
		log.info("join.local3" + vo.getLocal3());

		log.info("update.vo:" + vo);
		if (service.update(vo) == true) {
			model.addAttribute("success", "정보 변경 완료");
		}

		return "redirect:my.do?userid=" + vo.getUserid();
	}

	// 비밀번호 확인
	@GetMapping("/pw_check.do")
	public String pw_checkForm() {

		return MODULE + "pw_check";
	}

	@PostMapping("/pw_check.do")
	public String pw_check(String userpw, HttpSession session, int chk, Model model, String userid) {

		log.info("pw_check.loginId:" + userid);
		log.info("pw_check.inputPw:" + userpw);
		boolean result = pwencoder.matches(userpw, service.check(userid));
		log.info("비밀번호 매치:" + result);
		if (result == true) {
			// 비밀번호 변경
			if (chk == 1) {
				model.addAttribute("success", "비밀번호 확인");
				return "redirect:change.do?userid=" + userid;
			}
			// 회원 탈퇴
			else if (chk == 2) {
				service.exit(userid, session);
				return "redirect:thanks.do?";
			}
		} else {
			model.addAttribute("msg", "비밀번호가 틀립니다. 다시 입력해주세요");
			return "redirect:pw_check.do?chk=" + chk + "&userid=" + userid;
		}
		return "";
	}

	// 비밀번호 변경
	@GetMapping("/change.do")
	public String changeForm() {

		return MODULE + "change";
	}

	@PostMapping("/change.do")
	public String change(String userpw, String userid, Model model) {

		log.info("change.userid" + userid);
		log.info("change.userpw" + userpw);
		MemberVO vo = new MemberVO();
		vo.setUserid(userid);
		vo.setUserpw(pwencoder.encode(userpw));
		log.info("change.vo:" + vo);

		if (service.change(vo) == true) {
			model.addAttribute("pw_success", "비밀번호 변경 성공");
			return "redirect:my.do?userid=" + userid;
		} else {
			model.addAttribute("error", "비밀번호 변경 실패");
			return "redirect:change.do?userid=" + userid;
		}
	}

	// 회원 정지
	@GetMapping("/stop.do")
	public String stop(String userid) {

		service.stop(userid);

		return "redirect:list.do";
	}

	// 회원 정지 해제
	@GetMapping("/clear.do")
	public String clear(String userid) {

		service.clear(userid);

		return "redirect:view.do?userid=" + userid;
	}

	// 회원 탈퇴 완료
	@GetMapping("/thanks.do")
	public String thanks() {

		return MODULE + "thanks";
	}
	
	// 회원 통계
		@GetMapping("/cnt.do")
		public String cnt(Model model) {

			List<String> cnt_data = service.cnt();
			log.info("con.cnt_data:" + cnt_data);

			HashMap<String, Integer> cnt = new HashMap<>();
			for (int i = 0; i < cnt_data.size(); i++) {
				if (cnt.containsKey(cnt_data.get(i))) {
					cnt.put(cnt_data.get(i), cnt.get(cnt_data.get(i)) + 1);
				} else {
					cnt.put(cnt_data.get(i), 1);
				}
			}

			log.info("cnt.cnt" + cnt);
			
			Iterator it = MemberController.sortByValue(cnt).iterator();

			String data = "[";
			for(int i=0;i<10;i++) {
				String temp = (String) it.next();
				data += "['" + temp + "', ";
				data += cnt.get(temp) + "], ";
			}
			// 마지막 쉼표 제거
			data = data.substring(0, data.length() - 2);
			data += "]";

			log.info("categories:" + data);

			model.addAttribute("data", data);

			return MODULE + "cnt";
		}

		// 회원 통계용 정렬
		public static List sortByValue(final Map map) {
			List<String> list = new ArrayList();
			list.addAll(map.keySet());

			Collections.sort(list, new Comparator() {

				public int compare(Object o1, Object o2) {
					Object v1 = map.get(o1);
					Object v2 = map.get(o2);

					return ((Comparable) v1).compareTo(v2);
				}

			});
			Collections.reverse(list); // 주석시 오름차순
			return list;
		}
}
