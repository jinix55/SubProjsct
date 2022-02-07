package com.portal.adm.supplier.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.portal.adm.member.model.MemberModel;
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
     * 담당자 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public SupplierModel selectSupplierMngRepper(SupplierModel supplierModel) {
    	return supplierMapper.selectSupplierMngRepper(supplierModel);
    }
    
    /**
     * 담당자를 조회한다.
     *
     * @param groupId
     * @return
     */
    public SupplierModel selectSupplierManager(String managerId) {
    	return supplierMapper.selectSupplierManager(managerId);
    }
    
    /**
     * 담당자들을 조회한다.
     *
     * @param groupId
     * @return
     */
    public List<SupplierModel> selectSupplierManagers(String supplierCode) {
        return supplierMapper.selectSupplierManagers(supplierCode);
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
    
    /**
     * 공급업체정보를 등록한다.
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
     * 공급업체정보를 저장한다.
     *
     * @param supplierCode
     * @return
     */
    public String updateSupplier(SupplierModel supplierModel) {
        long count = supplierMapper.update(supplierModel);

        if(count > 0) {
            return Constant.DB.UPDATE;
        } else {
            return Constant.DB.FAIL;
        }
    }
    
    /**
     * 공급업체 매니저 정보를 저장한다.
     *
     * @param supplierCode
     * @return
     */
    public String saveManager(SupplierModel supplierModel) {
    	SupplierModel existManagerModel = supplierMapper.selectSupplierManagerSearch(supplierModel);
    	long count = -1;
    	if(existManagerModel != null) {
    		count = supplierMapper.updateManager(supplierModel);
            if(count > 0) {
                return Constant.DB.UPDATE;
            } else {
                return Constant.DB.FAIL;
            }
    	}else {
    		count = supplierMapper.insertManager(supplierModel);
            if(count > 0) {
                return Constant.DB.INSERT;
            } else {
                return Constant.DB.FAIL;
            }
    	}
    }
    
    /**
     * 공급업체 매니저 정보를 저장한다.
     *
     * @param supplierCode
     * @return
     */
    public String updateManager(SupplierModel supplierModel) {
    	long count = supplierMapper.updateManager(supplierModel);
    	if(count > 0) {
    		return Constant.DB.UPDATE;
    	} else {
    		return Constant.DB.FAIL;
    	}
    }
    
    
    /**
     * 공급업체 매니저 정보를 저장한다.
     *
     * @param supplierCode
     * @return
     */
    public String updateManagementId(SupplierModel supplierModel) {
		long count = supplierMapper.updateManagementId(supplierModel);
        if(count > 0) {
            return Constant.DB.UPDATE;
        } else {
            return Constant.DB.FAIL;
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
     * 공급업체 담당자를 삭제한다.
     *
     * @param supplierCode
     * @return
     */
    public String deleteManager(SupplierModel model) {
        long count = supplierMapper.deleteManager(model);

        if(count > 0) {
            return Constant.DB.DELETE;
        } else {
            return Constant.DB.FAIL;
        }
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
    

	/**
	 * 사용자관리 목록을 조회한다.
	 *
	 * @param criteria 페이징 모델
	 * @return
	 */
	public List<MemberModel> selectUserNmList(MemberModel model) {
		return supplierMapper.selectUserNmList(model);
	}

}
