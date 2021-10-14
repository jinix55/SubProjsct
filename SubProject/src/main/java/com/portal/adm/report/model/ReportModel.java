package com.portal.adm.report.model;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import com.portal.common.paging.Criteria;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 레포트관리 모델
 */
@Data
public class ReportModel extends Criteria{

    private String rownum;          					// 순번
    private String reportId;							// 레포트 ID
    private String reportNm;							// 레포트이름
    private String reportUrl;							// 레포트 url
    private String companyId;							// 회사 ID
    private String reportSize;							// 레포트 사이즈
    private String useYn;								// 사용여부
    private String rgstId;								// 등록자 ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")	// spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    private LocalDateTime rgstDt;						// 등록일시
    private String modiId;								// 수정자 ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")	// spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    private LocalDateTime modiDt;						// 수정일시
    
}
