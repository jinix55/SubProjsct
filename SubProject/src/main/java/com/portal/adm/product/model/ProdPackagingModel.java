package com.portal.adm.product.model;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.portal.common.paging.Criteria;

import lombok.Data;

/**
 * 코드관리 모델
 */
@Data
public class ProdPackagingModel extends Criteria{
    
	private String packagingId;
	private String productCode;
	private String subProductCode;
	private int packagingOrder;
	private String packagingOrderNm;
	private String groupId;
	private String codeId;
    private String useYn;           // 사용여부
    private String rgstId;          // 등록자ID
    private String modiId;          // 수정자ID
    
    //-----------------------------------------------------------------------------------------------
    
    private String rownum;          // 순번
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")  // spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime rgstDt; // 등록일시
    private String rgstDtStr;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")  // spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime modiDt; // 수정일시
    private String modiDtStr;
    private Integer ordSeq;			//정렬순서
	
    //-----------------------------------------------------------------------------------------------	
	
    private String apiKey;
   
    private String productNm;
    private String groupNm;
    private String codeNm;
    
    private String str;   //1차포장_종이팩_몸체_KAMILL 
}
