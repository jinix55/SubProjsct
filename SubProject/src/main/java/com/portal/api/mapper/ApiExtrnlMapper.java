package com.portal.api.mapper;

import com.portal.adm.file.model.FileModel;
import com.portal.adm.product.model.ProdPackagingModel;
import com.portal.api.model.ApiExtrnlModel;
import com.portal.common.annotation.ConnMapperFirst;

/**
 * Mybatis 포장 api 매핑 Interface
 */
@ConnMapperFirst
public interface ApiExtrnlMapper {

	/**
	 * 포장 api key 따른 데이터를 조회한다.
	 *
	 * @param model 외부시스템ID를 사용
	 * @return
	 */
	ApiExtrnlModel select(ApiExtrnlModel model);
	
	/**
	 * 포장 api key 기준 상품 포장 데이터를 조회한다.
	 *
	 * @param model 외부시스템ID를 사용
	 * @return
	 */
	ProdPackagingModel selectProdApiInfo(ProdPackagingModel model);
	
	/**
	 * 포장 api 따른 데이터를 저장한다.
	 *
	 * @param model 외부시스템ID를 사용
	 * @return
	 */
	long insert(ApiExtrnlModel model);
	
    /**
     * 포장 api 유효데이터를 정리한다.
     *
     * @param model 외부시스템ID를 사용
     * @return
     */
    long updateDate();
    
    long insertFile(FileModel model);
    
    long updatePackagingInfo(ProdPackagingModel model);

}
