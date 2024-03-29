package com.portal.adm.product.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.adm.code.mapper.CodeMapper;
import com.portal.adm.code.model.CodeModel;
import com.portal.adm.code.service.CodeService;
import com.portal.adm.environPrice.model.EnvironPriceModel;
import com.portal.adm.packagingCode.model.PackagingCodeModel;
import com.portal.adm.product.mapper.ProductMapper;
import com.portal.adm.product.model.ProdPartModel;
import com.portal.adm.product.model.ProdRecycleCalclModel;
import com.portal.adm.product.model.ProdMappingModel;
import com.portal.adm.product.model.ProdPackagingDetailModel;
import com.portal.adm.product.model.ProdPackagingMatModel;
import com.portal.adm.product.model.ProdPackagingModel;
import com.portal.adm.product.model.ProdPackagingSelfFileModel;
import com.portal.adm.product.model.ProdPackagingSelfModel;
import com.portal.adm.product.model.ProductModel;
import com.portal.common.Constant;
import com.portal.common.IdUtil;

/**
 * 제품코드 서비스 클래스
 */
@Service
public class ProductService {

    @Resource
    private ProductMapper productMapper;
    
    @Resource
    private CodeMapper codeMapper;

    @Resource
    private CodeService codeService;
    
    @Resource
    private IdUtil idUtil;    

//    @Resource
//    private Constant constant;
    
    /**
	 * 상품관리 목록을 조회한다.
	 *
	 * @param criteria 페이징 모델
	 * @return
	 */
    public List<ProductModel> selectProductList(ProductModel productModel) {
    	CodeModel codeModel = new CodeModel();
    	ProdPackagingModel prodPackagingModel = new ProdPackagingModel();
    	List<ProdPackagingModel> prodPackagingList = new ArrayList<>() ;
    	
    	List<ProductModel> productList = productMapper.selectProductList(productModel);
//    	for(ProductModel p : productList) {
    		
    		//p.setCompleteStatus(codeService.getCodeNm(constant._CODE_, p.getMasterApply(),constant._MAPPING_STAT_CODE_));
//    		p.setMasterApplyNm(codeService.getCodeNm("_CODE_", p.getMasterApplyCode(), "ENVIRONMENT_PROCEED_STAT_CODE"));
//    		
//    		prodPackagingModel.setProductCode(p.getProductCode());
//    		prodPackagingList = productMapper.selectProductPackagingListByProductId(prodPackagingModel);
//    		for(ProdPackagingModel pp : prodPackagingList) {
//    			p.setMatClsNm(codeService.getCodeNm("MAT_TYPE", pp.getMatType(), null));
//    			break;
//    		}
//    	}
        return productList;
    }
    
    /**
	 * 상품 목록 카운트를 조회한다.
	 *
	 * @param criteria 페이징 모델
	 * @return
	 */
	public int selectProductListCount(ProductModel productModel) {
		return productMapper.selectProductListCount(productModel);
	}
    
	/**
	 * 상품아이디를 이용하여 상품정보를 조회한다.
	 *
	 * @param model productCode(상품코드)을 사용
	 * @return
	 */
	public ProductModel selectProduct(ProductModel productModel) {
		ProductModel productRecyleContributionsModel = new ProductModel();
		ProductModel outProductModel = productMapper.selectProduct(productModel);

		productModel.setInBaseYear("2021");
		
		productRecyleContributionsModel = new ProductModel();
		
		
		
		productRecyleContributionsModel = productMapper.selectProductRecyle(productModel);
		
       	
    	if(productRecyleContributionsModel != null) {
    		outProductModel.setBaseYear("2021");
    		outProductModel.setAccumulateSaleQty(productRecyleContributionsModel.getAccumulateSaleQty());
    		outProductModel.setPackingTotalWeight(productRecyleContributionsModel.getPackingTotalWeight());
    		outProductModel.setRecyleContributions(productRecyleContributionsModel.getRecyleContributions());
    	}
  	
		List<CodeModel> environmentProceedStatCode = codeService.selectGroupIdAllList("ENVIRONMENT_PROCEED_STAT_CODE");
		outProductModel.setEnvironmentProceedStatCode(environmentProceedStatCode);
		List<CodeModel> mappingStatCode = codeService.selectGroupIdAllList("MAPPING_STAT_CODE");
		outProductModel.setMappingStatCode(mappingStatCode);
		
		return outProductModel;
	}
	
	
	/**
	 * 상품 정보를 등록한다.
	 *
	 * @param model 상품번호를 사용
	 * @return
	 */
	@Transactional
	public String insertProduct(ProductModel productModel) {
		System.out.println("insertProduct productModel " + productModel);
		long count = productMapper.insertProduct(productModel);
		
		if (count > 0) {
			return Constant.DB.INSERT;
		} else {
			return Constant.DB.FAIL;
		}
	}

	/**
	 * 상품 정보를 수정한다.
	 *
	 * @param model 상품번호를 사용
	 * @return
	 */
	@Transactional
	public String updateProduct(ProductModel productModel) {
		
		long count = productMapper.updateProduct(productModel);
/*----------------------------------------------------------		
		int year = Calendar.getInstance().get(Calendar.YEAR);
		ProductModel productRecyleContributionsModel = new ProductModel();
		for(int i = 1; i <= 3; i++) {
			
			productRecyleContributionsModel = new ProductModel();
			productRecyleContributionsModel.setProductCode(productModel.getProductCode());
			productRecyleContributionsModel.setBaseYear(Integer.toString(year - i));
			
	        switch (i) {
	            case 1:
	            	productRecyleContributionsModel.setAccumulateSaleQty(productModel.getAccumulateSaleQty());
	            	productRecyleContributionsModel.setPackingTotalWeight(productModel.getPackingTotalWeight());
	            	productRecyleContributionsModel.setRecyleContributions(productModel.getRecyleContributions());
	            	productMapper.mergeProductRecyleContributions(productRecyleContributionsModel);
	                break;
	            case 2:
	            	productRecyleContributionsModel.setAccumulateSaleQty(productModel.getAccumulateSaleQty_1());
	            	productRecyleContributionsModel.setPackingTotalWeight(productModel.getPackingTotalWeight_1());
	            	productRecyleContributionsModel.setRecyleContributions(productModel.getRecyleContributions_1());
	            	productMapper.mergeProductRecyleContributions(productRecyleContributionsModel);
	                break;            	
	            case 3:
	            	productRecyleContributionsModel.setAccumulateSaleQty(productModel.getAccumulateSaleQty_2());
	            	productRecyleContributionsModel.setPackingTotalWeight(productModel.getPackingTotalWeight_2());
	            	productRecyleContributionsModel.setRecyleContributions(productModel.getRecyleContributions_2());
	            	productMapper.mergeProductRecyleContributions(productRecyleContributionsModel);
	                break;            	
	        }
		}		
*/
		
		if (count > 0) {
			return Constant.DB.UPDATE;
		} else {
			return Constant.DB.FAIL;
		}
	}
	
	@Transactional
	public String updateProductRecycleGrade(ProductModel productModel) {
		long count = productMapper.updateProductRecycleGrade(productModel);
		if (count > 0) {
			return Constant.DB.UPDATE;
		} else {
			return Constant.DB.FAIL;
		}
	}
	
	/**
	 * 상품 정보를 수정(삭제,미사용)한다.
	 *
	 * @param model 상품번호를 사용
	 * @return
	 */
	@Transactional
	public String deleteProduct(ProductModel productModel) {
		long count = productMapper.deleteProduct(productModel);
		if (count > 0) {
			return Constant.DB.DELETE;
		} else {
			return Constant.DB.FAIL;
		}
	}
	
	
    /**
     * 제품 PACK TYPE 정보를 조회한다.
     *  
     *  몸체, 라벨 ....
     * @param 
     * @return
     */
	@Transactional
	public List<ProdPartModel> selectProdPartList(ProdPartModel prodPartModel)
	{
		return productMapper.selectProdPartList(prodPartModel);
	}
	
	@Transactional
	public List<ProdPackagingDetailModel> selectProdPackagingDetailList(ProdPackagingDetailModel prodPackagingDetailModel)
	{
		return productMapper.selectProdPackagingDetailList(prodPackagingDetailModel);
	}	

	@Transactional
	public ProdPackagingDetailModel selectProdPackagingDetail(ProdPackagingDetailModel prodPackagingDetailModel)
	{
		return productMapper.selectProdPackagingDetail(prodPackagingDetailModel);
	}	
		
	
	@Transactional
	public String delectProdPackagingDetail(ProdPackagingDetailModel prodPackagingDetailModel) {
		long count = productMapper.delectProdPackagingDetail(prodPackagingDetailModel);
		if (count > 0) {
			return Constant.DB.DELETE;
		} else {
			return Constant.DB.FAIL;
		}
	}	
	
	@Transactional
	public String insertProdPackagingDetail(ProdPackagingDetailModel prodPackagingDetailModel) {
		long count = productMapper.insertProdPackagingDetail(prodPackagingDetailModel);
		if (count > 0) {
			return Constant.DB.INSERT;
		} else {
			return Constant.DB.FAIL;
		}
	}	
	
	@Transactional
	public String updateProdPackagingDetail(ProdPackagingDetailModel prodPackagingDetailModel) {
		long count = productMapper.updateProdPackagingDetail(prodPackagingDetailModel);
		if (count > 0) {
			return Constant.DB.UPDATE;
		} else {
			return Constant.DB.FAIL;
		}
	}		
	
	@Transactional
	public List<ProdPackagingSelfModel> selectProdPackagingSelfList(ProdPackagingSelfModel prodPackagingSelfModel)
	{
		return productMapper.selectProdPackagingSelfList(prodPackagingSelfModel);
	}	
	
	@Transactional
	public String delectProdPackagingSelf(ProdPackagingSelfModel prodPackagingSelfModel) {
		long count = productMapper.delectProdPackagingSelf(prodPackagingSelfModel);
		if (count > 0) {
			return Constant.DB.DELETE;
		} else {
			return Constant.DB.FAIL;
		}
	}	
	
	@Transactional
	public String insertProdPackagingSelf(ProdPackagingSelfModel prodPackagingSelfModel) {
		long count = productMapper.insertProdPackagingSelf(prodPackagingSelfModel);
		if (count > 0) {
			return Constant.DB.INSERT;
		} else {
			return Constant.DB.FAIL;
		}
	}	 	
	
	
	@Transactional
	public List<ProdPackagingModel> selectProdPackagingOrderNmList(ProdPackagingModel prodPackagingModel)
	{
		return productMapper.selectProdPackagingOrderNmList(prodPackagingModel);
	}
	
	@Transactional
	public List<ProdPackagingSelfFileModel> selectProdPackagingSelfFileList(ProdPackagingSelfFileModel prodPackagingSelfFileModel)
	{
		return productMapper.selectProdPackagingSelfFileList(prodPackagingSelfFileModel);
	}		
	@Transactional
	public String deleteProdPackagingSelfFile(ProdPackagingSelfFileModel prodPackagingSelfFileModel) {
		long count = productMapper.deleteProdPackagingSelfFile(prodPackagingSelfFileModel);
		if (count > 0) {
			return Constant.DB.DELETE;
		} else {
			return Constant.DB.FAIL;
		}
	}	

	@Transactional
	public String deleteProdPackagingSelfFileByFileId(ProdPackagingSelfFileModel prodPackagingSelfFileModel) {
		long count = productMapper.deleteProdPackagingSelfFileByFileId(prodPackagingSelfFileModel);
		if (count > 0) {
			return Constant.DB.DELETE;
		} else {
			return Constant.DB.FAIL;
		}
	}	

	
	@Transactional
	public String insertProdPackagingSelfFile(ProdPackagingSelfFileModel prodPackagingSelfFileModel) {
		long count = productMapper.insertProdPackagingSelfFile(prodPackagingSelfFileModel);
		if (count > 0) {
			return Constant.DB.INSERT;
		} else {
			return Constant.DB.FAIL;
		}
	}		
	
	
	public ProdMappingModel mapping(ProductModel productModel) {
		ProdMappingModel prodMappingModel = new ProdMappingModel();
		CodeModel codeModel = new CodeModel();

		prodMappingModel.setMasterApplyCode("UNPROCEED");
		codeModel.setGroupId("ENVIRONMENT_PROCEED_STAT_CODE");
		codeModel.setCodeId("UNPROCEED");
		codeModel = codeMapper.select(codeModel);
		prodMappingModel.setMasterApplyNm(codeModel.getCodeNm());
		
		
		prodMappingModel.setMasterMappingCode("NONEMAPPING");
		codeModel.setGroupId("MAPPING_STAT_CODE");
		codeModel.setCodeId("NONEMAPPING");
		codeModel = codeMapper.select(codeModel);
		prodMappingModel.setMasterMappingNM(codeModel.getCodeNm());

		System.out.println("productModel " + productModel);
		List<ProdMappingModel> prodMappingList =  productMapper.selectProductMappingList(productModel);
		
		System.out.println("prodMappingList " + prodMappingList);
		
		int productMatMappingCount = 0;
		for(ProdMappingModel p : prodMappingList) {
			p.setProductCode(productModel.getProductCode());
			productMatMappingCount = productMapper.selectProductMatMappingCount(p);
			if(productMatMappingCount == 0) {
				prodMappingModel.setMasterApplyCode("COMPLETION");
				prodMappingModel.setApprovalNo(p.getApprovalNo());
				prodMappingModel.setMasterMappingCode("MAPPING");
				prodMappingModel.setMappingProductCode(p.getMappingProductCode());
				prodMappingModel.setMappingProductNm(this.getProductNm(p.getMappingProductCode()));
			}
		}
		return prodMappingModel;
	}	
	
	
	public List<ProdRecycleCalclModel>  selectProdRecycleList(ProdRecycleCalclModel prodRecycleCalclModel) {
		return productMapper.selectProdRecycleList(prodRecycleCalclModel);
	}	
	
	//##################################################################################################################################################
	//##################################################################################################################################################
	//##################################################################################################################################################
	
	 /**
	 * 상품포장정보관리 목록 카운트를 조회한다.
	 *
	 * @param productPackagingModel
	 * @return
	 */
	public List<ProdPackagingModel> selectProductPackagingOrder(ProdPackagingModel productPackagingModel) {
		return productMapper.selectProductPackagingOrder(productPackagingModel);
	}
		
	/**
	 * 상품포장정보관리 목록을 조회한다.
	 *
	 * @param criteria 모델
	 * @return
	 */
    public List<ProdPackagingModel> selectProductPackaging(ProdPackagingModel productPackagingModel) {
        return productMapper.selectProductPackaging(productPackagingModel);
    }
	
    /**
	 * 상품포장정보관리 상세정보 조회한다.
	 *
	 * @param criteria 모델
	 * @return
	 */
    public ProdPackagingModel selectProductPackagingDetail(ProdPackagingModel productPackagingModel) {
        return productMapper.selectProductPackagingDetail(productPackagingModel);
    }
    
    /**
	 * 상품포장 정보를 등록한다.
	 *
	 * @param model 상품포장정보번호를 사용
	 * @return
	 */
	@Transactional
	public String insertProductPackaging(ProdPackagingModel productPackagingModel) {
		long count = productMapper.insertProductPackaging(productPackagingModel);
		
		if (count > 0) {
			return Constant.DB.INSERT;
		} else {
			return Constant.DB.FAIL;
		}
	}

	/**
	 * 상품포장정보 정보를 수정한다.
	 *
	 * @param model 상품포장정보번호를 사용
	 * @return
	 */
	@Transactional
	public String updateProductPackaging(ProdPackagingModel productPackagingModel) {
		
		long count = productMapper.updateProductPackaging(productPackagingModel);

		if (count > 0) {
			return Constant.DB.UPDATE;
		} else {
			return Constant.DB.FAIL;
		}
	}
	
	/**
	 * 상품포장정보 정보를 수정(삭제,미사용)한다.
	 *
	 * @param model 상품포장정보번호를 사용
	 * @return
	 */
	@Transactional
	public String deleteProductPackaging(ProdPackagingModel productPackagingModel) {
		long count = productMapper.deleteProductPackaging(productPackagingModel);
		if (count > 0) {
			return Constant.DB.DELETE;
		} else {
			return Constant.DB.FAIL;
		}
	}
	
	/**
	 *  재질정보 조회한다.
	 *
	 * @param
	 * @return
	 */
	public List<EnvironPriceModel> selectProductMatTypeList() {
        return productMapper.selectProductMatTypeList();
    }
	
	
	/**
	 *  환경부담금을 계산한다.
	 *
	 * @param
	 * @return
	 */	
	public String calcRecyleContributions(ProductModel productModel) {
		return "987";
	}



	

	public List<ProdPackagingModel>  apply(ProductModel productModel) {
		List<ProdPackagingModel>  prodPackagingList = new ArrayList<>() ;
		
		String productCode =  productModel.getProductCode();
		String applyProductCode =  productModel.getApplyProductCode();
	
		ProdPackagingModel prodPackagingModel = new ProdPackagingModel();
		prodPackagingModel.setProductCode(applyProductCode);
		prodPackagingList = productMapper.selectProductPackagingListByProductId(prodPackagingModel);
		
		int maxPartProductPackagingOrder = productMapper.selectMaxPartProductPackagingOrder(productCode);
		String CodeNm = "";
        for(ProdPackagingModel p : prodPackagingList) {
           p.setPackagingId(idUtil.getPackagingId());        	
           p.setProductCode(productCode);
           p.setPackagingOrder(maxPartProductPackagingOrder + 1);
/*           
			CodeNm = codeService.getCodeNm("MAT_TYPE", p.getMatType(), null);
			p.setMatTypeNm(CodeNm);
			
			CodeNm = codeService.getCodeNm("PART_TYPE", p.getPartType(), null);
			p.setPartTypeNm(CodeNm);
			
			CodeNm = codeService.getCodeNm("SUPPLIER_CODE", p.getSupplierCode(), null);
			p.setSupplierNm(CodeNm);
			
			p.setStr(p.getPackagingNm() + "_" + p.getMatTypeNm() + "_" + p.getPartTypeNm() + "_" + p.getSupplierNm());
*/	
			
           productMapper.insertProductPackaging(p);
        }
        
        ProdPackagingMatModel prodPackagingMatModel = new ProdPackagingMatModel();
        prodPackagingMatModel.setProductCode(applyProductCode);
        //------------------------prodPackagingMatModel.setPackagingOrder("1"); 
		List<ProdPackagingMatModel> prodPackagingMatList = productMapper.selectProductSelfPackaging(prodPackagingMatModel);
		for(ProdPackagingMatModel pM : prodPackagingMatList) {
			pM.setPackagingMatId(idUtil.getPackagingMatId()); 
			//------------pM.setProductId(productId);
			//-----------------pM.setPackagingOrder( Integer.toString(maxPartProductPackagingOrder + 1) );
			productMapper.insertProductSelfPackaging(pM);
		}
       
		return prodPackagingList;
	}		
	
	
	public int selectMaxProductPackagingOrder(String productId) {
		
		return productMapper.selectMaxProductPackagingOrder(productId);
	}		
	
	public int selectMaxPartProductPackagingOrder(String productId) {
		
		return productMapper.selectMaxPartProductPackagingOrder(productId);
	}
	

	public String getProductNm(String productCoded) {
		return productMapper.getProductNm(productCoded);
	}		
	
	public int selectCountSameProductCode(ProductModel productModel) {
		return productMapper.selectCountSameProductCode(productModel);
	}

	public List<ProdPackagingMatModel>  selectProductSelfPackaging(ProdPackagingMatModel prodPackagingMatModel) {
		return productMapper.selectProductSelfPackaging(prodPackagingMatModel);
	}
	
	@Transactional
	public String insertProductSelfPackaging(ProdPackagingMatModel prodPackagingMatModel) {
		long count = productMapper.insertProductSelfPackaging(prodPackagingMatModel);
		
		if (count > 0) {
			return Constant.DB.INSERT;
		} else {
			return Constant.DB.FAIL;
		}
	}
	
	@Transactional
	public String deleteProductSelfPackaging(ProdPackagingMatModel prodPackagingMatModel) {
		long count = productMapper.deleteProductSelfPackaging(prodPackagingMatModel);
		if (count > 0) {
			return Constant.DB.DELETE;
		} else {
			return Constant.DB.FAIL;
		}
	}
	
	
	public String throwError(String val) {
		if(!"정상".equals(val)) {
			return "에러";
		}
		return "정상";
	}

	public List<ProductModel> selectSubProductList(ProductModel productModel) {
		return productMapper.selectSubProductList(productModel);
	}
	
	
}
