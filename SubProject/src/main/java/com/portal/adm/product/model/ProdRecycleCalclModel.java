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
public class ProdRecycleCalclModel extends Criteria{
	
	private String productCode;
	private String packagingOrderNm;
	private double weight;
	
	private String groupNm;
	private String codeNm;

    private String recyclDutyRate;
    private int    unitPrice;
    private int    premium;
    private int    discount;
	
    private String str;    
	
 

}
