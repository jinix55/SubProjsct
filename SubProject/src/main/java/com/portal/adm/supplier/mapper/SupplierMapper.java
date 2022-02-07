package com.portal.adm.supplier.mapper;

import java.util.List;

import com.portal.adm.member.model.MemberModel;
import com.portal.adm.supplier.model.SupplierModel;
import com.portal.common.annotation.ConnMapperFirst;

@ConnMapperFirst
public interface SupplierMapper {
	
	/**
	 * 공급업체 리스트를 가져온다
	 *
	 * @param supplierModel
	 * @return  공급업체 리스트
	 */
	List<SupplierModel> selectSupplierList(SupplierModel supplierModel);
	
	
	/**
	 * 담당자 리스트를 가져온다
	 *
	 * @param supplierModel
	 * @return  공급업체 리스트
	 */
	SupplierModel selectSupplierMngRepper(SupplierModel model);
	
	
	/**
	 * 대표 담당자를 가져온다
	 *
	 * @param supplierModel
	 * @return  공급업체 리스트
	 */
	List<SupplierModel> selectSupplierManagers(String supplierCode);
	
	/**
	 * 담당자들을 가져온다
	 *
	 * @param supplierModel
	 * @return  공급업체 리스트
	 */
	SupplierModel selectSupplierManager(String managerId);
	
	/**
     * 담당자들을 가져온다
     *
     * @param supplierModel
     * @return  공급업체 리스트
     */
	SupplierModel selectSupplierManagerSearch(SupplierModel model);
    
    /**
     * 공급업체 카운트를 가져온다
     *
     * @param supplierModel
     * @return  공급업체 카운트
     */
   int selectSupplierListCount(SupplierModel supplierModel);
   
   /**
    * 공급업체정보를 등록한다.
    *
    * @param supplierModel
    * @return  공급업체 등록
    */
   int insert(SupplierModel supplierModel);
   
   /**
    * 공급업체정보를 업데이트한다.
    *
    * @param supplierModel
    * @return  공급업체 업데이트
    */
   long update(SupplierModel supplierModel);
   
   /**
    * 공급업체정보를 등록한다.
    *
    * @param supplierModel
    * @return  공급업체 등록
    */
   int insertManager(SupplierModel model);
   
   /**
    * 공급업체정보를 업데이트한다.
    *
    * @param supplierModel
    * @return  공급업체 업데이트
    */
   long updateManager(SupplierModel model);
   
   /**
    * 공급업체정보를 업데이트한다.
    *
    * @param supplierModel
    * @return  공급업체 업데이트
    */
   long updateManagementId(SupplierModel model);
   
   /**
    * 공급업체정보를 조회한다.
    *
    * @param supplierModel
    * @return  공급업체 조회
    */
   SupplierModel select(SupplierModel supplierModel);
   
   /**
    * 공급업체정보를 삭제한다.
    *
    * @param supplierModel
    * @return  공급업체 삭제
    */
   long delete(SupplierModel supplierModel);
   
   /**
    * 공급업체 담당자를 삭제한다.
    *
    * @param supplierModel
    * @return  공급업체 삭제
    */
   long deleteManager(SupplierModel model);
   
   /**
    * 공급업체정보를 삭제한다.
    *
    * @param supplierModel
    * @return  공급업체 삭제
    */
   SupplierModel select(String supplierId);
   
   /**
    * 공급업체정보를 삭제한다.
    *
    * @param supplierModel
    * @return  공급업체 삭제
    */
   List<MemberModel> selectUserNmList(MemberModel model);
}
