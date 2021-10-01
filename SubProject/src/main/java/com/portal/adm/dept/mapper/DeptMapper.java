package com.portal.adm.dept.mapper;

import java.util.List;

import com.portal.adm.dept.model.DeptClModel;
import com.portal.common.annotation.ConnMapperFirst;

@ConnMapperFirst
public interface DeptMapper {
	
	//부서 분류 조회
	DeptClModel selectDeptCl(String deptCode);
	List<DeptClModel> selectDeptClList();
	List<DeptClModel> selectDeptClSearchList(DeptClModel model);

}
