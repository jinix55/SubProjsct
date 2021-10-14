package com.portal.adm.reset.model;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import com.portal.common.paging.Criteria;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 리셋관리 모델
 */
@Data
public class ResetModel extends Criteria{

    private String rownum;          					// 순번
    private String resetId;								// 리셋 ID
    private String companyNm;							// 회사이름
    private String userNm;								// 사용자 명
    private String userId;								// 사용자 ID
    private int resetCnt;							// 리셋 횟수
    private String useYn;								// 사용여부
    private String rgstId;								// 등록자 ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")	// spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    private LocalDateTime rgstDt;						// 등록일시
    private String modiId;								// 수정자 ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")	// spring eval taglib를 사용하여 annotation 패턴으로 출력 가능
    private LocalDateTime modiDt;						// 수정일시
    
}
