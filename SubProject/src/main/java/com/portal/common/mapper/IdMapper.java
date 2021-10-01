package com.portal.common.mapper;

import java.util.Map;

import com.portal.common.annotation.ConnMapperFirst;

@ConnMapperFirst
public interface IdMapper {

	String selectId(Map<String,String> param);
	String selectTimeSeq(Map<String,String> param);
	int insertId(Map<String,String> param);
}
