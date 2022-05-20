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
public class ProdPartModel extends Criteria{
	
	private String inGroupId;
	private String envCodeId;
	private String envCodeNm;
	private String codeId;
	private String codeNm;
    
    private String str;  

}
