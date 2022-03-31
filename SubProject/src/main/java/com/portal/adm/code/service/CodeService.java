package com.portal.adm.code.service;

import com.portal.adm.code.mapper.CodeMapper;
import com.portal.adm.code.model.CodeModel;
import com.portal.common.Constant;
import com.portal.common.paging.Criteria;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.List;

/**
 * 코드 서비스 클래스
 */
@Service
public class CodeService {

    @Resource
    private CodeMapper codeMapper;

    /**
     * 그룹 ID 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public List<CodeModel> selectGroupIdList(CodeModel codeModel) {
        return codeMapper.selectGroupIdList(codeModel);
    }

    public int selectGroupIdListCount(CodeModel codeModel) {
        return codeMapper.selectGroupIdListCount(codeModel);
    }


    /**
     * 그룹 ID 리스트를 조회한다.(페이징X)
     *
     * @param groupId
     * @return
     */
    public List<CodeModel> selectGroupIdAllList(String groupId) {
        return codeMapper.selectGroupIdAllList(groupId);
    }

    /**
     * 그룹ID와 코드ID가 동일한 코드모델을 조회한다.
     *
     * @param model
     * @return
     */
    public CodeModel select(CodeModel model) {
        return codeMapper.select(model);
    }

    /**
     * 그룹ID와 코드ID가 동일한 코드모델을 삭제한다.
     *
     * @param model
     * @return
     */
    @Transactional
    public String delete(CodeModel model) {

        if(model.getGroupId().equals("GROUP_ID")) {
            int codeCount = selectCodeCountForGroupId(model);

            if(codeCount > 0) {
                return Constant.DB.USE_CODE_ID;
            }
        }

        long count = codeMapper.delete(model);

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
    public String save(CodeModel model) {
        CodeModel existModel = select(model);

        if(existModel != null) {
            long count = codeMapper.update(model);

            if(count > 0) {
                return Constant.DB.UPDATE;
            } else {
                return Constant.DB.FAIL;
            }
        } else {
            long count = codeMapper.insert(model);

            if(count > 0) {
                return Constant.DB.INSERT;
            } else {
                return Constant.DB.FAIL;
            }
        }
    }

    public int selectCodeCountForGroupId(CodeModel model) {
        return codeMapper.selectCodeCountForGroupId(model);
    }

    
    public String getCodeNm(String CodeType, String CodeId) {
    	String CodeNm = "";
    	if("MAT_TYPE".equals(CodeType)){
    		  CodeNm = codeMapper.getCodeNmOnEnvironPrice(CodeId);
    	} else if("PART_TYPE".equals(CodeType)){ 
    		  CodeNm = codeMapper.getCodeNmOnEnvironmentCode(CodeId);
    	} else if("SUPPLIER_CODE".equals(CodeType)){ 
  		  CodeNm = codeMapper.getCodeNmOnSupplier(CodeId);
  	}
    	
        return CodeNm;
    }
    
    
}
