package com.portal.adm.supplier;

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
import com.portal.adm.supplier.model.SupplierModel;
import com.portal.adm.supplier.service.SupplierService;
import com.portal.common.IdUtil;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 공급업체 / 공급업체 관리 컨트롤러
 */
@Slf4j
@RequestMapping("/supplier")
@Controller
public class SupplierController {

	@Resource
	private SupplierService supplierService;
	
	@Resource
    private MemberService memberService;
	
    @Resource
    private IdUtil idUtil;
    
    /**
     * 공급업체 페이지로 이동
     *
     * @param model
     * @return
     */
    @RequestMapping(value="/supplier", method= {RequestMethod.GET,RequestMethod.POST})
    public String code(@ModelAttribute SupplierModel supplierModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	supplierModel.setCompanyCode(authUser.getMemberModel().getCompanyCode());
    	supplierModel.setAuthId(authUser.getMemberModel().getAuthId());
        List<SupplierModel> models = supplierService.selectSupplierList(supplierModel);
        supplierModel.setTotalCount(supplierService.selectSupplierListCount(supplierModel));
        
        for( int i = 0 ; i < models.size() ; i++) {
        	MemberModel memberModel = new MemberModel();
        	
        	String memId = models.get(i).getManagementId();
        	memberModel.setUserId(memId);
        	memberModel = memberService.selectMember(memberModel);
        	if(memberModel != null) {
        		models.get(i).setManagementId(memId);
        		models.get(i).setManagementNm(memberModel.getUserNm());
        		models.get(i).setManagementPhone(memberModel.getPhone());
        		models.get(i).setManagementMail(memberModel.getEmail());
        		models.get(i).setManagementDept(memberModel.getDeptNm());
        		models.get(i).setManagementPstn(memberModel.getPstnNm());
        	}
        }
        
        model.addAttribute("suppliers", models);
        model.addAttribute("pages", supplierModel);
        
        return "supplier/supplierMgt";
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
//    			supplierModel.setManagerId(idUtil.getManagerId());
    		}
    		if(supplierModel.getManagerRepresent() == null) {
        		supplierModel.setManagerRepresent("N");
        	}
    		if(supplierModel.getManagementId() == null || "".equals(supplierModel.getManagementId())) {
    			supplierModel.setManagementId(authUser.getMemberModel().getUserId());
    		}
    		supplierModel.setCompanyCode(authUser.getMemberModel().getCompanyCode());
    		supplierModel.setRgstId(authUser.getMemberModel().getUserId());
    		supplierModel.setModiId(authUser.getMemberModel().getUserId());
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
		supplierModel.setSupplierCode(supplierModel.getSupplierCode());
		supplierModel.setUseYn(supplierModel.getMaUseYn());
		supplierModel.setCompanyCode(authUser.getMemberModel().getCompanyCode());
		supplierModel.setRgstId(authUser.getMemberModel().getUserId());
		supplierModel.setModiId(authUser.getMemberModel().getUserId());
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
		supplierModel.setCompanyCode(authUser.getMemberModel().getCompanyCode());
		supplierModel.setRgstId(authUser.getMemberModel().getUserId());
		supplierModel.setModiId(authUser.getMemberModel().getUserId());
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
    		supplierModel.setCompanyCode(authUser.getMemberModel().getCompanyCode());
    		supplierModel.setRgstId(authUser.getMemberModel().getUserId());
    		supplierModel.setModiId(authUser.getMemberModel().getUserId());
            String result = supplierService.updateSupplier(supplierModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    /**
     * 공급업체를 삭제한다.
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
     * 공급업체 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping(value="/supplier/detail/{supplierId}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<SupplierModel> codesForGroupCd(@ModelAttribute SupplierModel supplierModel, @PathVariable("supplierId") String supplierId) {
    	supplierModel = supplierService.selectSupplierId(supplierId);
    	MemberModel memberModel = new MemberModel();
    	
    	String memId = supplierModel.getManagementId();
    	memberModel.setUserId(memId);
    	memberModel = memberService.selectMember(memberModel);
    	if(memberModel != null) {
    		supplierModel.setManagementId(memId);
    		supplierModel.setManagementNm(memberModel.getUserNm());
    	}
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
    public ResponseEntity<MemberModel> selectManagerId(@ModelAttribute SupplierModel supplierModel, @PathVariable("managerId") String managerId) {
    	MemberModel memberModel = new MemberModel();
    	String memId = managerId;
    	memberModel.setUserId(memId);
    	memberModel = memberService.selectMember(memberModel);
    	return new ResponseEntity<>(memberModel, HttpStatus.OK);
    }
    
    /**
     * 공급업체 책임자을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping(value="/supplier/detail/popup/{userNm}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<List<MemberModel>> selectManagerUserNm(@ModelAttribute SupplierModel supplierModel, @PathVariable("userNm") String userNm, @AuthenticationPrincipal AuthUser authUser) {
    	MemberModel memberModel = new MemberModel();
    	memberModel.setUserNm(userNm);
    	memberModel.setCompanyCode(authUser.getMemberModel().getCompanyCode());
    	List<MemberModel> list = supplierService.selectUserNmList(memberModel);
		return new ResponseEntity<>(list, HttpStatus.OK);
    }
    
    /**
     * 공급업체 담당자을 조회한다.
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
     * 공급업체 저장 및 수정
     *
     * @param request
     * @return
     */
    @PostMapping("/supplier/update/manager/{managerId}")
    public ResponseEntity<String> updateManagementId(@ModelAttribute SupplierModel supplierModel,  @PathVariable("managerId") String managerId, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
		
		supplierModel.setManagementId(managerId);
		supplierModel.setModiId(authUser.getMemberModel().getUserId());
		String result = supplierService.updateManagementId(supplierModel);
		
		return new ResponseEntity<>(result, HttpStatus.OK);
    }
    
}
