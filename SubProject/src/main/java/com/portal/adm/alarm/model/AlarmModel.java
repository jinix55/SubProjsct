package com.portal.adm.alarm.model;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.portal.common.paging.Criteria;

import lombok.Data;

/**
 * 회사관리 모델
 */
@Data
public class AlarmModel extends Criteria{

    private String rownum;          					// 순번
    private String alarmId;							// 회사ID
    private String sj;							// 회사이름
    private String cn;							// 회사설명
    private String alarmSe;							// 회사이름
    private String senderId;								// 사용여부
    private String recipientId;								// 등록자ID
    private String checkYn;								// 사용여부
    private String rgstId;								// 등록자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")	// spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    private LocalDateTime rgstDt;						// 등록일시
    private String modiId;								// 수정자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")	// spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    private LocalDateTime modiDt;						// 수정일시
    
}
