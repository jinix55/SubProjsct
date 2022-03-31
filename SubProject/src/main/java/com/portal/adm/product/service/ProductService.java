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
    
    /**
	 * 상품관리 목록을 조회한다.
	 *
	 * @param criteria 페이징 모델
	 * @return
	 */
    public List<ProductModel> selectProductList(ProductModel productModel) {
    	List<ProductModel> productList = productMapper.selectProductList(productModel);
    	for(ProductModel p : productList) {
    		
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
			
			p.setStr(p.getPackagingNm() + p.getMatTypeNm() + p.getPartTypeNm() + p.getSupplierNm());
		}
		
		
		System.out.println("prodPackagingList " + prodPackagingList);
		
		//
		
 
		 

		//ProdPackagingList.add(prodPackagingModel);
		
		//outProductModel.setProdPackagingList(ProdPackagingList);
		
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
		
		ProdPackagingModel prodPackagingModel = new ProdPackagingModel();
		prodPackagingModel.setProductId( this.getProductId(productModel.getApplyProductCode()) );
		
		prodPackagingList = productMapper.selectProductPackagingListByProductId(prodPackagingModel);
		String CodeNm = "";
        for(ProdPackagingModel p : prodPackagingList) {
           p.setPackagingId(idUtil.getPackagingId());        	
           p.setPackagingId(productModel.getProductCode());
           
			CodeNm = codeService.getCodeNm("MAT_TYPE", p.getMatType(), null);
			p.setMatTypeNm(CodeNm);
			
			CodeNm = codeService.getCodeNm("PART_TYPE", p.getPartType(), null);
			p.setPartTypeNm(CodeNm);
			
			CodeNm = codeService.getCodeNm("SUPPLIER_CODE", p.getSupplierCode(), null);
			p.setSupplierNm(CodeNm);
			
			p.setStr(p.getPackagingNm() + p.getMatTypeNm() + p.getPartTypeNm() + p.getSupplierNm());
			
           productMapper.insertProductPackaging(p);
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

	public String throwError(String val) {
		if(!"정상".equals(val)) {
			return "에러";
		}
		return "정상";
	}
	
	
}
