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

import com.portal.adm.member.model.MemberModel;
import com.portal.adm.member.service.MemberService;
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
    private MemberService memberService;
	
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
            System.out.println(productModel.getProductCode());
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
    
}
