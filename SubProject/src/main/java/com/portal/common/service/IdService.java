package com.portal.common.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.common.CommonUtil;
import com.portal.common.Constant;
import com.portal.common.mapper.IdMapper;

/**
 * ID 생성 서비스 IdUtil 에서 호출
 */
@Service
public class IdService {

	@Resource(name = "idMapper")
	private IdMapper mapper;

	@Resource(name = "commonUtil")
	private CommonUtil util;

	/**
	 * ID 생성
	 */
	@Transactional
	public String getId(String idTy) {
		String result = Constant.EMPTY_STRING;
		Map<String, String> param = new HashMap<String, String>();
		param.put(Constant.ID.ID_TY, idTy);
		param.put(Constant.ID.ID_SE, util.getDateString(Constant.DATE_FORMAT.YEAR));
		mapper.insertId(param);
		result = mapper.selectId(param);
		return result;
	}

	/**
	 * 시간 순번 생성
	 */
	@Transactional
	public String getTimeSeq(String idTy) {
		String result = Constant.EMPTY_STRING;
		Map<String, String> param = new HashMap<String, String>();
		param.put(Constant.ID.ID_TY, idTy);
		param.put(Constant.ID.ID_SE, util.getDateString(Constant.DATE_FORMAT.YEAR));
		mapper.insertId(param);
		result = mapper.selectTimeSeq(param);
		return result;
	}
}
