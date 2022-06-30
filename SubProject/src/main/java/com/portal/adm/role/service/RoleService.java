package com.portal.adm.role.service;


import javax.annotation.Resource;
import java.util.List;

import com.portal.adm.member.service.MemberService;
import com.portal.adm.role.mapper.RoleMapper;
import com.portal.adm.role.model.RoleGroupModel;
import com.portal.adm.role.model.RoleModel;
import com.portal.common.Constant;
import com.portal.common.paging.Criteria;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * 권한 서비스 클래스
 */
@Slf4j
@Service
public class RoleService {

    @Resource
    private MemberService memberService;

    @Resource
    private RoleMapper roleMapper;

    /**
     * 권한모델 목록을 조회한다.
     *
     * @param criteria  페이징 모델
     * @return
     */
    public List<RoleModel> selectList(Criteria criteria) {
        return roleMapper.selectList(criteria);
    }

    /**
     * 권한모델 목록 카운트를 조회한다.
     *
     * @param criteria  페이징 모델
     * @return
     */
    public int selectListCount(Criteria criteria) {
        return roleMapper.selectListCount(criteria);
    }

    /**
     * 모든 권한 목록을 조회한다.
     *
     * @return
     */
    public List<RoleModel> selectAllList(Criteria criteria) {
        return roleMapper.selectAllList(criteria);
    }
    
    /**
     * 모든 권한 목록을 조회한다.
     *
     * @return
     */
    public List<RoleModel> selectAllList() {
    	return roleMapper.selectAllList();
    }

    /**
     * 권한ID에 따른 권한모델을 조회한다.
     *
     * @param model 권한ID
     * @return
     */
    public RoleModel select(RoleModel model) {
        return roleMapper.select(model);
    }

    /**
     * 권한ID에 따른 권한모델을 삭제한다.
     *
     * @param model 권한ID
     * @return
     */
    @Transactional
    public String delete(RoleModel model) {

        int memberCount = 0; //memberService.selectMemberListCountForRoleId(model.getAuthId()); 확인필요@@@@@@@@@@@@@@@@@

        if(memberCount > 0) {
            return Constant.DB.USE_ROLE_ID;
        } else {
            long count = roleMapper.delete(model);

            if(count > 0) {
                return Constant.DB.DELETE;
            } else {
                return Constant.DB.FAIL;
            }
        }

    }

    /**
     * 권한모델을 저장한다.
     * 권한ID에 따른 권한모델이 존재하면 업데이트 아니면 신규생성한다.
     *
     * @param model
     * @return
     */
    @Transactional
    public String save(RoleModel model) {
        RoleModel existModel = select(model);

        if(existModel != null) {
            try {
                long count = roleMapper.update(model);

                if (count > 0) {
                    return Constant.DB.UPDATE;
                } else {
                    return Constant.DB.FAIL;
                }
            } catch (Exception e) {
                log.error(e.getMessage());
                return Constant.DB.FAIL;
            }
        } else {
            try {
                long count = roleMapper.insert(model);

                if (count > 0) {
                    return Constant.DB.INSERT;
                } else {
                    return Constant.DB.FAIL;
                }
            } catch (Exception e) {
                log.error(e.getMessage());
                return Constant.DB.FAIL;
            }
        }
    }
    
    /**
     * 관리자 권한모델 목록을 조회한다.
     *
     * @param criteria  페이징 모델
     * @return
     */
    public List<RoleModel> selectMgrSysAuthList(Criteria criteria) {
        return roleMapper.selectMgrSysAuthList(criteria);
    }

    /**
     * 관리자 권한모델 목록 카운트를 조회한다.
     *
     * @param criteria  페이징 모델
     * @return
     */
    public int selectMgrSysAuthListCount(Criteria criteria) {
        return roleMapper.selectMgrSysAuthListCount(criteria);
    }

    /**
     * 관리자 모든 권한 목록을 조회한다.
     *
     * @return
     */
    public List<RoleModel> selectMgrSysAuthAllList(RoleModel model) {
        return roleMapper.selectMgrSysAuthAllList(model);
    }

    /**
     * 관리자 권한ID에 따른 권한모델을 조회한다.
     *
     * @param model 권한ID
     * @return
     */
    public RoleModel selectMgrSysAuth(RoleModel model) {
        return roleMapper.selectMgrSysAuth(model);
    }

    /**
     * 관리자 권한ID에 따른 권한모델을 삭제한다.
     *
     * @param model 권한ID
     * @return
     */
    @Transactional
    public String deleteMgrSysAuth(RoleModel model) {

        int memberCount = 0; // = memberService.selectMemberListCountForMgrRoleId(model.getAuthId()); 확인필요 @@@@@@@@@@@@@@@@@@@@@@@@@@@@

        if(memberCount > 0) {
            return Constant.DB.USE_ROLE_ID;
        } else {
            long count = roleMapper.deleteMgrSysAuth(model);

            if(count > 0) {
                return Constant.DB.DELETE;
            } else {
                return Constant.DB.FAIL;
            }
        }

    }
    
    /**
     * 관리자 권한모델을 저장한다.
     * 권한ID에 따른 권한모델이 존재하면 업데이트 아니면 신규생성한다.
     *
     * @param model
     * @return
     */
    @Transactional
    public String mgrSave(RoleModel model) {
        RoleModel existModel = selectMgrSysAuth(model);

        if(existModel != null) {
            try {
                long count = roleMapper.updateMgrSysAuth(model);

                if (count > 0) {
                    return Constant.DB.UPDATE;
                } else {
                    return Constant.DB.FAIL;
                }
            } catch (Exception e) {
                log.error(e.getMessage());
                return Constant.DB.FAIL;
            }
        } else {
            try {
                long count = roleMapper.insertMgrSysAuth(model);

                if (count > 0) {
                    return Constant.DB.INSERT;
                } else {
                    return Constant.DB.FAIL;
                }
            } catch (Exception e) {
                log.error(e.getMessage());
                return Constant.DB.FAIL;
            }
        }
    }
    
}
