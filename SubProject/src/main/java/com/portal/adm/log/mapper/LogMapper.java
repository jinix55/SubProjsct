package com.portal.adm.log.mapper;

import java.util.List;

import com.portal.adm.log.model.LogModel;
import com.portal.common.annotation.ConnMapperFirst;
import com.portal.common.paging.Criteria;

/**
 * Mybatis 로그관리 매핑 Interface
 */
@ConnMapperFirst
public interface LogMapper {

	//로그인 로그 목록 추출
	List<LogModel> selectMgrLoginList(Criteria criteria);

	//로그인 로그 카운트
	int selectMgrLoginCount(Criteria criteria);
	
	// 접근로그 목록 추출
	List<LogModel> selectJobLogList(Criteria criteria);
	
	// 접근로그 카운트
	int selectJobLogCount(Criteria criteria);
	
	/**
	 * 로그 모델을 신규생성한다.
	 *
	 * @param model 로그모델
	 * @return
	 */
	long insert(LogModel model);
	
	/**
	 * 로그 모델을 신규생성한다.
	 *
	 * @param model 로그모델
	 * @return
	 */
	long insertLogin(LogModel model);

}