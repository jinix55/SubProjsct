package com.portal.adm.log.model;

import java.time.LocalDateTime;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.portal.common.paging.Criteria;

import lombok.Data;

@Data
public class LogModel extends Criteria {

    private int rownum;             // 화면 순번
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime logDt;    // 로그일시
    private String userId;          // 사번
    private String userNm;          // 성명
    private String pstnCode;        // 직책코드
    private String pstnNm;          // 직책명
    private String deptCode;        // 부서코드
    private String deptNm;          // 부서명
    private String authId;          // 권한코드
    private String authNm;          // 권한명
    private String serverIp;        // 서버 IP
    private String clientIp;        // 접속IP
    private String rqstMethod;      // HTTP Method
    private String rqstUrl;         // 요청 URL
    private String rqstUri;         // 요청 URL
    private String programNm;       // 프로그램 명
    private String controllerNm;    // 컨트롤러명
    private String methodNm;        // 메소드명
    private String msg;             // 파라미터
    private String searhType;             // 파라미터
    private String searhValue;             // 파라미터

}
