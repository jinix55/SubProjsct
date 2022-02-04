package com.portal.api.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.portal.api.mapper.ApiExtrnlMapper;
import com.portal.api.model.ApiExtrnlModel;

@Service
public class ApiExtrnlService {

	@Resource
    private ApiExtrnlMapper apiExtrnlMapper;
	
	/**
	 * 포장 api 모델을 조회한다.
	 *
	 * @param model 포장 api key를 사용
	 * @return
	 */
	public ApiExtrnlModel select(ApiExtrnlModel model) {
		apiExtrnlMapper.updateDate();
		return apiExtrnlMapper.select(model);
	}
	
	/**
	 * 포장 api 모델을 저장한다.
	 *
	 * @param model 포장 api 모델을 사용
	 * @return
	 */
	public long insert(ApiExtrnlModel model) {
		return apiExtrnlMapper.insert(model);
	}
	
	/**
     * 포장 api 모델을 저장한다.
     *
     * @param
     * @return
     */
    public long updateDate() {
        return apiExtrnlMapper.updateDate();
    }
}
