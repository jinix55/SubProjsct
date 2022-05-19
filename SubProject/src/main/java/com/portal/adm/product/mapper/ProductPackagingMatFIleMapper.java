package com.portal.adm.product.mapper;

import java.util.List;

import com.portal.adm.product.model.ProductPackagingMatFileModel;
import com.portal.common.annotation.ConnMapperFirst;

/**
 * Mybatis 코드관리 매핑 Interface
 */
@ConnMapperFirst
public interface ProductPackagingMatFIleMapper {

    /**
     * 첨부파일 목록 카운트를 조회한다.
     *
     * @param productModel
     * @return
     */
    int selectProductPackagingMatFileListCount(ProductPackagingMatFileModel productPackagingMatFileModel);
    
	 /**
     * 첨부파일 목록을 조회한다.
     *
     * @param productPackagingMatFileModel 페이징 모델
     * @return
     */
    List<ProductPackagingMatFileModel> selectProductPackagingMatFileList(ProductPackagingMatFileModel productPackagingMatFileModel);
    

	/**
    * 첨부파일 목록을 조회한다.
    *
    * @param productPackagingMatFileModel 페이징 모델
    * @return
    */
   List<ProductPackagingMatFileModel> selectProductPackagingMatFileListByGfileId(ProductPackagingMatFileModel productPackagingMatFileModel);
   

   /**
    * 첨부파일모델을 조회한다.
    *
    * @param productPackagingMatFileModel 첨부파일ID를 사용
    * @return
    */
   ProductPackagingMatFileModel selectProductPackagingMatFile(ProductPackagingMatFileModel productPackagingMatFileModel);
   

   /**
    * 첨부파일 모델 신규 등록 insert
    * @param model 상품번호를 사용
    * @return
    */
   long insertProductPackagingMatFile(ProductPackagingMatFileModel productPackagingMatFileModel);
   
   /**
    * 첨부파일 모델을 미사용으로 업데이트 한다.
    * @param model 첨부파일ID를 사용
    * @return
    */
   long updateProductPackagingMatFile(ProductPackagingMatFileModel productPackagingMatFileModel);
   
   /**
    * 첨부파일 모델을 삭제로 업데이트 한다.
    * @param model 첨부파일ID를 사용
    * @return
    */
   long deleteProductPackagingMatFile(ProductPackagingMatFileModel productPackagingMatFileModel);
}
