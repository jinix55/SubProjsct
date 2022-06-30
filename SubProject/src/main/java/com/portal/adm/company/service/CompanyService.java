package com.portal.adm.company.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.portal.adm.company.mapper.CompanyMapper;
import com.portal.adm.company.model.CompanyModel;
import com.portal.common.Constant;

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
    
    public List<CompanyModel> selectListAll() {
    	return companyMapper.selectListAll();
    }
    
    /**
     * 회사정보를 저장한다.
     *
     * @param companyCode
     * @return
     */
    public String save(CompanyModel companyModel) {
    	CompanyModel existModel = companyMapper.select(companyModel);

        if(existModel != null) {
            long count = companyMapper.update(companyModel);

            if(count > 0) {
                return Constant.DB.UPDATE;
            } else {
                return Constant.DB.FAIL;
            }
        } else {
            long count = companyMapper.insert(companyModel);

            if(count > 0) {
                return Constant.DB.INSERT;
            } else {
                return Constant.DB.FAIL;
            }
        }
    }
    
    /**
     * 회사정보를 삭제한다.
     *
     * @param companyCode
     * @return
     */
    public String delete(CompanyModel companyModel) {
        long count = companyMapper.delete(companyModel);

        if(count > 0) {
            return Constant.DB.DELETE;
        } else {
            return Constant.DB.FAIL;
        }
    }
 
    /**
     * 회사정보를 삭제한다.
     *
     * @param companyCode
     * @return
     */
    public CompanyModel selectCompanyCode(String companyCode) {
    	return companyMapper.select(companyCode);
    }
    
 
}
