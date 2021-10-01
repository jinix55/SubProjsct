package com.portal.adm.company.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.portal.adm.company.mapper.CompanyMapper;
import com.portal.adm.company.model.CompanyModel;

/**
 * 회사 서비스 클래스
 */
@Service
public class CompanyService {

    @Resource
    private CompanyMapper companyMapper;

    /**
     * 회사 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public List<CompanyModel> selectCompanyList(CompanyModel companyModel) {
        return companyMapper.selectCompanyList(companyModel);
    }
    
    /**
     * 회사 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public int selectCompanyListCount(CompanyModel companyModel) {
    	return companyMapper.selectCompanyListCount(companyModel);
    }

}
