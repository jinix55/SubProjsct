package com.portal.adm.holiday.model;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.portal.common.paging.Criteria;

import lombok.Data;

@Data
public class HolidayModel extends Criteria {
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
	private String solarDate;
	private String solarDateView;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
	private String lunarDate;
	private String memo;
	private String memoView;
	private String ganji;
	private String holiNm;
	private String holiNmView;
	private String holiType;
	private String holiTypeView;
	private String useYn;
	private String useYnView;
	private String leapYear;
	private String startDate;
	private String endDate;

}
