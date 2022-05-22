package com.portal.adm.product.model;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.portal.common.paging.Criteria;

import lombok.Data;

/**
 * 코드관리 모델
 */
@Data
public class ProdPackagingSelfAndFileModel extends Criteria{
	private List <ProdPackagingSelfModel>  prodPackagingSelfList;
	private List <ProdPackagingSelfFileModel>  prodPackagingSelfFileList;
    	
    private String str;    

}