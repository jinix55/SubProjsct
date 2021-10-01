package com.portal.adm.dept.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.portal.adm.dept.mapper.DeptMapper;
import com.portal.adm.dept.model.DeptClModel;

@Service
public class DeptService {

	@Resource
	private DeptMapper deptMapper;
	
	public DeptClModel selectDeptCl(String deptCode) {
		return deptMapper.selectDeptCl(deptCode);
	}
	
	public List<DeptClModel> selectDeptClList() {
		return deptMapper.selectDeptClList();
	}

	public List<DeptClModel> selectDeptClSearchList(DeptClModel model) {
		return deptMapper.selectDeptClSearchList(model);
	}
	
}
