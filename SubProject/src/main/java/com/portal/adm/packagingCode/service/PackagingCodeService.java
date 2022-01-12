package com.portal.adm.packagingCode.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.adm.packagingCode.mapper.PackagingCodeMapper;
import com.portal.adm.packagingCode.model.PackagingCodeModel;
import com.portal.common.Constant;

/**
 * 환경부코드 서비스 클래스
 */
@Service
public class PackagingCodeService {

    @Resource
    private PackagingCodeMapper packagingCodeMapper;

    /**
     * 환경부코드 ID 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public List<PackagingCodeModel> selectGroupIdList(PackagingCodeModel model) {
    	return packagingCodeMapper.selectGroupIdList(model);
    }
    
    /**
     * 환경부코드 리스트 날짜를 조회한다.
     *
     * @param groupId
     * @return
     */
    public List<PackagingCodeModel> selectCodeDayList(PackagingCodeModel model) {
        return packagingCodeMapper.selectCodeDayList(model);
    }

    public int selectGroupIdListCount(PackagingCodeModel model) {
        return packagingCodeMapper.selectGroupIdListCount(model);
    }


    /**
     * 환경부코드 ID 리스트를 조회한다.(페이징X)
     *
     * @param groupId
     * @return
     */
    public List<PackagingCodeModel> selectGroupIdAllList(String groupId) {
        return packagingCodeMapper.selectGroupIdAllList(groupId);
    }

    /**
     * 환경부코드 ID와 코드ID가 동일한 코드모델을 조회한다.
     *
     * @param model
     * @return
     */
    public List<PackagingCodeModel> selectList(PackagingCodeModel model) {
        return packagingCodeMapper.selectList(model);
    }
    
    /**
     * 환경부코드 ID와 코드ID가 동일한 코드모델을 조회한다.
     *
     * @param model
     * @return
     */
    public PackagingCodeModel select(PackagingCodeModel model) {
        return packagingCodeMapper.select(model);
    }

    /**
     * 환경부코드 ID와 코드ID가 동일한 코드모델을 삭제한다.
     *
     * @param model
     * @return
     */
    @Transactional
    public String delete(PackagingCodeModel model) {
    	String groupId = model.getGroupId();
    	String codeId = model.getCodeId();
        if(StringUtils.equals(model.getDelType(),"large")) {
        	model.setGroupId(model.getCodeId());
        	List<PackagingCodeModel> list1 = packagingCodeMapper.selectList(model);
        	for(PackagingCodeModel codeList : list1) {
        		PackagingCodeModel downModel = new PackagingCodeModel();
        		downModel.setGroupId(codeList.getCodeId());
        		downModel.setUpCompanyCode(model.getUpCompanyCode());
        		List<PackagingCodeModel> list2 = packagingCodeMapper.selectList(downModel);
        		for(PackagingCodeModel code : list2) {
        			code.setUpCompanyCode(model.getUpCompanyCode());
        			packagingCodeMapper.delete(code);
        		}
        	}
        	packagingCodeMapper.deleteDownCode(model);
        }else if(StringUtils.equals(model.getDelType(),"middle")) {
        	packagingCodeMapper.deleteDownCode(model);
        }
        
        model.setGroupId(groupId);
        model.setCodeId(codeId);
        long count = packagingCodeMapper.delete(model);
        
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
    public String save(PackagingCodeModel model) {
        PackagingCodeModel existModel = select(model);

        if(existModel != null) {
            long count = packagingCodeMapper.update(model);

            if(count > 0) {
                return Constant.DB.UPDATE;
            } else {
                return Constant.DB.FAIL;
            }
        } else {
            long count = packagingCodeMapper.insert(model);

            if(count > 0) {
                return Constant.DB.INSERT;
            } else {
                return Constant.DB.FAIL;
            }
        }
    }

    public int selectCodeCountForGroupId(PackagingCodeModel model) {
        return packagingCodeMapper.selectCodeCountForGroupId(model);
    }
}
