package com.portal.adm.environmentCode.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.adm.environmentCode.mapper.EnvironmentCodeMapper;
import com.portal.adm.environmentCode.model.EnvironmentCodeModel;
import com.portal.common.Constant;

/**
 * 환경부코드 서비스 클래스
 */
@Service
public class EnvironmentCodeService {

    @Resource
    private EnvironmentCodeMapper environmentCodeMapper;

    /**
     * 환경부코드 ID 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public List<EnvironmentCodeModel> selectGroupIdList(EnvironmentCodeModel model) {
    	return environmentCodeMapper.selectGroupIdList(model);
    }
    
    /**
     * 환경부코드 리스트 날짜를 조회한다.
     *
     * @param groupId
     * @return
     */
    public List<EnvironmentCodeModel> selectCodeDayList() {
        return environmentCodeMapper.selectCodeDayList();
    }

    public int selectGroupIdListCount(EnvironmentCodeModel model) {
        return environmentCodeMapper.selectGroupIdListCount(model);
    }


    /**
     * 환경부코드 ID 리스트를 조회한다.(페이징X)
     *
     * @param groupId
     * @return
     */
    public List<EnvironmentCodeModel> selectGroupIdAllList(String groupId) {
        return environmentCodeMapper.selectGroupIdAllList(groupId);
    }

    /**
     * 환경부코드 ID와 코드ID가 동일한 코드모델을 조회한다.
     *
     * @param model
     * @return
     */
    public List<EnvironmentCodeModel> selectList(EnvironmentCodeModel model) {
        return environmentCodeMapper.selectList(model);
    }
    
    /**
     * 환경부코드 ID와 코드ID가 동일한 코드모델을 조회한다.
     *
     * @param model
     * @return
     */
    public EnvironmentCodeModel select(EnvironmentCodeModel model) {
        return environmentCodeMapper.select(model);
    }

    /**
     * 환경부코드 ID와 코드ID가 동일한 코드모델을 삭제한다.
     *
     * @param model
     * @return
     */
    @Transactional
    public String delete(EnvironmentCodeModel model) {

        if(StringUtils.equals(model.getDelType(),"middle") || StringUtils.equals(model.getDelType(),"small")) {
        	environmentCodeMapper.deleteDownCode(model);
        }

        long count = environmentCodeMapper.delete(model);
        
        if(count > 0) {
            return Constant.DB.DELETE;
        } else {
            return Constant.DB.FAIL;
        }
    }

    /**
     * 환경부코드 저장한다. 환경부코드ID와 코드ID가 동일한 코드모델이 존재하면 업데이트 아니면 신규등록한다.
     *
     * @param model
     * @return
     */
    @Transactional
    public String save(EnvironmentCodeModel model) {
        EnvironmentCodeModel existModel = select(model);

        if(existModel != null) {
            long count = environmentCodeMapper.update(model);

            if(count > 0) {
                return Constant.DB.UPDATE;
            } else {
                return Constant.DB.FAIL;
            }
        } else {
            long count = environmentCodeMapper.insert(model);

            if(count > 0) {
                return Constant.DB.INSERT;
            } else {
                return Constant.DB.FAIL;
            }
        }
    }

    public int selectCodeCountForGroupId(EnvironmentCodeModel model) {
        return environmentCodeMapper.selectCodeCountForGroupId(model);
    }
}
