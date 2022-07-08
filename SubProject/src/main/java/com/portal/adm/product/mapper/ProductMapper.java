package com.portal.adm.product.mapper;

import java.util.List;

import com.portal.adm.environPrice.model.EnvironPriceModel;
import com.portal.adm.packagingCode.model.PackagingCodeModel;
import com.portal.adm.product.model.ProdPartModel;
import com.portal.adm.product.model.ProdRecycleCalclModel;
import com.portal.adm.product.model.ProdMappingModel;
import com.portal.adm.product.model.ProdPackagingDetailModel;
import com.portal.adm.product.model.ProdPackagingMatModel;
import com.portal.adm.product.model.ProdPackagingModel;
import com.portal.adm.product.model.ProdPackagingSelfFileModel;
import com.portal.adm.product.model.ProdPackagingSelfModel;
import com.portal.adm.product.model.ProductModel;
import com.portal.common.annotation.ConnMapperFirst;

/**
 * Mybatis 코드관리 매핑 Interface
 */
@ConnMapperFirst
public interface ProductMapper {

	 /**
     * 상품관리 목록을 조회한다.
     *
     * @param productModel 페이징 모델
     * @return
     */
    List<ProductModel> selectProductList(ProductModel productModel);

    /**
     * 상품관리 목록 카운트를 조회한다.
     *
     * @param productModel
     * @return
     */
    int selectProductListCount(ProductModel productModel);
    
    /**
     * 상품모델을 조회한다.
     *
     * @param productModel 상품번호를 사용
     * @return
     */
    ProductModel selectProduct(ProductModel productModel);
    
    /**
     * 상품 모델 신규 등록 insert
     * @param model 상품번호를 사용
     * @return
     */
    long insertProduct(ProductModel productModel);
    
    /**
     * 상품 모델을 업데이트 한다.
     * @param model 상품번호를 사용
     * @return
     */
    long updateProduct(ProductModel productModel);
    
    long updateProductRecycleGrade(ProductModel productModel);
    
    /**
     * 상품 모델을 미사용으로 업데이트 한다.
     * @param model 상품번호를 사용
     * @return
     */
    long deleteProduct(ProductModel productModel);
    
    
    List<ProdMappingModel> selectProductMappingList(ProductModel productModel);
    
    int selectProductMatMappingCount(ProdMappingModel prodMappingModel);
    
    /**
     * 상품포장정보관리 목록 조회한다.
     *
     * @param productPackagingModel
     * @return
     */
    List<ProdPackagingModel> selectProductPackagingOrder(ProdPackagingModel productPackagingModel);
    
    /**
     * 상품포장정보관리 목록을 조회한다.
     *
     * @param productPackagingModel 모델
     * @return
     */
    List<ProdPackagingModel> selectProductPackaging(ProdPackagingModel productPackagingModel);
    
    List<ProdPackagingModel> selectProductPackagingListByProductId(ProdPackagingModel productPackagingModel);
    
    
    
    /**
     * 상품포장정보관리 상세 조회한다.
     *
     * @param productPackagingModel 모델
     * @return
     */
    ProdPackagingModel selectProductPackagingDetail(ProdPackagingModel productPackagingModel);
    List <ProdPackagingModel> selectProdPackagingOrderNmList(ProdPackagingModel productPackagingModel);
    
    
    /**
     * 상품포장정보 모델 신규 등록 insert
     * @param model 상품번호를 사용
     * @return
     */
    long insertProductPackaging(ProdPackagingModel productPackagingModel);
    
    /**
     * 상품포장정보 모델을 업데이트 한다.
     * @param model 상품포장정보번호를 사용
     * @return
     */
    long updateProductPackaging(ProdPackagingModel productPackagingModel);
    
    /**
     * 상품포장정보 모델을 미사용으로 업데이트 한다.
     * @param model 상품번호를 사용
     * @return
     */
    long deleteProductPackaging(ProdPackagingModel productPackagingModel);
    
    
    /**
     * 재질정보 조회한다.
     *
     * @param 
     * @return
     */
    List<EnvironPriceModel> selectProductMatTypeList();
    
    /**
     * 제품 PACK TYPE 정보를 조회한다.
     *  
     *  몸체, 라벨 ....
     * @param 
     * @return
     */
   
    List<ProdPartModel> selectProdPartList(ProdPartModel prodPartModel);
    
    
    /**
     * 제품 재질정보 정보를 조회한다.
     *  
     * @param 
     * @return
     */
   
    List<ProdPackagingDetailModel> selectProdPackagingDetailList(ProdPackagingDetailModel prodPackagingDetailModel);    
    ProdPackagingDetailModel selectProdPackagingDetail(ProdPackagingDetailModel prodPackagingDetailModel);
    
    
	long delectProdPackagingDetail(ProdPackagingDetailModel prodPackagingDetailModel);
	long insertProdPackagingDetail(ProdPackagingDetailModel prodPackagingDetailModel);
	long updateProdPackagingDetail(ProdPackagingDetailModel prodPackagingDetailModel);
    
	
	
	List<ProdPackagingSelfModel> selectProdPackagingSelfList(ProdPackagingSelfModel prodPackagingSelfModel);
	long delectProdPackagingSelf(ProdPackagingSelfModel prodPackagingSelfModel);
	long insertProdPackagingSelf(ProdPackagingSelfModel prodPackagingSelfModel);
	
	
	List<ProdPackagingSelfFileModel> selectProdPackagingSelfFileList(ProdPackagingSelfFileModel prodPackagingSelfFileModel);	
	long deleteProdPackagingSelfFile(ProdPackagingSelfFileModel prodPackagingSelfFileModel);
	long deleteProdPackagingSelfFileByFileId(ProdPackagingSelfFileModel prodPackagingSelfFileModel);
	long insertProdPackagingSelfFile(ProdPackagingSelfFileModel prodPackagingSelfFileModel);
	
	
	List<ProdRecycleCalclModel> selectProdRecycleList(ProdRecycleCalclModel prodRecycleCalclModel);
	
	 /**
     * 상품 재활용분담금 목록을 조회한다.
     *
     * @param productModel 페이징 모델
     * @return
     */
    ProductModel selectProductRecyle(ProductModel productModel);
    
	 /**
     * 상품 재활용분담금 등록한다.
     *
     * @param productModel 페이징 모델
     * @return
     */
    long  mergeProductRecyleContributions(ProductModel productModel);    
    
	 /**
     * 상품별 max 포장 찻수를 반환한다
     *
     * @param productModel
     * @return
     */
    
    
    
    
    int selectMaxProductPackagingOrder(String productId);
    
    int selectMaxPartProductPackagingOrder(String productId);
    
    
    
    List<ProdPackagingModel> selectProductPackagingList(ProdPackagingModel prodPackagingModel);
    
    
    
    
    List<ProdPackagingModel> selectProductPackagingListByProc(ProdPackagingModel prodPackagingModel);
    
    
    /**
     * 제품 포장 재 질관리[제품 포장 재질 관리] 목록을 조회한다.
     *
     * @param productPackagingModel 모델
     * @return
     */
    List<ProdPackagingMatModel> selectProductPackagingMatList(ProdPackagingMatModel prodPackagingMatModel);
    
    /**
     * 상품포장정보 모델 신규 등록 insert
     * @param model 상품번호를 사용
     * @return
     */
    long insertProductPackagingMat(ProdPackagingMatModel prodPackagingMatModel);
    
    
    /**
     * 상품포장정보 모델을 미사용으로 업데이트 한다.
     * @param model 상품번호를 사용
     * @return
     */
    long deleteProductPackagingMat(ProdPackagingMatModel prodPackagingMatModel);
    
    
    public String getProductId(String productCoded);
    
    public String getProductNm(String productCoded);
    
    public int selectCountSameProductCode(ProductModel productModel);
    
    List<ProdPackagingMatModel> selectProductSelfPackaging(ProdPackagingMatModel prodPackagingMatModel);
    long insertProductSelfPackaging(ProdPackagingMatModel prodPackagingMatModel);
    long deleteProductSelfPackaging(ProdPackagingMatModel prodPackagingMatModel);
    
}
