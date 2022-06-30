package com.portal.adm.member.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.adm.member.mapper.MemberMapper;
import com.portal.adm.member.model.MemberModel;
import com.portal.common.Constant;
import com.portal.common.paging.Criteria;

/**
 * 사용자관리 서비스 클래스
 */
@Service
public class MemberService {

	@Resource
	private MemberMapper memberMapper;

	/**
	 * 사용자관리 목록을 조회한다.
	 *
	 * @param criteria 페이징 모델
	 * @return
	 */
	public List<MemberModel> selectMemberList(Criteria criteria) {
		return memberMapper.selectMemberList(criteria);
	}

	/**
	 * 사용자 목록 카운트를 조회한다.
	 *
	 * @param criteria 페이징 모델
	 * @return
	 */
	public int selectMemberListCount(Criteria criteria) {
		return memberMapper.selectMemberListCount(criteria);
	}

 

	/**
	 * 사번을 이용하여 사용자를 조회한다.
	 *
	 * @param model memberId(사번)을 사용
	 * @return
	 */
	public MemberModel selectMember(MemberModel model) {
		return memberMapper.selectMember(model);
	}

	/**
	 * 사용자 정보를 등록한다.
	 *
	 * @param model 사번을 사용
	 * @return
	 */
	@Transactional
	public String insert(MemberModel model) {
 
		long count = memberMapper.insertUser(model);
 
		
		if (count > 0) {
			return Constant.DB.INSERT;
		} else {
			return Constant.DB.FAIL;
		}
	}

	/**
	 * 사용자 정보를 수정한다.
	 *
	 * @param model 사번을 사용
	 * @return
	 */
	@Transactional
	public String save(MemberModel model) {
 
		long count = memberMapper.update(model);
 
		if (count > 0) {
			return Constant.DB.UPDATE;
		} else {
			return Constant.DB.FAIL;
		}
	}
	
	/**
	 * 사용자 정보를 수정(삭제,미사용)한다.
	 *
	 * @param model 사번을 사용
	 * @return
	 */
	@Transactional
	public String delete(MemberModel model) {
		long count = memberMapper.delete(model);
 
		if (count > 0) {
			return Constant.DB.DELETE;
		} else {
			return Constant.DB.FAIL;
		}
	}

 

	@Transactional
	public long unlockAccount(MemberModel model) {
		return memberMapper.unlockAccount(model);
	}
	
	@Transactional
	public String updateMember(MemberModel model) {
		
		int cnt = memberMapper.selectMemberOne(model);
		if(cnt > 0) {
			long count = memberMapper.updateMember(model);
			if (count > 0) {
				return Constant.DB.UPDATE;
			} else {
				return Constant.DB.FAIL;
			}
		}else {
			return Constant.DB.FAIL;
		}
	}
}
