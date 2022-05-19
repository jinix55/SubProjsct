package com.portal.adm.product.model;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.portal.common.paging.Criteria;

import lombok.Data;

@Data
public class ProductPackagingMatFileModel extends Criteria {

	private String packagingMatFileId;	//포장재질 ID
	private String packagingId;			//포장 ID
	private String partCode;			//부위코드(몸체, 라벨)
	private String matFileCode;			//포장재질구조증명서/기기분석/육안판정
	private String revisionYear;		//개정 년
	private String revisionMonth;		//개정 월
	private String fileId;          	// 파일 ID
	private String useYn;           	// 사용여부
    private String rgstId;          	// 등록자ID
    private String modiId;          	// 수정자ID
    
    private String rownum;          	// 순번
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")  // spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime rgstDt; 		// 등록일시
    private String rgstDtStr;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")  // spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime modiDt; 		// 수정일시
}
