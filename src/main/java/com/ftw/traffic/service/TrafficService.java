package com.ftw.traffic.service;

import java.util.List;

import com.ftw.traffic.vo.TrafficVO;

import net.webjjang.util.PageObject;

public interface TrafficService {

	// 1. list
	public List<TrafficVO> list(PageObject pageObject);
	
	// 2.  view
	public TrafficVO view(int no, int inc);
	
	// 3. write
	public void write(TrafficVO vo);
	
	// 4. update
	public void update(TrafficVO vo);
	
	// 5. delete
	public void delete(int no);
	
}
