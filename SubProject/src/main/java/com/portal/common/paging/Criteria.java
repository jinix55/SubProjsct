package com.portal.common.paging;

import java.io.Serializable;

import lombok.Data;

/**
 * 페이징 처리 모델
 * 페이징 셋팅은 role.jsp파일 참고
 */
@Data
public class Criteria implements Serializable {

    private int page;               // 현재페이지 번호
    private int pageSize;           // 페이지 사이즈
    private int totalPage;          // 전체페이지수
    private int totalCount;         // 전체데이터카운트
    private int offSet;				// 페이지 오프셋
    private String searchKey;       // 검색키
    private String searchValue;     // 검색값
    private String groupId;         // 코드그룹 검색조건
    private String searchUseYn;           // 사용여부
    private String searchCompanyCode;       // 회사구분
    private String searchRoleCode;       // 권한구분
    private String searchQnaStat;       // Q&A 답변 상태
    private String sortType;                // 정렬조건 (사번, 최근로그인일시, 사용기간)
    private String sortDirection;           // 정렬방향 (오름차순, 내림차순)
    private String startDt;        // 조회 시작
    private String endDt;          // 조회 종료
    private String useYn;		   // 서비스 ON/OFF	
    private String authNm;
    private String filterLockYn;
    private String holiType;       //휴일타입
    private String holiNm;       //휴일타입
    
    

    public Criteria() {
        this.page = 1;
        this.offSet = 0;
        this.pageSize = 10;
        this.searchKey = "ALL";
        this.searchValue = "";
    }

    public int getPage() {
        return page;
    }
    public void setPage(int page) {
        if(page <= 0) {
            this.page = 1;
            this.offSet = 0;
        } else {
            this.page = page;
            this.offSet = (page - 1) * 10;
        }
    }
    
    public int getPageSize() {
        return pageSize;
    }
    
    public void setPageSize(int pageSize) {
    	this.pageSize = pageSize;
    }
    
    /**
     * 전체 데이터 카운트를 가지고 전체페이지 수를 계산한다. 페이징 공통함수 사용을 위한 처리
     *
     * @param totalCount
     */
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		int tempPage = totalCount / pageSize;
		System.out.println("totalCount : "+totalCount);
		System.out.println("pageSize : "+pageSize);
		System.out.println("tempPage1 : "+tempPage);
		if (totalCount % pageSize != 0 && totalCount > tempPage*pageSize) tempPage++;
		System.out.println("tempPage2 : "+tempPage);
		this.totalPage = tempPage;
    }

    public int getTotalCount() {
        return this.totalCount;
    }
}
