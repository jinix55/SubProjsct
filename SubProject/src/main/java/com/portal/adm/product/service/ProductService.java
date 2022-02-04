package com.portal.adm.product.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.adm.product.mapper.ProductMapper;
import com.portal.adm.product.model.ProductModel;
import com.portal.common.Constant;

/**
 * 제품코드 서비스 클래스
 */
@Service
public class ProductService {

    @Resource
    private ProductMapper productMapper;

    
    public List<ProductModel> selectList() {
        return productMapper.selectList();
    }
    
    
    
    
    /**
     * 제품코드 ID 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public List<ProductModel> selectGroupIdList(ProductModel model) {
        return productMapper.selectGroupIdList(model);
    }

    public int selectGroupIdListCount(ProductModel model) {
        return productMapper.selectGroupIdListCount(model);
    }


    /**
     * 제품코드 ID 리스트를 조회한다.(페이징X)
     *
     * @param groupId
     * @return
     */
    public List<ProductModel> selectGroupIdAllList(String groupId) {
        return productMapper.selectGroupIdAllList(groupId);
    }

    /**
     * 제품코드 ID와 코드ID가 동일한 코드모델을 조회한다.
     *
     * @param model
     * @return
     */
    public ProductModel select(ProductModel model) {
        return productMapper.select(model);
    }

    /**
     * 제품코드 ID와 코드ID가 동일한 코드모델을 삭제한다.
     *
     * @param model
     * @return
     */
    @Transactional
    public String delete(ProductModel model) {

//        if(model.getGroupId().equals("GROUP_ID")) {
//            int codeCount = selectCodeCountForGroupId(model);
//
//            if(codeCount > 0) {
//                return Constant.DB.USE_CODE_ID;
//            }
//        }

        long count = 1; //productMapper.delete(model);

        if(count > 0) {
            return Constant.DB.DELETE;
        } else {
            return Constant.DB.FAIL;
        }
    }

    /**
     * 제품코드 저장한다. 제품코드ID와 코드ID가 동일한 코드모델이 존재하면 업데이트 아니면 신규등록한다.
     *
     * @param model
     * @return
     */
    @Transactional
    public String save(ProductModel model) {
        ProductModel existModel = select(model);

        if(existModel != null) {
            long count = productMapper.update(model);

            if(count > 0) {
                return Constant.DB.UPDATE;
            } else {
                return Constant.DB.FAIL;
            }
        } else {
            long count = productMapper.insert(model);

            if(count > 0) {
                return Constant.DB.INSERT;
            } else {
                return Constant.DB.FAIL;
            }
        }
    }

    public int selectCodeCountForGroupId(ProductModel model) {
        return productMapper.selectCodeCountForGroupId(model);
    }
}
