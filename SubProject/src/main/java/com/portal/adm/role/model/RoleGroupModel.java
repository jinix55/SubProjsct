package com.portal.adm.role.model;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 권한 데이터 모델
 */
@Data
public class RoleGroupModel {

    private String rownum;              // 순번
    private String groupId;              // 그룹ID
    private String groupNm;              // 그룹명
    private String groupDsc;            // 그룹설명
    private String useYn;               // 사용여부
    private String rgstId;              // 등록자 ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime rgstDt;     // 등록일시
    private String modiId;              // 수정자 ID
    private LocalDateTime modiDt;     // 수정일시
    
    private String refId;
    private String refTy;
}
