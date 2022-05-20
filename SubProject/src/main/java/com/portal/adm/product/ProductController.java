package com.portal.adm.product;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.portal.adm.environPrice.model.EnvironPriceModel;
import com.portal.adm.environmentCode.model.EnvironmentCodeModel;
import com.portal.adm.environmentCode.service.EnvironmentCodeService;
import com.portal.adm.file.model.FileModel;
import com.portal.adm.file.service.FileService;
import com.portal.adm.member.model.MemberModel;
import com.portal.adm.member.service.MemberService;
import com.portal.adm.product.model.ProdPartModel;
import com.portal.adm.product.model.ProdPackagingDetailModel;
import com.portal.adm.product.model.ProdPackagingMatModel;
import com.portal.adm.product.model.ProdPackagingModel;
import com.portal.adm.product.model.ProdSelfPackagingModel;
import com.portal.adm.product.model.ProductGroupFileModel;
import com.portal.adm.product.model.ProductModel;
import com.portal.adm.product.service.ProductGroupFileService;
import com.portal.adm.product.service.ProductService;
import com.portal.adm.supplier.model.SupplierModel;
import com.portal.adm.supplier.service.SupplierService;
import com.portal.common.IdUtil;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 상품관리 / 상품 컨트롤러
 */
@Slf4j
@RequestMapping("/product")
@Controller
public class ProductController {

    @Resource
    private ProductService productService;
    
    @Resource
	private SupplierService supplierService;
    
	@Resource
    private MemberService memberService;
	
    @Resource
    private IdUtil idUtil;
    
    @Resource
    private ProductGroupFileService productGroupFileService;
    
    @Resource(name="fileService")
	private FileService fileService;
    
    
    @Resource
    private EnvironmentCodeService environmentCodeService;
    
    /**
     * 상품 페이지로 이동
     *
     * @param model
     * @return
     */
    @RequestMapping(value="/prodList", method= {RequestMethod.GET,RequestMethod.POST})
    public String product(@ModelAttribute ProductModel productModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	// 상품 목록 조회
    	List<ProductModel> models = productService.selectProductList(productModel);
    	
    	System.out.println("models " + models);
    	
    	productModel.setTotalCount(productService.selectProductListCount(productModel));
        model.addAttribute("products", models);
        model.addAttribute("pages", productModel);
    	
        
//		<if test="searchKey != '' and searchKey == 'ALL' and searchValue != ''">
//		and (upper(PRODUCT_NM) like concat('%',upper(#{searchValue}),'%') or upper(PACKING_TYPE) like concat('%',upper(#{searchValue}),'%') or (upper(RECYCLE_GRADE) like concat('%',upper(#{searchValue}),'%')))
//	</if>
    	
    	//재질 정보 조회
//    	List<PackagingCodeModel> productMatType = productService.selectProductMatType();
    	EnvironmentCodeModel environmentCodeModel = new EnvironmentCodeModel();
    	environmentCodeModel.setGroupId("GROUP_ID");
    	environmentCodeModel.setRevisionYear("2022");
    	environmentCodeModel.setRevisionMonth("03");
//    	if(environmentCodeModel.getRevision() != null && !StringUtils.equals(environmentCodeModel.getRevision(), "")) {
//    		String[] revision = environmentCodeModel.getRevision().split("-");
//    	}
    	List<EnvironmentCodeModel> productMatType = environmentCodeService.selectList(environmentCodeModel);
    	model.addAttribute("productMatTypeList", productMatType);  
    	
    	//공급업체 정보 조회
    	SupplierModel supplierModel = new SupplierModel();
    	supplierModel.setAuthId(authUser.getMemberModel().getAuthId());
    	supplierModel.setOffSet(0);
    	supplierModel.setPageSize(9999);
        List<SupplierModel> supplierList = supplierService.selectSupplierList(supplierModel);
        model.addAttribute("suppliers", supplierList);
        
        
        return "product/prodList";
    }

    /**
     * 상품 상세정보를 조회한다.
     *
     * @param productId
     * @return
     */
    @RequestMapping(value="/detail", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<ProductModel> selectProduct(@ModelAttribute ProductModel productModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
//    public ResponseEntity<ProductModel> selectProduct(@RequestBody ProductModel productModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	//상품 상세정보 조회
    	System.out.println("productModel" + productModel.getProductCode());
    	ProductModel product = productService.selectProduct(productModel);
    	System.out.println("product" + product);
        return new ResponseEntity<>(product, HttpStatus.OK);
    }
    
    /**
     * 상품을 저장한다.
     *
     * @param request
     * @return
     */
    //@RequestMapping(value="/insert" , method= {RequestMethod.GET,RequestMethod.POST}, produces=MediaType.APPLICATION_JSON_VALUE)
    @RequestMapping(value="/insert" , method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<String> saveProduct(HttpServletRequest request, @ModelAttribute ProductModel productModel,@AuthenticationPrincipal AuthUser authUser, @RequestParam("photos") MultipartFile[] photos, @RequestParam("specs") MultipartFile[] specs) {
//    public ResponseEntity<String> insertProduct(@RequestBody ProductModel productModel, @AuthenticationPrincipal AuthUser authUser) {
    	System.out.println("productModel" + productModel.getProductCode());
        if(productService.selectProductListCountByProductCode(productModel.getProductCode()) > 0) {
        	return ResponseEntity.badRequest().body("동일한 상품코드로 등록된 상품이 있습니다.");
        }
        
        if(productModel.getProductNm() == null || productModel.getProductNm().trim().equals("")) {
        	return ResponseEntity.badRequest().body("상품명이 누락 되었습니다");
        }
        
        try {
        	String result = "success";
        	productModel.setRgstId(authUser.getMemberModel().getUserId());
    		productModel.setModiId(authUser.getMemberModel().getUserId());
        	String photoGfileId = productGroupFileService.saveProuductGroupFile(productModel, photos, "");
	        productModel.setPhotoGfileId(photoGfileId);
	        String specGfileId = productGroupFileService.saveProuductGroupFile(productModel, specs, "");
	        productModel.setSpecGfileId(specGfileId);
	        
	        result = productService.insertProduct(productModel);
	
	        return new ResponseEntity<>(result, HttpStatus.OK);
	    } catch (Exception e) {
	    	return ResponseEntity.badRequest().body(e.getMessage());
	    }
        /**
		productModel.setRgstId(authUser.getMemberModel().getUserId());
		productModel.setModiId(authUser.getMemberModel().getUserId());
		String result = productService.insertProduct(productModel);
        return new ResponseEntity<>(result, HttpStatus.OK);
        **/
    }
    
    //@RequestMapping(value="/update" , method= {RequestMethod.GET,RequestMethod.POST}, produces=MediaType.APPLICATION_JSON_VALUE)
    @RequestMapping(value="/update" , method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<String> updateProduct(HttpServletRequest request, @ModelAttribute ProductModel productModel, @AuthenticationPrincipal AuthUser authUser , @RequestParam("photos") MultipartFile[] photos  , @RequestParam("specs") MultipartFile[] specs) {
//    public ResponseEntity<String> updateProduct(@RequestBody ProductModel productModel, @AuthenticationPrincipal AuthUser authUser) {
    	
    	if((productModel.getMasterApplyCode().equals("UNPROCEED")) || (productModel.getMasterApplyCode().equals("EXCEPT"))) { //미진행
    		if(!(productModel.getReceiptNo() == null || productModel.getReceiptNo().trim().equals(""))) {
    			return ResponseEntity.badRequest().body("접수번호를 등록 할수 없습니다.");	
    		}
    		
    		if(!(productModel.getApprovalNo() == null || productModel.getApprovalNo().trim().equals(""))) {
    			return ResponseEntity.badRequest().body("승인번호를 등록 할수 없습니다.");	
    		}

    		if(!(productModel.getMappingProductCode() == null || productModel.getMappingProductCode().trim().equals(""))) {
    			return ResponseEntity.badRequest().body("매핑상품코드를 등록 할수 없습니다.");	
    		}
    	}
    	
    	
    	if(productModel.getMasterApplyCode().equals("PROCEEDING")) { //진행중
    		if(productModel.getReceiptNo() == null || productModel.getReceiptNo().trim().equals("")) {
    			return ResponseEntity.badRequest().body("접수번호가 누락 되었습니다.");	
    		}
    		
    		if(!(productModel.getApprovalNo() == null || productModel.getApprovalNo().trim().equals(""))) {
    			return ResponseEntity.badRequest().body("승인번호를 등록 할수 없습니다.");	
    		}

    		if(!(productModel.getMappingProductCode() == null || productModel.getMappingProductCode().trim().equals(""))) {
    			return ResponseEntity.badRequest().body("매핑상품코드를 등록 할수 없습니다.");	
    		}
    	}
    	
    	if(productModel.getMasterApplyCode().equals("COMPLETION")) { //완료
    		if(productModel.getApprovalNo() == null || productModel.getApprovalNo().trim().equals("")) {
    			return ResponseEntity.badRequest().body("승인번호가가 누락 되었습니다.");	
    		}

    	}
    	
    	
    	if(productModel.getMasterMappingCode().equals("UNMAPPING")) { //매핑전
    	   productModel.setMappingProductCode(""); 
    	}    	
    	
    	try {
        	String result = "success";
        	productModel.setModiId(authUser.getMemberModel().getUserId());
        	String photoGfileId = productGroupFileService.saveProuductGroupFile(productModel, photos, productModel.getPhotoGfileId());
	        productModel.setPhotoGfileId(photoGfileId);
	        String specGfileId = productGroupFileService.saveProuductGroupFile(productModel, specs, productModel.getSpecGfileId());
	        productModel.setSpecGfileId(specGfileId);
	        
	        productModel.setModiId(authUser.getMemberModel().getUserId());
			result = productService.updateProduct(productModel);
	        return new ResponseEntity<>(result, HttpStatus.OK);
	    } catch (Exception e) {
	    	return ResponseEntity.badRequest().body(e.getMessage());
	    }
    	
    	/**
		productModel.setModiId(authUser.getMemberModel().getUserId());
		String result = productService.updateProduct(productModel);
        return new ResponseEntity<>(result, HttpStatus.OK);
        **/
    }
    
    /**
     * 상품을 삭제한다.  UseYn = N
     *
     * @param request
     * @return
     */
    @PostMapping("/delete")
    //public ResponseEntity<String> productDelete(@ModelAttribute ProductModel productModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    public ResponseEntity<String> productDelete(@RequestBody ProductModel productModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {	
        try {            
            productModel.setModiId(authUser.getMemberModel().getUserId());
            String result = productService.deleteProduct(productModel);
            
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
        	return ResponseEntity.badRequest().body(e.getMessage());
        }
    }    
    
    /**
	 * Product File list 조회
	 * @param request
	 * @param multipart
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/detail/file/list/{gfileId}", method=RequestMethod.GET)
	public ResponseEntity<List<FileModel>> selectList(HttpServletRequest request, @PathVariable String gfileId, @AuthenticationPrincipal AuthUser authUser) {
		//파일 조회
		List<FileModel> fileList = new ArrayList<>();
		ProductGroupFileModel productGroupFileModel = new ProductGroupFileModel();
		productGroupFileModel.setGfileId(gfileId);
		List<ProductGroupFileModel> groupFileList = productGroupFileService.selectProductGroupFileListByGfileId(productGroupFileModel);
		for(ProductGroupFileModel gfile: groupFileList) {
			FileModel f = new FileModel();
			f.setFileId(gfile.getFileId());
			f = fileService.selectFile(f);
			fileList.add(f);
		}
		return new ResponseEntity<>(fileList, HttpStatus.OK);
	}

    /**
	 * File delete
	 * @param request
	 * @param multipart
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/detail/file/delete/{uuid}", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_VALUE)
	public Map<String,Object> delete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser, @PathVariable String uuid) {
		//product group 에서 삭제
		ProductGroupFileModel productGroupFileModel = new ProductGroupFileModel();
		productGroupFileModel.setFileId(uuid);
		productGroupFileModel.setModiId(authUser.getMemberModel().getUserId());
		productGroupFileService.deleteProduct(productGroupFileModel);
		
		//첨부 파일에서 삭제
		//Map<String,Object> result = null;
		Map<String,Object> result = new HashMap<String, Object>();
		FileModel fileModel = new FileModel();
		fileModel.setFileId(uuid);
		fileModel = fileService.selectFile(fileModel);
//		fileModel.setFileUrl(uuid);
		fileModel.setUseYn("N");
		fileModel.setModiId(authUser.getMemberModel().getUserId());
		long cnt = fileService.deleteFile(fileModel);

		result.put("cnt", cnt);
		return result;
	}
    
    @RequestMapping(value="/detail/selectProductPackaging", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    //public ResponseEntity<List<ProdPackagingModel>> selectProductPackaging(@ModelAttribute ProdPackagingModel productPackagingModel) {
    public ResponseEntity<List<ProdPackagingModel>> selectProductPackaging(@RequestBody ProdPackagingModel productPackagingModel) {
    	// 상품 목록 조회
        System.out.println("productPackagingModel " + productPackagingModel );       
    	List<ProdPackagingModel> prodPackagingModelList = productService.selectProductPackaging(productPackagingModel);
        return new ResponseEntity<>(prodPackagingModelList, HttpStatus.OK);
    }    
    
	
    /**
     * 상품포장정보을 삭제한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/delete/productPackaging")
    //public ResponseEntity<String> deleteProductPackaging(@ModelAttribute ProdPackagingModel prodPackagingModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    public ResponseEntity<String> deleteProductPackaging(@RequestBody ProdPackagingModel prodPackagingModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {            
        	prodPackagingModel.setModiId(authUser.getMemberModel().getUserId());
            String result = productService.deleteProductPackaging(prodPackagingModel);
            
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
        	return ResponseEntity.badRequest().body(e.getMessage());
        }
    }     

    
    @RequestMapping(value="/detail/packagingOrder", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<List<ProdPackagingModel>> selectProductPackagingOrder(ProdPackagingModel prodPackagingModel) {
    	// 상품 포장 차수 조회
    	List<ProdPackagingModel> packagingOrder = productService.selectProductPackagingOrder(prodPackagingModel);
    	
    	
    	
    	/*
    	for( int i = 0 ; i < packagingOrder.size() ; i++) {
    		EnvironmentCodeModel environmentCode = new EnvironmentCodeModel();
        	environmentCode.setCodeId(packagingOrder.get(i).getMatType().split("_")[0]);
        	environmentCode.setGroupId("GROUP_ID");
        	environmentCode.setRevisionYear("2022");
        	environmentCode.setRevisionMonth("03");
        	
        	EnvironmentCodeModel detailCodeList = environmentCodeService.select(environmentCode);
        	if(detailCodeList != null) {
        		packagingOrder.get(i).setMatTypeNm(detailCodeList.getCodeNm());
        	}
        }
    	*/
        return new ResponseEntity<>(packagingOrder, HttpStatus.OK);
    }
    
    
    @RequestMapping(value="/detail/selectProductMatTypeList", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<List<EnvironPriceModel>> selectProductMatTypeList() {
    	// 포창차수 등록시 재질 조회
    	List<EnvironPriceModel> environPriceModelList = productService.selectProductMatTypeList();
    	
        return new ResponseEntity<>(environPriceModelList, HttpStatus.OK);
    }
    
    
    /**
     * 상품포장정보을 저장한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/insert/productPackaging")
    //public ResponseEntity<ProdPackagingModel> insertProductPackaging(HttpServletRequest request, @ModelAttribute ProdPackagingModel prodPackagingModel,@AuthenticationPrincipal AuthUser authUser) {
    public ResponseEntity<String> insertProductPackaging(HttpServletRequest request, @RequestBody ProdPackagingModel prodPackagingModel,@AuthenticationPrincipal AuthUser authUser) {
    	try {
			prodPackagingModel.setRgstId(authUser.getMemberModel().getUserId());
			prodPackagingModel.setModiId(authUser.getMemberModel().getUserId());
			prodPackagingModel.setPackagingId(idUtil.getPackagingId());
			String result = productService.insertProductPackaging(prodPackagingModel);
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
        	return ResponseEntity.badRequest().body(e.getMessage());
        }
    }    
    
    
    /**
     * 상품포장정보을 저장한다.
     *
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/detail/selectProdPartList")
    public ResponseEntity<List<ProdPartModel>> selectProdPartList(HttpServletRequest request, @RequestBody ProdPartModel prodPartModel,@AuthenticationPrincipal AuthUser authUser) {
		List<ProdPartModel> prodPartList = productService.selectProdPartList(prodPartModel);
	    return new ResponseEntity<>(prodPartList, HttpStatus.OK);
    }    
    
    /**
     * 상품포장 재질 정보 상세정보를 조회한다.
     *
     * @param productId
     * @return
     */
    @RequestMapping(value="/detail/selectProdPackagingDetailList", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<List<ProdPackagingDetailModel>> selectProdPackagingDetailList(@RequestBody ProdPackagingDetailModel prodPackagingDetailModel) {
    	System.out.println("ProdPackagingDetailModel " + prodPackagingDetailModel );   
		List<ProdPackagingDetailModel> prodPackagingDetailList = productService.selectProdPackagingDetailList(prodPackagingDetailModel);
	    return new ResponseEntity<>(prodPackagingDetailList, HttpStatus.OK);
    }
    
    @RequestMapping(value="/detail/selectProdPackagingDetail", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<ProdPackagingDetailModel> selectProdPackagingDetail(@RequestBody ProdPackagingDetailModel prodPackagingDetailModel) {
   
		ProdPackagingDetailModel outModel = productService.selectProdPackagingDetail(prodPackagingDetailModel);
	    return new ResponseEntity<>(outModel, HttpStatus.OK);
    }
    
    @RequestMapping(value="/delete/prodPackagingDetail", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<String> delectProdPackagingDetail(@RequestBody ProdPackagingDetailModel prodPackagingDetailModel,@AuthenticationPrincipal AuthUser authUser ) {
    	prodPackagingDetailModel.setModiId(authUser.getMemberModel().getUserId());
		String result  = productService.delectProdPackagingDetail(prodPackagingDetailModel);
	    return new ResponseEntity<>(result, HttpStatus.OK);
    }    
    
    @RequestMapping(value="/insert/prodPackagingDetail", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<String> insertProdPackagingDetail(@RequestBody ProdPackagingDetailModel prodPackagingDetailModel,@AuthenticationPrincipal AuthUser authUser ) {
    	prodPackagingDetailModel.setModiId(authUser.getMemberModel().getUserId());
    	prodPackagingDetailModel.setRgstId(authUser.getMemberModel().getUserId());
    	prodPackagingDetailModel.setPackagingDetailId(idUtil.getPackagingDetailId());
		String result  = productService.insertProdPackagingDetail(prodPackagingDetailModel);
	    return new ResponseEntity<>(result, HttpStatus.OK);
    }     
    
    @RequestMapping(value="/update/prodPackagingDetail", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<String> updateProdPackagingDetail(@RequestBody ProdPackagingDetailModel prodPackagingDetailModel,@AuthenticationPrincipal AuthUser authUser ) {
    	prodPackagingDetailModel.setModiId(authUser.getMemberModel().getUserId());
    	prodPackagingDetailModel.setRgstId(authUser.getMemberModel().getUserId());
		String result  = productService.updateProdPackagingDetail(prodPackagingDetailModel);
	    return new ResponseEntity<>(result, HttpStatus.OK);
    }      
    //################################################################################################################################
    //################################################################################################################################
    //################################################################################################################################


    

    
//    @PostMapping("/update/{productId}/packaging")
//    public ResponseEntity<ProdPackagingModel> updateProductPackaging(HttpServletRequest request, @PathVariable("productId") String productId,
//                                       @ModelAttribute ProdPackagingModel prodPackagingModel,
//                                       @AuthenticationPrincipal AuthUser authUser) {
//    	
//    	/*
//
//        try {
//        	prodPackagingModel.setModiId(authUser.getMemberModel().getUserId());
//        	prodPackagingModel.setProductNm("상품1");
//			prodPackagingModel.setPackagingNm("1차포장");
//			int x= prodPackagingModel.getManagerId().indexOf("||");
//			String managerId = prodPackagingModel.getManagerId().substring(0, x);
//        	prodPackagingModel.setManagerId(managerId);
//            productService.updateProductPackaging(prodPackagingModel);
//
//            return new ResponseEntity<>(prodPackagingModel, HttpStatus.OK);
//        } catch (Exception e) {
//        	return ResponseEntity.badRequest().body(new ProdPackagingModel());
//        }
//        
//        */
//    }
    

    
    /**
     * 상품자가진단 정보 조회한다.
     *
     * @param request
     * @return
     */
    @RequestMapping(value="/detail/selfPackaging", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<ProdSelfPackagingModel> selectProductSelfPackaging(@ModelAttribute EnvironmentCodeModel environmentCodeModel, @ModelAttribute ProdPackagingMatModel prodPackagingMatModel) {
    	List<EnvironmentCodeModel> middleModels = new ArrayList<EnvironmentCodeModel>();
    	List<EnvironmentCodeModel> smallModels = new ArrayList<EnvironmentCodeModel>();
    	List<EnvironmentCodeModel> lastModels = new ArrayList<EnvironmentCodeModel>();
    	ProdSelfPackagingModel prodSelfPackagingModel = new ProdSelfPackagingModel();
    	
    	middleModels = environmentCodeService.selectGroupIdList(environmentCodeModel);
    	prodSelfPackagingModel.setMiddleModels(middleModels);
    	
    	
    	ArrayList<FileModel> files = new ArrayList<FileModel>();
    	ArrayList<EnvironmentCodeModel> list = new ArrayList<EnvironmentCodeModel>();
    	for(EnvironmentCodeModel m : middleModels) {
    		environmentCodeModel.setGroupId(m.getCodeId());
    		smallModels = environmentCodeService.selectGroupIdList(environmentCodeModel);
    		list.addAll(smallModels);
/*    		
    		String rptMatStruct = "rptMatStruct-"+m.getCodeId()+"_"+prodPackagingMatModel.getProductId()+prodPackagingMatModel.getPackagingOrder();
        	String rptDevAnal = "rptDevAnal-"+m.getCodeId()+"_"+prodPackagingMatModel.getProductId()+prodPackagingMatModel.getPackagingOrder();
        	String rptVisualJudg = "rptVisualJudg-"+m.getCodeId()+"_"+prodPackagingMatModel.getProductId()+prodPackagingMatModel.getPackagingOrder();
        	String rptTest = "rptTest-"+m.getCodeId()+"_"+prodPackagingMatModel.getProductId()+prodPackagingMatModel.getPackagingOrder();
        	String rptPermission = "rptPermission-"+m.getCodeId()+"_"+prodPackagingMatModel.getProductId()+prodPackagingMatModel.getPackagingOrder();
        	String rptEtc = "rptEtc-"+m.getCodeId()+"_"+prodPackagingMatModel.getProductId()+prodPackagingMatModel.getPackagingOrder();

        	FileModel f = new FileModel();
    		
        	f.setRefId(rptMatStruct);    
    		List<FileModel> rptMatStructFileList = fileService.selectFileList(f);
    		if(rptMatStructFileList !=null && rptMatStructFileList.size() > 0) {
    			files.add(rptMatStructFileList.get(0));
    		}
    		
    		f.setRefId(rptDevAnal);    
    		List<FileModel> rptDevAnalFileList = fileService.selectFileList(f);
    		if(rptDevAnalFileList !=null && rptDevAnalFileList.size() > 0) {
    			files.add(rptDevAnalFileList.get(0));
    		}
    		
    		f.setRefId(rptVisualJudg);    
    		List<FileModel> rptVisualJudgFileList = fileService.selectFileList(f);
    		if(rptVisualJudgFileList !=null && rptVisualJudgFileList.size() > 0) {
    			files.add(rptVisualJudgFileList.get(0));
    		}
    		
    		f.setRefId(rptTest);    
    		List<FileModel>rptTestFileList = fileService.selectFileList(f);
    		if(rptTestFileList !=null && rptTestFileList.size() > 0) {
    			files.add(rptTestFileList.get(0));
    		}
    		
    		f.setRefId(rptPermission);    
    		List<FileModel> rptPermissionFileList = fileService.selectFileList(f);
    		if(rptPermissionFileList !=null && rptPermissionFileList.size() > 0) {
    			files.add(rptPermissionFileList.get(0));
    		}
    		
    		f.setRefId(rptEtc);    
    		List<FileModel> rptEtcFileList = fileService.selectFileList(f);
    		if(rptEtcFileList !=null && rptEtcFileList.size() > 0) {
    			files.add(rptEtcFileList.get(0));
    		}
*/    		
    	}
    	
    	prodSelfPackagingModel.setFiles(files);
    	
    	Collections.sort(list,new Comparator<EnvironmentCodeModel>() {
			@Override
			public int compare(EnvironmentCodeModel o1, EnvironmentCodeModel o2) {
				return o1.getOrdSeq() - o2.getOrdSeq();
			}
		});
    	prodSelfPackagingModel.setSmallModels(list);
    	
    	List<ProdPackagingMatModel> selfPackagingModels = productService.selectProductSelfPackaging(prodPackagingMatModel);
    	ArrayList<EnvironmentCodeModel> lalist = new ArrayList<EnvironmentCodeModel>();
    	
    	for(EnvironmentCodeModel l :list) {
    		environmentCodeModel.setGroupId(l.getCodeId());
    		lastModels = environmentCodeService.selectGroupIdList(environmentCodeModel);
    		int count = 0;
    		for(EnvironmentCodeModel lastM :lastModels) {
    			for(ProdPackagingMatModel sm :selfPackagingModels) {
    				if(sm.getGroupId().equals(lastM.getGroupId()) && sm.getCodeId().equals(lastM.getCodeId())) {
    					lastModels.get(count).setStr("checked");
    					lastM.setStr("checked");
    					break;
    				}
    			}
    			if(lastM.getStr() == null) {
    				lastModels.get(count).setStr("");
    			}
    			count++;
    		}
    		lalist.addAll(lastModels);
    	}
    	prodSelfPackagingModel.setLastModels(lalist);
    	prodSelfPackagingModel.setSelfPackagingModels(selfPackagingModels);
    	
        return new ResponseEntity<>(prodSelfPackagingModel, HttpStatus.OK);
    }
    
    /**
     * 
     *
     * @param request
     * @return
     */
    @RequestMapping(value="/insert/selfPackaging" , method= {RequestMethod.GET,RequestMethod.POST}, produces=MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<ProdPackagingMatModel> saveSelfPackaging(HttpServletRequest request
    		, @AuthenticationPrincipal AuthUser authUser
    		, @ModelAttribute ProdPackagingMatModel prodPackagingMatModel
    		, MultipartRequest multipart
    		, @RequestParam(value = "checkbox_self", required = false) List<String> selfs
    		, @RequestParam(value = "chk_rptMatStruct", required = false)  List<String> rptMatStrucs
    		, @RequestParam(value = "chk_rptDevAnal", required = false)  List<String> rptDevAnals
    		, @RequestParam(value = "chk_rptVisualJudg", required = false)  List<String> rptVisualJudgs
    		, @RequestParam(value = "chk_rptTest", required = false)  List<String> rptTests
    		, @RequestParam(value = "chk_rptPermission", required = false)  List<String> rptPermissions
    		, @RequestParam(value = "chk_rptEtc", required = false)  List<String> rptEtcs) {
 
    	
/*-------------------------------------------------------------    	
    	
    	prodPackagingMatModel.setRgstId(authUser.getMemberModel().getUserId());
    	prodPackagingMatModel.setModiId(authUser.getMemberModel().getUserId());
		
     	
    	productService.deleteProductSelfPackaging(prodPackagingMatModel);
    	ProdPackagingModel productPackagingModel = new ProdPackagingModel();
    	productPackagingModel.setProductId(prodPackagingMatModel.getProductId());
    	productPackagingModel.setPackagingOrder(Integer.parseInt(prodPackagingMatModel.getPackagingOrder()));
    	List<ProdPackagingModel> models = productService.selectProductPackaging(productPackagingModel);
    	String bPackagingId = "";
    	String lPackagingId = "";
    	String gPackagingId = "";
    	for(ProdPackagingModel model : models) {
    		if(model.getPartType().contains("_B")) {
    			bPackagingId = model.getPackagingId();
    		}else if(model.getPartType().contains("_L")) {
    			lPackagingId = model.getPackagingId();
    		}else if(model.getPartType().contains("_G")) {
    			gPackagingId = model.getPackagingId();
    		}
    	}
    	
    	if(rptMatStrucs != null) {
	    	for(String rptMatStruc : rptMatStrucs) {
	    		prodPackagingMatModel.setGroupId(rptMatStruc.split("\\|\\|")[0]);
	    		prodPackagingMatModel.setCodeId(rptMatStruc.split("\\|\\|")[1]);
	    		prodPackagingMatModel.setFile("rptMatStruct_"+prodPackagingMatModel.getCodeId());
	    		prodPackagingMatModel.setPackagingMatId(idUtil.getPackagingMatId());
	    		productService.insertProductSelfPackaging(prodPackagingMatModel);
	    		
	    	}
    	}
    	
    	if(rptDevAnals != null) {
	    	for(String rptDevAnal : rptDevAnals) {
	    		prodPackagingMatModel.setGroupId(rptDevAnal.split("\\|\\|")[0]);
	    		prodPackagingMatModel.setCodeId(rptDevAnal.split("\\|\\|")[1]);
	    		prodPackagingMatModel.setPackagingId(bPackagingId);
	    		prodPackagingMatModel.setFile("rptDevAnal_"+prodPackagingMatModel.getCodeId());
	    		prodPackagingMatModel.setPackagingMatId(idUtil.getPackagingMatId());
	    		productService.insertProductSelfPackaging(prodPackagingMatModel);
	    		
	    	}
    	}
    	

    	if(rptVisualJudgs != null) {
	    	for(String rptVisualJudg : rptVisualJudgs) {
	    		prodPackagingMatModel.setGroupId(rptVisualJudg.split("\\|\\|")[0]);
	    		prodPackagingMatModel.setCodeId(rptVisualJudg.split("\\|\\|")[1]);
	    		prodPackagingMatModel.setFile("rptVisualJudg_"+prodPackagingMatModel.getCodeId());
	    		prodPackagingMatModel.setPackagingMatId(idUtil.getPackagingMatId());
	    		productService.insertProductSelfPackaging(prodPackagingMatModel);
	    		
	    	}
    	}

    	if(rptTests != null) {
	    	for(String rptTest : rptTests) {
	    		prodPackagingMatModel.setGroupId(rptTest.split("\\|\\|")[0]);
	    		prodPackagingMatModel.setCodeId(rptTest.split("\\|\\|")[1]);
	    		prodPackagingMatModel.setFile("rptTest_"+prodPackagingMatModel.getCodeId());
	    		prodPackagingMatModel.setPackagingMatId(idUtil.getPackagingMatId());
	    		productService.insertProductSelfPackaging(prodPackagingMatModel);
	    		
	    	}
    	}

    	if(rptPermissions != null) {
	    	for(String rptPermission : rptPermissions) {
	    		prodPackagingMatModel.setGroupId(rptPermission.split("\\|\\|")[0]);
	    		prodPackagingMatModel.setCodeId(rptPermission.split("\\|\\|")[1]);
	    		prodPackagingMatModel.setFile("rptPermission_"+prodPackagingMatModel.getCodeId());
	    		prodPackagingMatModel.setPackagingMatId(idUtil.getPackagingMatId());
	    		productService.insertProductSelfPackaging(prodPackagingMatModel);
	    		
	    	}
    	}
    	

    	if(rptEtcs != null) {
	    	for(String rptEtc : rptEtcs) {
	    		prodPackagingMatModel.setGroupId(rptEtc.split("\\|\\|")[0]);
	    		prodPackagingMatModel.setCodeId(rptEtc.split("\\|\\|")[1]);
	    		prodPackagingMatModel.setFile("rptEtc_"+prodPackagingMatModel.getCodeId());
	    		prodPackagingMatModel.setPackagingMatId(idUtil.getPackagingMatId());
	    		productService.insertProductSelfPackaging(prodPackagingMatModel);
	    		
	    	}
    	}
    	
    	prodPackagingMatModel.setFile(null);
    	
    	if(selfs != null) {
	    	for(String self : selfs) {
	    		prodPackagingMatModel.setGroupId(self.split("\\|\\|")[0]);
	    		prodPackagingMatModel.setCodeId(self.split("\\|\\|")[1]);
	    		if(self.split("\\|\\|")[1].contains("_B")) {
	    			prodPackagingMatModel.setPackagingId(bPackagingId);
	    		}else if(self.split("\\|\\|")[1].contains("_L")) {
	    			prodPackagingMatModel.setPackagingId(lPackagingId);
	    		}else if(self.split("\\|\\|")[1].contains("_G")) {
	    			prodPackagingMatModel.setPackagingId(gPackagingId);
	    		}
	    		prodPackagingMatModel.setPackagingId(bPackagingId);
	    		prodPackagingMatModel.setPackagingMatId(idUtil.getPackagingMatId());
	    		productService.insertProductSelfPackaging(prodPackagingMatModel);
	    		
	    	}
    	}
    	
    	//업데이터 패캐징 재활용등급
    	if(prodPackagingMatModel.getRecycleGrade() != null && !"".equals(prodPackagingMatModel.getRecycleGrade())  && "1".equals(prodPackagingMatModel.getPackagingOrder())) {
    		ProductModel productModel = new ProductModel();
    		productModel.setProductId(prodPackagingMatModel.getProductId());
    		productModel.setRecycleGrade(prodPackagingMatModel.getRecycleGrade());
    		productService.updateProductRecycleGrade(productModel);
    	}
    	
    	String fileUrl = "C:/PPLUS/" + prodPackagingMatModel.getProductId() + "/selfPackaging/";
    	String result = "success";
    	final Map<String, MultipartFile> files = multipart.getFileMap();
    	MultipartFile file = null;
		for (String key : files.keySet()) {
			file = files.get(key);
			System.out.println("key :"+key);
			if(file.getOriginalFilename().equals("")) {
				continue;
			}
			System.out.println("OriginalFilename :"+file.getOriginalFilename());
			
			FileModel f = new FileModel();
			f.setFileId(idUtil.getFileId());
			
			// s3 기본 처리
			f.setStorageSe("LOCAL");
			f.setFileNm(file.getOriginalFilename());
			f.setFileExtsn(FilenameUtils.getExtension(file.getOriginalFilename()));
			f.setFileSize(file.getSize());
			f.setFileUrl(fileUrl+f.getFileId() + "/");
			f.setUseYn("Y");
			f.setRefId(key+"_"+prodPackagingMatModel.getProductId()+prodPackagingMatModel.getPackagingOrder());
			f.setRgstId(prodPackagingMatModel.getModiId());
			f.setModiId(prodPackagingMatModel.getModiId());
			f.setFileCl(Constant.File.API);
			
			try {
				f.setInputStream(file.getResource().getInputStream());
			} catch (IOException e) {
				result = "fail";
//				return ResponseEntity.badRequest().body("1.IOException.");
			}
			
			// 파일 생성
			if (!"fail".equals(result)) {
				fileService.insertFile(f);
				
				Path directoryPath = Paths.get(fileUrl+f.getFileId() + "/");

				try {
					Files.createDirectories(directoryPath);
				} catch (IOException e1) {
					e1.printStackTrace();
				}

				try {
					FileOutputStream fos = new FileOutputStream(fileUrl+f.getFileId() + "/" + file.getOriginalFilename());

					InputStream is = file.getInputStream();

					int readCount = 0;
					byte[] buffer = new byte[1024];
					// 파일을 읽을 크기 만큼의 buffer를 생성하고
					// ( 보통 1024, 2048, 4096, 8192 와 같이 배수 형식으로 버퍼의 크기를 잡는 것이 일반적이다.)
					while ((readCount = is.read(buffer)) != -1) {
						// 파일에서 가져온 fileInputStream을 설정한 크기 (1024byte) 만큼 읽고
						fos.write(buffer, 0, readCount);
						// 위에서 생성한 fileOutputStream 객체에 출력하기를 반복한다
					}
				} catch (FileNotFoundException e) {
//					return ResponseEntity.badRequest().body("2.IOException.");
				}
				catch (IOException e) {
//					return ResponseEntity.badRequest().body("3.IOException.");
				}
			}
		}
		
----------------------------*/		
		
    	return new ResponseEntity<>(prodPackagingMatModel, HttpStatus.OK);
    }
    
    /**
     * 코드변경시점정보를 조회한다.
     *
     * @param productId
     * @return
     */
    @RequestMapping(value="/detail/getCodeDayList", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<List<EnvironmentCodeModel>> getCodeDayList() {
    	List<EnvironmentCodeModel> dayList = environmentCodeService.selectCodeDayList();
    	
        return new ResponseEntity<>(dayList, HttpStatus.OK);
    }
    
    /**
     * 상품 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @RequestMapping(value="/prodImage", method= {RequestMethod.GET,RequestMethod.POST})
    public String codePost(@ModelAttribute ProductModel productModel, Model model, @AuthenticationPrincipal AuthUser authUser) {

    	// 상품 목록 조회
    	List<ProductModel> models = productService.selectProductList(productModel);
    	productModel.setTotalCount(productService.selectProductListCount(productModel));
        model.addAttribute("products", models);
        model.addAttribute("pages", productModel);
        
        return "product/prodImage";
    }

    
    
    /**
     * 공급업체 페이지로 이동
     *
     * @param model
     * @return
     */
    @RequestMapping(value="/supplier", method= {RequestMethod.GET,RequestMethod.POST})
    public String code(@ModelAttribute SupplierModel supplierModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	supplierModel.setUpCompanyCode(authUser.getMemberModel().getCompanyCode());
    	supplierModel.setAuthId(authUser.getMemberModel().getAuthId());
        List<SupplierModel> models = supplierService.selectSupplierList(supplierModel);
        supplierModel.setTotalCount(supplierService.selectSupplierListCount(supplierModel));
        
        for( int i = 0 ; i < models.size() ; i++) {
        	MemberModel memberModel = new MemberModel();
        	
        	String memId = models.get(i).getManagementId();
        	memberModel.setUserId(memId);
        	memberModel = memberService.selectMember(memberModel);
        	models.get(i).setManagementId(memId);
        	models.get(i).setManagementNm(memberModel.getUserNm());
        	models.get(i).setManagementPhone(memberModel.getPhone());
        	models.get(i).setManagementMail(memberModel.getEmail());
        	models.get(i).setManagementDept(memberModel.getDeptNm());
        	models.get(i).setManagementPstn(memberModel.getPstnNm());
        }
        
        model.addAttribute("suppliers", models);
        model.addAttribute("pages", supplierModel);
        
        return "product/supplierView";
    }

    /**
     * 공급업체 목록을 상세 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping(value="/supplier/detail/{supplierId}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<SupplierModel> codesForGroupCd(@ModelAttribute SupplierModel supplierModel, @PathVariable("supplierId") String supplierId) {
    	supplierModel = supplierService.selectSupplierId(supplierId);
    	return new ResponseEntity<>(supplierModel, HttpStatus.OK);
    }
    
    /**
     * 공급업체 책임자를 상세 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping(value="/supplier/detail/manager/{managerId}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<SupplierModel> selectManagerId(@ModelAttribute SupplierModel supplierModel, @PathVariable("managerId") String managerId) {
    	supplierModel = supplierService.selectSupplierManager(managerId);
        return new ResponseEntity<>(supplierModel, HttpStatus.OK);
    }
    
    /**
     * 그룹코드 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping(value="/supplier/detail/managers/{supplierCode}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<List<SupplierModel>> selectManagersBySupplierCode(@ModelAttribute SupplierModel supplierModel, @PathVariable("supplierCode") String supplierCode) {
    	List<SupplierModel> models = supplierService.selectSupplierManagers(supplierCode);
        return new ResponseEntity<>(models, HttpStatus.OK);
    }
    
    
    /**
     * 재활용분담금 계산.
     *
     * @param 
     * @return
     */
    @RequestMapping(value="/detail/{productId}/recyle_contributions/", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String calcRecyleContributions1(@ModelAttribute ProductModel productModel, @PathVariable("productId") String productId) {
    	
//    	ProductModel productModel = new ProductModel();
//    	productModel.setBaseYear("2022");
//    	productModel.setAccumulateSaleQty(123);
//    	productModel.setPackingTotalWeight(456);

        return productService.calcRecyleContributions(productModel);
    }    
    
    
    /**
     * 환경부 승인번호 상품 매핑 ##########
     *  1
     * @param 
     * @return
     */

    @RequestMapping(value="/detail/mapping/", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<ProductModel> mapping(@ModelAttribute ProductModel productModel) {
    	System.out.println("mapping productModel" + productModel);
    	
    	if(!(productModel.getMasterApplyCode().equals("UNPROCEED"))) { //미진행
    		productModel.setErrorString("진행상태가 미진행이 아닙니다.");
  	    	return ResponseEntity.badRequest().body(productModel);	
    	}
    	
    	ProductModel product = productService.mapping(productModel);
        return new ResponseEntity<>(product, HttpStatus.OK);

    }
    
    
    /**
     * 환경부 승인번호 상품 매핑
     *
     * @param 
     * @return
     */

    @RequestMapping(value="/detail/apply/", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
	public ResponseEntity<List<ProdPackagingModel>> apply(@ModelAttribute ProductModel productModel) {
    	List<ProdPackagingModel>  prodPackagingList = productService.apply(productModel);
    	return new ResponseEntity<>(prodPackagingList, HttpStatus.OK);
    }    

    /**
     * 상품별 등록할 차수를 조회
     *  
     * @param 
     * @return
     */
	@RequestMapping(value="/detail/{productCode}/getPackagingOrderByNew", method= {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public ResponseEntity<List<ProdPackagingModel>> getPackagingOrderByNew(@PathVariable("productCode") String productCode) {
		// 상품 포장 차수 조회
		int  maxPackagingOrder = productService.selectMaxProductPackagingOrder(productCode);
 		
	    List<ProdPackagingModel> ProdPackagingList = new ArrayList<>() ;
	    ProdPackagingModel prodPackagingModel = new ProdPackagingModel();
	    prodPackagingModel.setPackagingOrder(maxPackagingOrder + 1);
        
/*	    
	    
	    if(maxPackagingOrder == 0) {
	    	prodPackagingModel.setPackagingNm("기준포장");
	    	ProdPackagingList.add(prodPackagingModel);
        } else {
        	prodPackagingModel.setPackagingNm(Integer.toString(maxPackagingOrder + 1) + "차포장");
	    	ProdPackagingList.add(prodPackagingModel);
	    	
	    	int  maxPartPackagingOrder = productService.selectMaxPartProductPackagingOrder(productCode);
		    prodPackagingModel = new ProdPackagingModel();
		    prodPackagingModel.setPackagingOrder(maxPartPackagingOrder + 1);
		    prodPackagingModel.setPackagingNm("부속포장");
		    ProdPackagingList.add(prodPackagingModel);
        }
	
*/	    
	    
		return new ResponseEntity<>(ProdPackagingList, HttpStatus.OK);
	}
	
	
	/**
     * 에러 전달
     *  
     * @param 
     * @return
     */
	@RequestMapping(value="/detail/{productCode}/error", method= {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public ResponseEntity<String> throwError(@PathVariable("productCode") String productCode) {
		if(productCode == null) {
			return ResponseEntity.badRequest().body("에러났다.");
		}else {
			String val = productService.throwError("정상");
			if(!"정상".equals(val)) {
				return ResponseEntity.badRequest().body("service 에러났다."+val);
			}
			
			return new ResponseEntity<>(productCode, HttpStatus.OK);
		}
	    
	}
}

