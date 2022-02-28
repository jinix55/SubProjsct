package com.portal.adm.environPrice.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.adm.environPrice.mapper.EnvironPriceMapper;
import com.portal.adm.environPrice.model.EnvironPriceModel;
import com.portal.common.Constant;

/**
 * 코드 서비스 클래스
 */
@Service
public class EnvironPriceService {

    @Resource
    private EnvironPriceMapper mapper;

    /**
     * 그룹 ID 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public List<EnvironPriceModel> selectGroupIdList(EnvironPriceModel model) {
        return mapper.selectGroupIdList(model);
    }

    public int selectGroupIdListCount(EnvironPriceModel model) {
        return mapper.selectGroupIdListCount(model);
    }


    /**
     * 그룹 ID 리스트를 조회한다.(페이징X)
     *
     * @param groupId
     * @return
     */
    public List<EnvironPriceModel> selectGroupIdAllList(String groupId) {
        return mapper.selectGroupIdAllList(groupId);
    }

    /**
     * 그룹ID와 코드ID가 동일한 코드모델을 조회한다.
     *
     * @param model
     * @return
     */
    public EnvironPriceModel select(EnvironPriceModel model) {
        return mapper.select(model);
    }

    /**
     * 그룹ID와 코드ID가 동일한 코드모델을 삭제한다.
     *
     * @param model
     * @return
     */
    @Transactional
    public String delete(EnvironPriceModel model) {

        if(model.getGroupId().equals("GROUP_ID")) {
            int codeCount = selectCodeCountForGroupId(model);

            if(codeCount > 0) {
                return Constant.DB.USE_CODE_ID;
            }
        }

        long count = mapper.delete(model);

        if(count > 0) {
            return Constant.DB.DELETE;
        } else {
            return Constant.DB.FAIL;
        }
    }

    /**
     * 코드모델을 저장한다. 그룹ID와 코드ID가 동일한 코드모델이 존재하면 업데이트 아니면 신규등록한다.
     *
     * @param model
     * @return
     */
    @Transactional
    public String save(EnvironPriceModel model) {
        EnvironPriceModel existModel = select(model);

        if(existModel != null) {
            long count = mapper.update(model);

            if(count > 0) {
                return Constant.DB.UPDATE;
            } else {
                return Constant.DB.FAIL;
            }
        } else {
            long count = mapper.insert(model);

            if(count > 0) {
                return Constant.DB.INSERT;
            } else {
                return Constant.DB.FAIL;
            }
        }
    }

    public int selectCodeCountForGroupId(EnvironPriceModel model) {
        return mapper.selectCodeCountForGroupId(model);
    }
}
