package com.portal.adm.environPrice.model;

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
public class EnvironPriceModel extends Criteria{

    private String rownum;          // 순번
    private String groupId;         // 코드그룹ID
    private String codeId;          // 코드ID
    private String codeNm;          // 코드이름
    private String codeDsc;        // 코드설명
    private String useYn;           // 사용여부
    private String rgstId;          // 등록자ID
    private String codeKey;
    private String unit;
    private String recyclDutyRate;
    private String unitPrice;
    private String premium;
    private String discount;
    private String other1;
    private String other2;
    private String other3;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")  // spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime rgstDt; // 등록일시
    private String rgstDtStr;
    private String modiId;          // 수정자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")  // spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime modiDt; // 수정일시
    private Integer ordSeq;			//정렬순서
    
   
}
