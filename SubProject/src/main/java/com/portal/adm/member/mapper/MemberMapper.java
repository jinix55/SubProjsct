package com.portal.adm.member.mapper;

import com.portal.adm.member.model.MemberModel;
import com.portal.common.annotation.ConnMapperFirst;
import com.portal.common.paging.Criteria;

import java.util.List;

/**
 * Mybatis 사용자관리 매핑 Interface
 */
@ConnMapperFirst
public interface MemberMapper {

    /**
     * 사용자관리 목록을 조회한다.
     *
     * @param criteria 페이징 모델
     * @return
     */
    List<MemberModel> selectMemberList(Criteria criteria);

    /**
     * 사용자관리 목록 카운트를 조회한다.
     *
     * @param criteria
     * @return
     */
    int selectMemberListCount(Criteria criteria);

 
    
    /**
     * 사용자모델을 조회한다.
     *
     * @param memberModel 사번을 사용
     * @return
     */
    MemberModel selectMember(MemberModel memberModel);


 
    
    /**
     * 사용자 모델을 업데이트 한다.
     * @param model 사번을 사용
     * @return
     */
    long update(MemberModel model);
    
    /**
     * 사용자 모델을 미사용으로 업데이트 한다.
     * @param model 사번을 사용
     * @return
     */
    long delete(MemberModel model);
    
 
    
    /**
     * 사용자 모델 신규 등록 insert
     * @param model 사번을 사용
     * @return
     */
    long insertUser(MemberModel model);
    
 

    
    long unlockAccount(MemberModel memberModel);
    
    int selectMemberOne(MemberModel memberModel);
    
    long updateMember(MemberModel memberModel);
}
