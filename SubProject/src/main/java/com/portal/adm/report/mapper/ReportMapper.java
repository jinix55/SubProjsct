package com.portal.adm.report.mapper;

import java.util.List;

import com.portal.adm.report.model.ReportModel;
import com.portal.common.annotation.ConnMapperFirst;

/**
 * Mybatis 코드관리 매핑 Interface
 */
@ConnMapperFirst
public interface ReportMapper {

    /**
     * 레포트 리스트를 가져온다
     *
     * @param reportModel
     * @return  레포트 리스트
     */
    List<ReportModel> selectReportList(ReportModel reportModel);
    
    /**
     * 레포트 카운트를 가져온다
     *
     * @param reportModel
     * @return  레포트 카운트
     */
   int selectReportListCount(ReportModel reportModel);
   
   /**
    * 레포트정보를 등록한다.
    *
    * @param reportModel
    * @return  레포트 등록
    */
   int insert(ReportModel reportModel);
   
   /**
    * 레포트정보를 업데이트한다.
    *
    * @param reportModel
    * @return  레포트 업데이트
    */
   long update(ReportModel reportModel);
   
   /**
    * 레포트정보를 조회한다.
    *
    * @param reportModel
    * @return  레포트 조회
    */
   ReportModel select(ReportModel reportModel);
   
   /**
    * 레포트정보를 삭제한다.
    *
    * @param reportModel
    * @return  레포트 삭제
    */
   long delete(ReportModel reportModel);
   
   /**
    * 레포트정보를 삭제한다.
    *
    * @param reportModel
    * @return  레포트 삭제
    */
   ReportModel select(String reportId);

}
