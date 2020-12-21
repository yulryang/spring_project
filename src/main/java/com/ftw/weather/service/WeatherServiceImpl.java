package com.ftw.weather.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ftw.accident.service.AccidentService;
import com.ftw.weather.mapper.WeatherMapper;
import com.ftw.weather.vo.WeatherVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.webjjang.util.PageObject;

//자동 생성 - @Controller, @Service, @Repository, @Component,
//@RestController, @~Advice
//** servlet-context.xml에 component-scan으로 설정된 패키지 아래의 클래스만 찾아서
//생성해 준다.
@Service
@Log4j
@Qualifier("weatherServiceImpl")
@AllArgsConstructor // 생성자를 이용한 모든 속성을 자동 DI시킨다.
public class WeatherServiceImpl implements WeatherService{

	// @AllArgsConstructor를 이용해서 자동 DI 된다.
	private WeatherMapper mapper;
	
	@Override
	public List<WeatherVO> list(PageObject pageObject) {
		// TODO Auto-generated method stub
		log.info("--- 게시판 리스트 service ----");
		// getRow() 메서드를 이용해서 전체데이터를 셋팅하면 계산이 되어진다.
		pageObject.setTotalRow(mapper.getRow(pageObject));
		log.info(pageObject);
		return mapper.list(pageObject);
	}

	@Override
	public WeatherVO view(int no, int inc) {
		// TODO Auto-generated method stub
		// inc가 1일 때만 조회수 증가 -> 데이터 가져오기
		if(inc == 1) mapper.increase(no);
		return mapper.view(no);
	}

	@Override
	public void write(WeatherVO vo) {
		// TODO Auto-generated method stub
		mapper.write(vo);
	}

	@Override 
	public void update(WeatherVO vo) {
		// TODO Auto-generated method stub
		mapper.update(vo);
	}

	@Override
	public void delete(WeatherVO vo) {
		// TODO Auto-generated method stub
		mapper.delete(vo);
	}

}