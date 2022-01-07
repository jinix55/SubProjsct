package com.portal.adm.environmentCode.model;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.portal.common.paging.Criteria;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 환경부코드관리 모델
 */
@Data
public class EnvironmentCodeModel extends Criteria{

    private String rownum;          // 순번
    private String groupId;         // 코드그룹ID
    private String upCompanyCode;   // 소속 회사코드
    private String revisionYear;	// 개정 년
    private String revisionMonth;	// 개정 월
    private String codeId;          // 코드ID
    private String codeKey;          // 코드ID
    private String codeNm;          // 코드이름
    private String codeDsc;        // 코드설명
    private String useYn;           // 사용여부
    private String rgstId;          // 등록자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")  // spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime rgstDt; // 등록일시
    private String rgstDtStr;
    private String modiId;          // 수정자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")  // spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime modiDt; // 수정일시
    private Integer ordSeq;			//정렬순서
    private String largeCategory;	//대분류
    private String middelCategory;	//대분류
    private String smallCategory;	//대분류
    private String detailCategory;	//대분류
}

