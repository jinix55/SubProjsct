package com.portal.adm.company.model;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import com.portal.common.paging.Criteria;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 회사관리 모델
 */
@Data
public class CompanyModel extends Criteria{

    private String rownum;          					// 순번
    private String companyCode;     				    // 회사회사
    private String companyId;							// 회사ID
    private String companyNo;							// 회사 사업자번호
    private String companyNm;							// 회사이름
    private String companyDsc;							// 회사설명
    private String address;								// 회사주소
    private String telephoneNo;							// 회사 대표번호
    private String representativeNm;					// 회사 대표자명
    private String note;								// 회사 비고
    private String useYn;								// 사용여부
    private String rgstId;								// 등록자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")	// spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    private LocalDateTime rgstDt;						// 등록일시
    private String modiId;								// 수정자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")	// spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    private LocalDateTime modiDt;						// 수정일시
    
}
