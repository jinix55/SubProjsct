package com.portal.adm.report.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.portal.adm.report.mapper.ReportMapper;
import com.portal.adm.report.model.ReportModel;
import com.portal.adm.role.service.RoleService;
import com.portal.common.Constant;

import lombok.extern.slf4j.Slf4j;

/**
 * 회사 서비스 클래스
 */
@Slf4j
@Service
public class ReportService {

    @Resource
    private ReportMapper reportMapper;

    /**
     * 회사 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public List<ReportModel> selectReportList(ReportModel reportModel) {
        return reportMapper.selectReportList(reportModel);
    }
    
    /**
     * 회사 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public int selectReportListCount(ReportModel reportModel) {
    	return reportMapper.selectReportListCount(reportModel);
    }
    
    /**
     * 회사정보를 저장한다.
     *
     * @param reportCode
     * @return
     */
    public String save(ReportModel reportModel) {
    	ReportModel existModel = reportMapper.select(reportModel);

        if(existModel != null) {
            long count = reportMapper.update(reportModel);

            if(count > 0) {
                return Constant.DB.UPDATE;
            } else {
                return Constant.DB.FAIL;
            }
        } else {
            long count = reportMapper.insert(reportModel);

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
     * @param reportCode
     * @return
     */
    public String delete(ReportModel reportModel) {
        long count = reportMapper.delete(reportModel);

        if(count > 0) {
            return Constant.DB.DELETE;
        } else {
            return Constant.DB.FAIL;
        }
    }
    
    /**
     * 회사정보를 삭제한다.
     *
     * @param reportCode
     * @return
     */
    public ReportModel selectReportId(ReportModel reportModel) {
    	return reportMapper.select(reportModel);
    }

}
