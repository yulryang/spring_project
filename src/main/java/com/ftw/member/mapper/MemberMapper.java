package com.ftw.member.mapper;

import java.util.List;

import com.ftw.member.vo.CntVO;
import com.ftw.member.vo.MemberVO;

import net.webjjang.util.PageObject;

public interface MemberMapper {

	// 로그인 정보
	public MemberVO read(String userid);

	// 아이디 찾기
	public String findUserid(String email);

	// 비밀번호 찾기
	public String findUserpw(MemberVO vo);

	// 회원 리스트
	public List<MemberVO> list(PageObject pageObject);

	public Integer getRow(PageObject pageObject);

	// 회원 정보 & 내 정보
	public MemberVO view(String userid);

	// 회원 가입
	public void join(MemberVO vo);

	public void auth(String userid);

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
	public void delete(String userid);

	public void exit(String userid);

	// 이메일 중복 확인
	public MemberVO dup_email(String email);

	// 회원 통계
	public List<CntVO> cnt();
}