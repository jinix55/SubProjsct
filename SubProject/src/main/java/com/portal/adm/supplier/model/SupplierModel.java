package com.portal.adm.supplier.model;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.portal.common.paging.Criteria;

import lombok.Data;

@Data
public class SupplierModel extends Criteria {
	private String rownum;          					// 순번
	private String supplierId;							// 공급업체 ID
	private String supplierNm;							// 공급업체 명
	private String supplierDsc;							// 공급업체 설명
	private String supplierCode;						// 공급업체 코드
	private String supplierNo;							// 공급업체 사업자번호
	private String up_companyId;						// 공급업체 소속 회사
    private String useYn;								// 사용여부
    private String rgstId;								// 등록자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")	// spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime rgstDt;						// 등록일시
    private String modiId;								// 수정자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")	// spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime modiDt;						// 수정일시
    private String searchKey;       // 검색키
    private String searchValue;     // 검색값

}
