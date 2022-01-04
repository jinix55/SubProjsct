package com.portal.adm.supplier.mapper;

import java.util.List;

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
    * 공급업체정보를 조회한다.
    *
    * @param supplierModel
    * @return  공급업체 조회
    */
   SupplierModel select(SupplierModel supplierModel);
   
   /**
    * 모든 공급업체정보를 조회한다.
    *
    * @param supplierModel
    * @return  공급업체 조회
    */
   List<SupplierModel> selectListAll();
   
   /**
    * 공급업체정보를 삭제한다.
    *
    * @param supplierModel
    * @return  공급업체 삭제
    */
   long delete(SupplierModel supplierModel);
   
   /**
    * 공급업체정보를 삭제한다.
    *
    * @param supplierModel
    * @return  공급업체 삭제
    */
   String selectCode(String supplierCode);
   
   /**
    * 공급업체정보를 삭제한다.
    *
    * @param supplierModel
    * @return  공급업체 삭제
    */
   SupplierModel select(String supplierId);
}
