package com.portal.adm.holiday.mapper;

import java.util.List;

import com.portal.adm.holiday.model.HolidayModel;
import com.portal.common.annotation.ConnMapperFirst;
import com.portal.common.paging.Criteria;

@ConnMapperFirst
public interface HolidayMapper {
	
	/**
	 * 휴알관리 목록을 조회 한다.
	 * 
	 * @param criteria
	 * @return List<HolidayModel>
	 */
	List<HolidayModel> selectHolidayList(HolidayModel model);
	
	/**
	 * 휴알관리 목록 카운트를 조회 한다.
	 * 
	 * @param criteria
	 * @return List<HolidayModel>
	 */
	int selectHolidayListCount(HolidayModel model);
	
	/**
	 * 휴알관리 목록을 조회 한다.
	 * 
	 * @param criteria
	 * @return List<HolidayModel>
	 */
	HolidayModel selectHolidayOne(String solarDate);
	
	/**
	 * 휴일을 입력한다.
	 * 
	 *@param criteria
	 */
	long insertHolidayOne(HolidayModel model);
	
	/**
	 * 휴일을 수정한다.
	 * 
	 *@param criteria
	 */
	long updatetHolidayOne(HolidayModel model);
	
	/**
	 * 휴일을 삭제한다.
	 * 
	 *@param criteria
	 */
	long deleteHolidayOne(HolidayModel model);
	
	/**
	 * 서비스 ON/OFF를 수정한다.
	 * 
	 *@param criteria
	 */
	long updatetHolidayActive(HolidayModel model);
	
}
