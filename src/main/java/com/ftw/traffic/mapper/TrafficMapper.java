package com.ftw.traffic.mapper;

import java.util.List;

import com.ftw.traffic.vo.TrafficVO;

import net.webjjang.util.PageObject;

public interface TrafficMapper 
{

	//1. list - 전체 데이터 구하기(페이지 처리)
	public List<TrafficVO> list(PageObject pageObject);
	public Integer getRow(PageObject pageObject);
	
	//2. view - 조회수 1증가
	public TrafficVO view(int no);
	public void increase(int no);
	
	//3. write
	public void write(TrafficVO vo);
	
	//4. update
	public void update(TrafficVO vo);	
	
	//5. delete - no, pw
	public void delete(int no);	
	
}
