package com.portal.adm.holiday.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.portal.common.Constant;
import com.portal.common.paging.Criteria;

import javax.annotation.Resource;

import org.apache.poi.util.SystemOutLogger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.portal.adm.holiday.mapper.HolidayMapper;
import com.portal.adm.holiday.model.HolidayModel;
import com.portal.adm.member.mapper.MemberMapper;
import com.portal.adm.member.model.MemberModel;
import com.portal.common.paging.Criteria;

@Service
public class HolidayService {
	@Resource
	private HolidayMapper mapper;
	
	@Resource
	private MemberMapper memberMapper;
	
	/**
	 * 휴일 목록을 조회한다.
	 * 
	 *@param criteria
	 */
	public List<HolidayModel> selectHolidayList(HolidayModel model){
		return mapper.selectHolidayList(model);
	}
	
	/**
	 * 휴일 목록 카운트를 조회한다.
	 * 
	 *@param criteria
	 */
	public int selectHolidayListCount(HolidayModel model){
		return mapper.selectHolidayListCount(model);
	}
	
	/**
	 * 선택한 공휴일을 조회한다.
	 * 
	 *@param criteria
	 */
	public HolidayModel selectHolidayOne(String solarDate){
		return mapper.selectHolidayOne(solarDate); 
	}
	
	/**
	 * 휴일을 입력한다.
	 * 
	 *@param criteria
	 */
	public String insert(HolidayModel model){
		HolidayModel h = new HolidayModel();
		h.setSolarDate(model.getSolarDate());
		h.setHoliNm(model.getHoliNm());
		h.setHoliType(model.getHoliType());
		h.setUseYn(model.getUseYn());
		
		long count = mapper.insertHolidayOne(h);

		if (count > 0) {
			return Constant.DB.INSERT;
		} else {
			return Constant.DB.FAIL;
		}
	}
	
	/**
	 * 휴일 정보를 수정한다.
	 *
	 * @param model 사번을 사용
	 * @return
	 */
	@Transactional
	public String save(HolidayModel model) {
		HolidayModel h = new HolidayModel();
		h.setSolarDate(model.getSolarDate());
		h.setHoliNm(model.getHoliNm());
		h.setHoliType(model.getHoliType());   
		h.setUseYn(model.getUseYn());
		System.out.println("----------"+h);
		
	
		long count = mapper.updatetHolidayOne(h);
		
		if (count > 0) {
			return Constant.DB.UPDATE;
		} else {
			return Constant.DB.FAIL;
		}
	}
	
	@Transactional
    public String holidayActive(HolidayModel model) {
        long count = mapper.updatetHolidayActive(model);
        if (count > 0) {
			return Constant.DB.UPDATE;
		} else {
			return Constant.DB.FAIL;
		}
    }    
}
