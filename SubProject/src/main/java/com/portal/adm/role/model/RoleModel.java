package com.portal.adm.role.model;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.portal.common.paging.Criteria;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 권한 데이터 모델
 */
@Data
public class RoleModel extends Criteria{

    private String rownum;              // 순번
    private String authId;              // 권한ID
    private String companyCode;         // 권한회사코드
    private String authCl;              // 권한분류
    private String authNm;              // 권한명
    private String authDsc;            // 권한설명
    private String useYn;               // 사용여부
    private String rgstId;              // 등록자 ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime rgstDt;     // 등록일시
    private String modiId;              // 수정자 ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime modiDt;     // 수정일시
    
    private String userId;
    private String refId;
    private String refTy;
}
