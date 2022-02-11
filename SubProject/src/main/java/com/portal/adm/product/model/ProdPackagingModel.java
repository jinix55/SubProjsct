package com.portal.adm.product.model;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.portal.common.paging.Criteria;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 코드관리 모델
 */
@Data
public class ProdPackagingModel extends Criteria{
    private String rownum;          // 순번
    private String packagingId;
    private String productId;
    private String productNm;
    private String packagingNm;
    private String packagingDsc;
    private String packagingOrder;
    private String matType;
    private String partType;
    private String matInfo;
    private String weight;
    private String standard;
    private String color;
    private String addExplan;
    private String matFileId;
    private String supplierCode;
    private String supplierNm;
    private String representativeNm;
	private String managerId; 
	private String managerNm; 
	private String managerMail;
	private String managementId;
	private String managementNm;
    private String useYn;           // 사용여부
    private String rgstId;          // 등록자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")  // spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime rgstDt; // 등록일시
        private String modiId;          // 수정자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")  // spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime modiDt; // 수정일시
}
