package com.portal.adm.supplier.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.portal.adm.supplier.mapper.SupplierMapper;
import com.portal.adm.supplier.model.SupplierModel;
import com.portal.common.Constant;

@Service
public class SupplierService {
	
    @Resource
    private SupplierMapper supplierMapper;
    
    /**
     * 공급업체 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public List<SupplierModel> selectSupplierList(SupplierModel supplierModel) {
        return supplierMapper.selectSupplierList(supplierModel);
    }
    
    /**
     * 공급업체 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public int selectSupplierListCount(SupplierModel supplierModel) {
    	return supplierMapper.selectSupplierListCount(supplierModel);
    }
    
    public List<SupplierModel> selectListAll() {
    	return supplierMapper.selectListAll();
    }
    
    /**
     * 공급업체정보를 저장한다.
     *
     * @param supplierCode
     * @return
     */
    public String save(SupplierModel supplierModel) {
    	SupplierModel existModel = supplierMapper.select(supplierModel);

        if(existModel != null) {
            long count = supplierMapper.update(supplierModel);

            if(count > 0) {
                return Constant.DB.UPDATE;
            } else {
                return Constant.DB.FAIL;
            }
        } else {
            long count = supplierMapper.insert(supplierModel);

            if(count > 0) {
                return Constant.DB.INSERT;
            } else {
                return Constant.DB.FAIL;
            }
        }
    }
    
    /**
     * 공급업체정보를 삭제한다.
     *
     * @param supplierCode
     * @return
     */
    public String delete(SupplierModel supplierModel) {
        long count = supplierMapper.delete(supplierModel);

        if(count > 0) {
            return Constant.DB.DELETE;
        } else {
            return Constant.DB.FAIL;
        }
    }
    
    /**
     * 공급업체정보를 조회한다.
     *
     * @param supplierCode
     * @return
     */
    public String selectCode(String supplierCode) {
    	return supplierMapper.selectCode(supplierCode);
    }
    
    /**
     * 공급업체정보를 삭제한다.
     *
     * @param supplierCode
     * @return
     */
    public SupplierModel selectSupplierId(String supplierId) {
    	return supplierMapper.select(supplierId);
    }

}
