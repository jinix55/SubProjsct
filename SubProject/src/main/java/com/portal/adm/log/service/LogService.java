package com.portal.adm.log.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.portal.adm.log.mapper.LogMapper;
import com.portal.adm.log.model.LogModel;
import com.portal.common.paging.Criteria;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LogService {
	
    @Resource
    private LogMapper logMapper;

  	//로그인 목록 추출
  	public List<LogModel> selectMgrLoginList(LogModel logModel) {
  		return logMapper.selectMgrLoginList(logModel);
  	}

  	//로그인 로그 카운트
  	public int selectMgrLoginCount(LogModel logModel) {
  		return logMapper.selectMgrLoginCount(logModel);
  	}
  	
  	//접근 로그 목록 추출
  	public List<LogModel> selectJobLogList(LogModel logModel) {
  		return logMapper.selectJobLogList(logModel);
  	}
  	
  	//접근 로그 카운트
  	public int selectJobLogCount(LogModel logModel) {
  		return logMapper.selectJobLogCount(logModel);
  	}

  	//접근 생성 (t_log_rqst_mgr_sys)
  	public long insert(LogModel model) {
  		if(model != null) {
  			return logMapper.insert(model);
  		} else {
  			return 0L;
  		}
  	}
  	
  	//로그인 로그 생성 (t_log_rqst_mgr_sys)
  	public long insertLogin(LogModel model) {
  		if(model != null) {
  			return logMapper.insertLogin(model);
  		} else {
  			return 0L;
  		}
  	}
}
