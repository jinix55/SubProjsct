package com.portal.adm.product.model;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.portal.common.paging.Criteria;

import lombok.Data;

@Data
public class ProductGroupFileModel extends Criteria {

	private String gfileId;         // GROUP 파일 ID
	private String fileId;          // 파일 ID
	private String delYn;           // 삭제여부
	private String useYn;           // 사용여부
    private String rgstId;          // 등록자ID
    private String modiId;          // 수정자ID
    
    private String rownum;          // 순번
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")  // spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime rgstDt; // 등록일시
    private String rgstDtStr;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")  // spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime modiDt; // 수정일시
}
