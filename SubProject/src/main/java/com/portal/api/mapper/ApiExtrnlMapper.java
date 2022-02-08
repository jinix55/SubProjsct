package com.portal.api.mapper;

import com.portal.api.model.ApiExtrnlModel;
import com.portal.common.annotation.ConnMapperFirst;

/**
 * Mybatis 포장 api 매핑 Interface
 */
@ConnMapperFirst
public interface ApiExtrnlMapper {

	/**
	 * 포장 api key 따른 데이터를 조회한다.
	 *
	 * @param model 외부시스템ID를 사용
	 * @return
	 */
	ApiExtrnlModel select(ApiExtrnlModel model);
	
	/**
	 * 포장 api 따른 데이터를 저장한다.
	 *
	 * @param model 외부시스템ID를 사용
	 * @return
	 */
	long insert(ApiExtrnlModel model);
	
    /**
     * 포장 api 유효데이터를 정리한다.
     *
     * @param model 외부시스템ID를 사용
     * @return
     */
    long updateDate();

}