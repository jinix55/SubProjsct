package com.portal.adm.reset.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.portal.adm.reset.mapper.ResetMapper;
import com.portal.adm.reset.model.ResetModel;
import com.portal.common.Constant;

/**
 * 회사 서비스 클래스
 */
@Service
public class ResetService {

    @Resource
    private ResetMapper resetMapper;

    /**
     * 회사 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public List<ResetModel> selectResetList(ResetModel resetModel) {
        return resetMapper.selectResetList(resetModel);
    }
    
    /**
     * 회사 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public int selectResetListCount(ResetModel resetModel) {
    	return resetMapper.selectResetListCount(resetModel);
    }
    
    /**
     * 회사정보를 저장한다.
     *
     * @param resetCode
     * @return
     */
    public String save(ResetModel resetModel) {
    	ResetModel existModel = resetMapper.select(resetModel);

        if(existModel != null) {
            long count = resetMapper.update(resetModel);

            if(count > 0) {
                return Constant.DB.UPDATE;
            } else {
                return Constant.DB.FAIL;
            }
        } else {
            long count = resetMapper.insert(resetModel);

            if(count > 0) {
                return Constant.DB.INSERT;
            } else {
                return Constant.DB.FAIL;
            }
        }
    }
    
    /**
     * 회사정보를 삭제한다.
     *
     * @param resetCode
     * @return
     */
    public String delete(ResetModel resetModel) {
        long count = resetMapper.delete(resetModel);

        if(count > 0) {
            return Constant.DB.DELETE;
        } else {
            return Constant.DB.FAIL;
        }
    }
    
    /**
     * 회사정보를 삭제한다.
     *
     * @param resetCode
     * @return
     */
    public ResetModel selectResetId(String resetId) {
    	return resetMapper.select(resetId);
    }

}
