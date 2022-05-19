package com.portal.adm.product.mapper;

import java.util.List;

import com.portal.adm.product.model.ProductGroupFileModel;
import com.portal.adm.product.model.ProductModel;
import com.portal.common.annotation.ConnMapperFirst;

/**
 * Mybatis 코드관리 매핑 Interface
 */
@ConnMapperFirst
public interface ProductGroupFIleMapper {

    /**
     * 첨부파일 목록 카운트를 조회한다.
     *
     * @param productModel
     * @return
     */
    int selectProductGroupFileListCount(ProductGroupFileModel productGroupFileModel);
    
	 /**
     * 첨부파일 목록을 조회한다.
     *
     * @param productGroupFileModel 페이징 모델
     * @return
     */
    List<ProductGroupFileModel> selectProductGroupFileList(ProductGroupFileModel productGroupFileModel);
    

	/**
    * 첨부파일 목록을 조회한다.
    *
    * @param productGroupFileModel 페이징 모델
    * @return
    */
   List<ProductGroupFileModel> selectProductGroupFileListByGfileId(ProductGroupFileModel productGroupFileModel);
   

   /**
    * 첨부파일모델을 조회한다.
    *
    * @param productGroupFileModel 첨부파일ID를 사용
    * @return
    */
   ProductGroupFileModel selectProductGroupFile(ProductGroupFileModel productGroupFileModel);
   

   /**
    * 첨부파일 모델 신규 등록 insert
    * @param model 상품번호를 사용
    * @return
    */
   long insertProductGroupFile(ProductGroupFileModel productGroupFileModel);
   
   /**
    * 첨부파일 모델을 미사용으로 업데이트 한다.
    * @param model 첨부파일ID를 사용
    * @return
    */
   long updateProductGroupFile(ProductGroupFileModel productGroupFileModel);
   
   /**
    * 첨부파일 모델을 삭제로 업데이트 한다.
    * @param model 첨부파일ID를 사용
    * @return
    */
   long deleteProductGroupFile(ProductGroupFileModel productGroupFileModel);
}
