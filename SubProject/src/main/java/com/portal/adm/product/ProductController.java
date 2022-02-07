package com.portal.adm.product;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.portal.adm.environmentCode.model.EnvironmentCodeModel;
import com.portal.adm.product.model.ProductModel;
import com.portal.adm.product.service.ProductService;
import com.portal.adm.supplier.model.SupplierModel;
import com.portal.adm.supplier.service.SupplierService;
import com.portal.common.Constant;
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
    private IdUtil idUtil;
    
    /**
     * 상품 페이지로 이동
     *
     * @param model
     * @return
     */
    @RequestMapping(value="/prodList", method= {RequestMethod.GET,RequestMethod.POST})
    public String code(@ModelAttribute ProductModel productMapper, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	System.out.println("===================prodList==================");
    	List<ProductModel> productList = new ArrayList<>();
    	
    	productList = productService.selectList();
        model.addAttribute("productList", productList);
    	
    	List<String> productTypeList = new ArrayList<>();
    	
    	productTypeList.add("제품분류113");
    	productTypeList.add("제품분류223");
        model.addAttribute("productTypeList", productTypeList);        
        
        return "product/prodList";
    }

    /**
     * 상품 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @RequestMapping(value="/prodImage", method= {RequestMethod.GET,RequestMethod.POST})
    public String codePost(@ModelAttribute ProductModel productMapper, Model model, @AuthenticationPrincipal AuthUser authUser) {

        return "product/prodImage";
    }

    /**
     * 상품을 저장한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/product/insert")
    public ResponseEntity<String> groupSave(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
            ProductModel productMapper = new ProductModel();

            String result = "";

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    /**
     * 상품을 삭제한다.
     *
     * @param request
     * @return
     */
    @PostMapping("prodList/delete")
    public ResponseEntity<String> productDelete(@ModelAttribute ProductModel productModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	
        try {            
        	
        	String result = "";
            
            System.out.println("===================productItem delete==================\n" + productModel);
            System.out.println(productModel.getCodeId());
            result = productService.delete(productModel);
            
            return new ResponseEntity<>(result, HttpStatus.OK);
            
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
        
                
        
    }    
    
    
    /**
     * 상품 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping(value="/product/detail/{prodId}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<ProductModel> codesForGroupCd(@ModelAttribute ProductModel productMapper, @PathVariable("prodId") String prodId) {
    	productMapper.setCodeId(prodId);
    	productMapper.setGroupId("GROUP_ID");
        productMapper = productService.select(productMapper);

        return new ResponseEntity<>(productMapper, HttpStatus.OK);
    }
    
    
    /**
     * 공급업체 페이지로 이동
     *
     * @param model
     * @return
     */
    @RequestMapping(value="/supplier", method= {RequestMethod.GET,RequestMethod.POST})
    public String code(@ModelAttribute SupplierModel supplierModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	log.info(" =============== supplier in ==============");
    	supplierModel.setUpCompanyCode(authUser.getMemberModel().getCompanyCode());
    	supplierModel.setAuthId(authUser.getMemberModel().getAuthId());
    	log.info(" ====== supplier get supplierModel =======> {} ",supplierModel);
        List<SupplierModel> models = supplierService.selectSupplierList(supplierModel);
        supplierModel.setTotalCount(supplierService.selectSupplierListCount(supplierModel));
        
        List<SupplierModel> managers = new ArrayList<SupplierModel>();
        
        for( SupplierModel md : models) {
        	SupplierModel maModel = new SupplierModel();
        	String supCode = md.getSupplierCode();
        	maModel.setSupplierCode(supCode);
        	maModel = supplierService.selectSupplierMngRepper(maModel);
        	managers.add(maModel);
        }
        
        model.addAttribute("suppliers", models);
        model.addAttribute("pages", supplierModel);
        model.addAttribute("managers", managers);
        
        return "product/supplierView";
    }

    /**
     * 공급업체 저장 및 수정
     *
     * @param request
     * @return
     */
    @PostMapping("/supplier/insert")
    public ResponseEntity<String> supplierInsert(@ModelAttribute SupplierModel supplierModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
    		
    		if(supplierModel.getSupplierId() == null || StringUtils.equals(supplierModel.getSupplierId(),"")) {
    			supplierModel.setSupplierId(idUtil.getSupplierId());
    			supplierModel.setManagerId(idUtil.getManagerId());
    		}
    		if(supplierModel.getManagerRepresent() == null) {
        		supplierModel.setManagerRepresent("N");
        	}
    		supplierModel.setUpCompanyCode(authUser.getMemberModel().getCompanyCode());
    		supplierModel.setRgstId(authUser.getMemberModel().getUserId());
    		supplierModel.setModiId(authUser.getMemberModel().getUserId());
    		System.out.println("supplierModel : "+supplierModel);
            String result = supplierService.save(supplierModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }

    /**
     * 공급업체 저장 및 수정
     *
     * @param request
     * @return
     */
    @PostMapping("/supplier/insert/manager")
    public ResponseEntity< List<SupplierModel>> saveManager(@ModelAttribute SupplierModel supplierModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
		
		if(supplierModel.getManagerId() == null || StringUtils.equals(supplierModel.getManagerId(),"")) {
			supplierModel.setManagerId(idUtil.getManagerId());
		}
		if(supplierModel.getManagerRepresent() == null) {
			supplierModel.setManagerRepresent("N");
		}
		supplierModel.setSupplierCode(supplierModel.getMaSupplierCode());
		supplierModel.setUseYn(supplierModel.getMaUseYn());
		supplierModel.setUpCompanyCode(authUser.getMemberModel().getCompanyCode());
		supplierModel.setRgstId(authUser.getMemberModel().getUserId());
		supplierModel.setModiId(authUser.getMemberModel().getUserId());
		System.out.println("supplierModel : "+supplierModel);
		supplierService.saveManager(supplierModel);
		
        List<SupplierModel> models = supplierService.selectSupplierManagers(supplierModel.getSupplierCode());
        
		return new ResponseEntity<>(models, HttpStatus.OK);
    }
    
    /**
     * 공급업체 저장 및 수정
     *
     * @param request
     * @return
     */
    @PostMapping("/supplier/update/manager")
    public ResponseEntity< List<SupplierModel>> updateManager(@ModelAttribute SupplierModel supplierModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
		
		if(supplierModel.getManagerRepresent() == null) {
			supplierModel.setManagerRepresent("N");
		}
		supplierModel.setSupplierCode(supplierModel.getMaSupplierCode());
		supplierModel.setUseYn(supplierModel.getMaUseYn());
		supplierModel.setUpCompanyCode(authUser.getMemberModel().getCompanyCode());
		supplierModel.setRgstId(authUser.getMemberModel().getUserId());
		supplierModel.setModiId(authUser.getMemberModel().getUserId());
		System.out.println("supplierModel : "+supplierModel);
		supplierService.updateManager(supplierModel);
		
        List<SupplierModel> models = supplierService.selectSupplierManagers(supplierModel.getSupplierCode());
        
		return new ResponseEntity<>(models, HttpStatus.OK);
    }
    
    /**
     * 공급업체 저장 및 수정
     *
     * @param request
     * @return
     */
    @PostMapping("/supplier/insert/supplier")
    public ResponseEntity<String> saveSupplier(@ModelAttribute SupplierModel supplierModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
    		supplierModel.setUpCompanyCode(authUser.getMemberModel().getCompanyCode());
    		supplierModel.setRgstId(authUser.getMemberModel().getUserId());
    		supplierModel.setModiId(authUser.getMemberModel().getUserId());
    		System.out.println("supplierModel : "+supplierModel);
            String result = supplierService.updateSupplier(supplierModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    /**
     * 코드그룹을 삭제한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/supplier/delete/supplier")
    public ResponseEntity<String> groupDelete(@ModelAttribute SupplierModel supplierModel,HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {
        	SupplierModel model = new SupplierModel();
        	model.setSupplierId(supplierModel.getDelSupplierId());
        	model.setModiId(authUser.getMemberModel().getUserId());
        	
            String result = supplierService.delete(model);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    /**
     * 담장자를 삭제한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/supplier/delete/manager")
    @ResponseBody
    public ResponseEntity<List<SupplierModel>> supplierManagerDelete(@ModelAttribute SupplierModel supplierModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	SupplierModel model = new SupplierModel();
    	if(supplierModel.getManagerRepresent() == null) {
    		supplierModel.setManagerRepresent("N");
    	}
    	model.setManagerId(supplierModel.getDelManagerId());
    	model.setSupplierCode(supplierModel.getDelSupplierCode());
    	model.setModiId(authUser.getMemberModel().getUserId());
    	supplierService.deleteManager(model);
    	
        List<SupplierModel> models = supplierService.selectSupplierManagers(supplierModel.getDelSupplierCode());

        return new ResponseEntity<>(models, HttpStatus.OK);
    }
    
    /**
     * 그룹코드 목록을 조회한다.
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
     * 그룹코드 목록을 조회한다.
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
    
}
