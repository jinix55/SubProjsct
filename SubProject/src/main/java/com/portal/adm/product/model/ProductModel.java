package com.portal.adm.product.model;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.portal.adm.code.model.CodeModel;
import com.portal.common.paging.Criteria;

import lombok.Data;

/**
 * 코드관리 모델
 */
@Data
public class ProductModel extends Criteria{

    private String rownum;          // 순번
    private String groupId;         // 코드그룹ID
    private String upCompanyCode;   // 소속 회사코드
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
    
    
    private String productId;
    private String productNm;
    private String productCode;
    private String supplierInfo;
    private String productClass;
    private String packingType;
    private String recycleGrade;
    private String masterApplyNm;
    
    private String applyProductCode;
    
    private String inBaseYear;	
    private String baseYear;			        //기준 년 
    private Integer accumulateSaleQty;			//누적판매량
    private double packingTotalWeight;			//포장재총중량
    private String recyleContributions;         //재활용 분담금

    private String baseYear_1;		
    private Integer accumulateSaleQty_1;			
    private double packingTotalWeight_1;			
    private String recyleContributions_1;         

    private String baseYear_2;		
    private Integer accumulateSaleQty_2;		 
    private double packingTotalWeight_2;		
    private String recyleContributions_2;       
    
    
    private String productMaker;
    private String summary;
    private String check1;
    private String photo;
    private String spec;
    
    private String masterApply;      //진행상태
    private String receiptNumber;    //접수번호
    private String approvalNumber;   //승인번호
    
    private String masterMapping;      //매핑상태
    private String mappingProductCode;  //매핑상품코드
    private String mappingProductNm;    //매핑상품명
    
    
    private List<ProdPackagingModel> ProdPackagingList;  
    private List<CodeModel> environmentProceedStatCode; 
    private List<CodeModel> mappingStatCode;
    
    
}
