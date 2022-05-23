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
public class ProdMappingModel extends Criteria{
	
	private String masterApplyCode;
	private String masterApplyNm;
	private String masterMappingCode;
	private String masterMappingNM;	
	private String productCode;
	private String mappingProductCode;
	private String mappingProductNm;
	
	private String ApprovalNo;
	
	
    private String errorString;    

}
