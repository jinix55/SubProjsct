package com.portal.adm.member.model;

import java.io.Serializable;
import java.time.LocalDateTime;

import org.json.JSONObject;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

/**
 * 사용자 모델
 */
@Data
public class MemberModel implements Serializable {

    private String rownum;          // 순번
    private String companyCode;       // 회사코드
    private String userId;        // 사번
    private String userNm;        // 사용자명
    private String pstnNm;           // 직위명
    private String deptNm;           // 부서코드
    private String email;           // 부서코드
    private String phone;           // 부서코드
    private String companyNm;       // 회사명
    private String authCode;          // 권한ID
    private String authNm;          // 권한명
    private String useYn;           // 사용여부
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime lastLogDt;  // 마지막로그일시
//    private String lastLogYn;           // 마지막로그일시 3개월 유무 체크 -> lockYn로 변경
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDateTime startDt;    // 시작일시
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDateTime endDt;      // 종료일시
    private String rgstId;              // 등록자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime rgstDt;     // 등록일시
    private String modiId;              // 수정자ID
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime modiDt;     // 수정일시
    private String lockYn;// 계정 잠금 :  - 최종 로그인 180일 경과
    private String mgrYn;// 관리자 여부
    private String fileId; // 사진 파일 ID
    private String fileUrl; // 사진 파일 URL
    private String clientIp; // 사용자 접속 IP
    private String mgrSysEnv; // 관리자 시스템 환경
    private String userSysEnv; // 사용자 시스템 환경
    private String bfDeptCode;// 이전 부서 코드
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime deptUpdtDt;// 부서 변경 일시
    private String userSysHome;
    private String mgrAuthId;
    private String mgrAuthNm;
    private String userAuthChage;
    private String mgrAuthChange;
    private String dtLimitYn;
    private String password;
    private String newPassword;
    private int passError;
    private String PassInit;

}
