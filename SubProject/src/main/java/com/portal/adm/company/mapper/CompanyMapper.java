package com.portal.adm.company.mapper;

import com.portal.adm.company.model.CompanyModel;
import com.portal.common.annotation.ConnMapperFirst;

import java.util.List;

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

}
