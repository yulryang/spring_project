package com.ftw.member.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.ftw.member.vo.MemberVO;

import net.webjjang.util.PageObject;

public interface MemberService {

	// 아이디 찾기
	public String findUserid(String email);

	// 비밀번호 찾기
	public boolean findUserpw(MemberVO vo);

	// 회원 리스트
	public List<MemberVO> list(PageObject pageObject);

	// 회원 정보 & 내 정보
	public MemberVO view(String userid);

	// 회원 가입
	public void join(MemberVO vo);

	// 내 정보 수정
	public boolean update(MemberVO vo);

	// 비밀번호 확인
	public String check(String userid);

	// 비밀번호 수정
	public boolean change(MemberVO vo);

	// 회원 정지
	public void stop(String userid);

	// 회원 정지 해제
	public void clear(String userid);

	// 회원 탈퇴
	public void exit(String userid, HttpSession session);

	// 이메일 중복 확인
	public int dup_email(String email);

	// 회원 통계
	public List<String> cnt();
}
