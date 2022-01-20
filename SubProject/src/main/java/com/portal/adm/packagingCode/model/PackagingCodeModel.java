package com.portal.adm.packagingCode.model;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.portal.common.paging.Criteria;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 환경부코드관리 모델
 */
@Data
public class PackagingCodeModel extends Criteria{

    private String rownum;          // 순번
    private String groupId;         // 코드그룹ID
    private String upCompanyCode;   // 소속 회사코드
    private String revision;		// 개정 년
    private String revisionYear;	// 개정 년
    private String revisionMonth;	// 개정 월
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
    private String largeCategory;	//대분류
    private String middleCategory;	//대분류
    private String smallCategory;	//대분류
    private String detailCategory;	//대분류
    private String codeType;		//대분류
    
    private String larGroupId;		//대분류 화면 코드
    private String larCodeId;		//대분류 화면 코드
    private String larCodeNm;		//대분류 화면 코드
    private String larCodeKey;		//대분류 화면 코드
    private String larCodeDsc;		//대분류 화면 코드
    private String larRevision;		// 개정 년
    private Integer larOrdSeq;		//정렬순서
    private String larCodeType;		//대분류
    
    private String midGroupId;		//중분류 화면 코드
    private String midCodeId;		//중분류 화면 코드
    private String midCodeNm;		//중분류 화면 코드
    private String midCodeKey;		//중분류 화면 코드
    private String midCodeDsc;		//중분류 화면 코드
    private String midRevision;		// 개정 년
    private Integer midOrdSeq;			//정렬순서
    private String midCodeType;		//대분류
    
    private String smlGroupId;		//소분류 화면 코드
    private String smlCodeId;		//소분류 화면 코드
    private String smlCodeNm;		//소분류 화면 코드
    private String smlCodeKey;		//소분류 화면 코드
    private String smlCodeDsc;		//소분류 화면 코드
    private String smlRevision;		// 개정 년
    private Integer smlOrdSeq;			//정렬순서
    private String smlCodeType;		//대분류
    
    private String delGroupId;		//대분류
    private String delCodeId;		//대분류
    
}

