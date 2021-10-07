package com.portal.adm.company.mapper;

import java.util.List;

import com.portal.adm.company.model.CompanyModel;
import com.portal.common.annotation.ConnMapperFirst;

/**
 * Mybatis 코드관리 매핑 Interface
 */
@ConnMapperFirst
public interface CompanyMapper {

    /**
     * 회사 리스트를 가져온다
     *
     * @param companyModel
     * @return  회사 리스트
     */
    List<CompanyModel> selectCompanyList(CompanyModel companyModel);
    
    /**
     * 회사 카운트를 가져온다
     *
     * @param companyModel
     * @return  회사 카운트
     */
   int selectCompanyListCount(CompanyModel companyModel);
   
   /**
    * 회사정보를 등록한다.
    *
    * @param companyModel
    * @return  회사 등록
    */
   int insert(CompanyModel companyModel);
   
   /**
    * 회사정보를 업데이트한다.
    *
    * @param companyModel
    * @return  회사 업데이트
    */
   long update(CompanyModel companyModel);
   
   /**
    * 회사정보를 조회한다.
    *
    * @param companyModel
    * @return  회사 조회
    */
   CompanyModel select(CompanyModel companyModel);
   
   /**
    * 회사정보를 삭제한다.
    *
    * @param companyModel
    * @return  회사 삭제
    */
   long delete(CompanyModel companyModel);
   
   /**
    * 회사정보를 삭제한다.
    *
    * @param companyModel
    * @return  회사 삭제
    */
   CompanyModel select(String companyId);

}
