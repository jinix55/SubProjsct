package com.portal.adm.product.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.adm.code.model.CodeModel;
import com.portal.adm.code.service.CodeService;
import com.portal.adm.packagingCode.model.PackagingCodeModel;
import com.portal.adm.product.mapper.ProductMapper;
import com.portal.adm.product.model.ProdPackagingMatModel;
import com.portal.adm.product.model.ProdPackagingModel;
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
    	for(ProductModel p : productList) {
    		
    		//p.setCompleteStatus(codeService.getCodeNm(constant._CODE_, p.getMasterApply(),constant._MAPPING_STAT_CODE_));
    		p.setMasterApplyNm(codeService.getCodeNm("_CODE_", p.getMasterApply(), "ENVIRONMENT_PROCEED_STAT_CODE"));
    		
    		prodPackagingModel.setProductId(p.getProductId());
    		prodPackagingList = productMapper.selectProductPackagingListByProductId(prodPackagingModel);
    		for(ProdPackagingModel pp : prodPackagingList) {
    			p.setPackingType(codeService.getCodeNm("MAT_TYPE", pp.getMatType(), null));
    			break;
    		}
    	}
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
		ProductModel outProductModel = new ProductModel();
		ProductModel productRecyleContributionsModel = new ProductModel();
		outProductModel = productMapper.selectProduct(productModel);

		int year = Calendar.getInstance().get(Calendar.YEAR);
		for(int i = 1; i <= 3; i++) {
			productModel.setInBaseYear( Integer.toString(year - i));
			
			productRecyleContributionsModel = new ProductModel();
			productRecyleContributionsModel = productMapper.selectProductRecyleContributions(productModel);
			
            switch (i) {
	            case 1:
	            	outProductModel.setBaseYear(Integer.toString(year - i));
	            	if(productRecyleContributionsModel != null) {
	            		outProductModel.setAccumulateSaleQty(productRecyleContributionsModel.getAccumulateSaleQty());
	            		outProductModel.setPackingTotalWeight(productRecyleContributionsModel.getPackingTotalWeight());
	            		outProductModel.setRecyleContributions(productRecyleContributionsModel.getRecyleContributions());
	            	}
	                break;
	            case 2:
	            	outProductModel.setBaseYear_1(Integer.toString(year - i));
	            	if(productRecyleContributionsModel != null) {
	            		outProductModel.setAccumulateSaleQty_1(productRecyleContributionsModel.getAccumulateSaleQty());
	            		outProductModel.setPackingTotalWeight_1(productRecyleContributionsModel.getPackingTotalWeight());
	            		outProductModel.setRecyleContributions_1(productRecyleContributionsModel.getRecyleContributions());
	            	}
	                break;            	
	            case 3:
	            	outProductModel.setBaseYear_2(Integer.toString(year - i));
	            	if(productRecyleContributionsModel != null) {
	            		outProductModel.setAccumulateSaleQty_2(productRecyleContributionsModel.getAccumulateSaleQty());
	            		outProductModel.setPackingTotalWeight_2(productRecyleContributionsModel.getPackingTotalWeight());
	            		outProductModel.setRecyleContributions_2(productRecyleContributionsModel.getRecyleContributions());
	            	}
	                break;            	
            }
		}
		
		
		System.out.println("outProductModel.getProductId() " + outProductModel.getProductId());
		
		
		ProdPackagingModel prodPackagingModel = new ProdPackagingModel();
		prodPackagingModel.setProductId(outProductModel.getProductId());

		List<ProdPackagingModel> prodPackagingList = productMapper.selectProductPackagingListByProductId(prodPackagingModel);
		String CodeNm = "";
		for (ProdPackagingModel p :  prodPackagingList) {
			CodeNm = codeService.getCodeNm("MAT_TYPE", p.getMatType(), null);
			p.setMatTypeNm(CodeNm);
			
			CodeNm = codeService.getCodeNm("PART_TYPE", p.getPartType(), null);
			p.setPartTypeNm(CodeNm);
			
			CodeNm = codeService.getCodeNm("SUPPLIER_CODE", p.getSupplierCode(), null);
			p.setSupplierNm(CodeNm);
			
			p.setStr(p.getPackagingNm() + "_" + p.getMatTypeNm() + "_" + p.getPartTypeNm() + "_" + p.getSupplierNm());
		}
		
		
		System.out.println("prodPackagingList " + prodPackagingList);
		
		//
		
 
		 

		//ProdPackagingList.add(prodPackagingModel);
		
		outProductModel.setProdPackagingList(prodPackagingList);
		
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
		
		int year = Calendar.getInstance().get(Calendar.YEAR);
		ProductModel productRecyleContributionsModel = new ProductModel();
		for(int i = 1; i <= 3; i++) {
			
			productRecyleContributionsModel = new ProductModel();
			productRecyleContributionsModel.setProductId(productModel.getProductId());
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
	public List<PackagingCodeModel> selectProductMatType() {
        return productMapper.selectProductMatType();
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

	public ProductModel mapping(ProductModel productModel) {
		String producId = this.getProductId(productModel.getProductCode());
		
		ProdPackagingModel prodPackagingModel = new ProdPackagingModel();
		
		List<ProdPackagingModel> prodPackagingList =  productMapper.selectProductPackagingDetailWithoutProductId(prodPackagingModel);
		for(ProdPackagingModel p : prodPackagingList) {
			
		}
		
		ProductModel outProductModel = new ProductModel();
		
		outProductModel.setMasterApply("COMPLETION");
		outProductModel.setReceiptNumber("ReceiptNumber");
		outProductModel.setApprovalNumber("ApprovalNumber");
		
		outProductModel.setMasterMapping("MAPPING");
		outProductModel.setMappingProductCode("MappingProductCode");
		outProductModel.setMappingProductNm("MappingProductNm");
		
		
		return outProductModel;
	}	

	

	public List<ProdPackagingModel>  apply(ProductModel productModel) {
		List<ProdPackagingModel>  prodPackagingList = new ArrayList<>() ;
		
		String productId =  this.getProductId(productModel.getProductCode());
		String applyProductId =  this.getProductId(productModel.getApplyProductCode());
	
		ProdPackagingModel prodPackagingModel = new ProdPackagingModel();
		prodPackagingModel.setProductId(applyProductId);
		prodPackagingList = productMapper.selectProductPackagingListByProductId(prodPackagingModel);
		
		int maxPartProductPackagingOrder = productMapper.selectMaxPartProductPackagingOrder(productId);
		String CodeNm = "";
        for(ProdPackagingModel p : prodPackagingList) {
           p.setPackagingId(idUtil.getPackagingId());        	
           p.setProductId(productId);
           p.setPackagingOrder(maxPartProductPackagingOrder + 1);
           
			CodeNm = codeService.getCodeNm("MAT_TYPE", p.getMatType(), null);
			p.setMatTypeNm(CodeNm);
			
			CodeNm = codeService.getCodeNm("PART_TYPE", p.getPartType(), null);
			p.setPartTypeNm(CodeNm);
			
			CodeNm = codeService.getCodeNm("SUPPLIER_CODE", p.getSupplierCode(), null);
			p.setSupplierNm(CodeNm);
			
			p.setStr(p.getPackagingNm() + "_" + p.getMatTypeNm() + "_" + p.getPartTypeNm() + "_" + p.getSupplierNm());
			
           productMapper.insertProductPackaging(p);
        }
        
        ProdPackagingMatModel prodPackagingMatModel = new ProdPackagingMatModel();
        prodPackagingMatModel.setProductId(applyProductId);
        prodPackagingMatModel.setPackagingOrder("1"); 
		List<ProdPackagingMatModel> prodPackagingMatList = productMapper.selectProductSelfPackaging(prodPackagingMatModel);
		for(ProdPackagingMatModel pM : prodPackagingMatList) {
			pM.setPackagingMatId(idUtil.getPackagingMatId()); 
			pM.setProductId(productId);
			pM.setPackagingOrder( Integer.toString(maxPartProductPackagingOrder + 1) );
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
	
	
	public String getProductId(String productCoded) {
		return productMapper.getProductId(productCoded);
	}	
	
	public int selectProductListCountByProductCode(String productCoded) {
		return productMapper.selectProductListCountByProductCode(productCoded);
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
	
	
}
