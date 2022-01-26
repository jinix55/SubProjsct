package com.portal.api.model;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

/**
 * 포장 api 모델
 */
@Data
public class ApiExtrnlModel {

    private String rownum;              				// 순번
    private String ApiKey;            					// 포장 api key
    private String fromCompanyCode;            			// 보내는 회사 코드
    private String fromCompanyNm;            			// 보내는 회사 명
    private String toCompanyCode;           			// 포장 api 받는 회사 코드
    private String toCompanyNm;           				// 포장 api 받는 회사 명
    private String managerId;          					// 포장 공급업체 담당자 아이디
    private String managerNm;          					// 포장 공급업체 담당자 명
    private String managerMail;          				// 받는사람(담당자) 메일
    private String useYn;               				// 사용여부
    private String rgstId;              				// 등록자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime rgstDt;     					// 등록일시
    private String modiId;              				// 수정자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime modiDt;     					// 수정일시
}
