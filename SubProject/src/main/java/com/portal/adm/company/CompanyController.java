package com.portal.adm.company;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.adm.company.model.CompanyModel;
import com.portal.adm.company.service.CompanyService;
import com.portal.adm.member.model.MemberModel;
import com.portal.common.IdUtil;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템관리 / 회사관리 컨트롤러
 */
@Slf4j
@RequestMapping("/system")
@Controller
public class CompanyController {

    @Resource
    private CompanyService companyService;
    
    @Resource
    private IdUtil idUtil;
    
    /**
     * 회사관리 페이지로 이동
     *
     * @param model
     * @return
     */
    @GetMapping("/company")
    public String company(@ModelAttribute CompanyModel companyModel, Model model) {
        List<CompanyModel> models = companyService.selectCompanyList(companyModel);
        companyModel.setTotalCount(companyService.selectCompanyListCount(companyModel));
        model.addAttribute("companys", models);
        model.addAttribute("pages", companyModel);
        
        return "company/companyMgt";
    }

    /**
     * 회사관리 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @PostMapping("/company")
    public String companyPost(@ModelAttribute CompanyModel companyModel, Model model) {
        List<CompanyModel> models = companyService.selectCompanyList(companyModel);
        companyModel.setTotalCount(companyService.selectCompanyListCount(companyModel));
        model.addAttribute("companys", models);
        model.addAttribute("pages", companyModel);
        
        return "company/companyMgt";
    }

    /**
     * 회사그룹을 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/company/insert")
    @ResponseBody
    public String companySave(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    		String result = null;
    		if(StringUtils.equals(authUser.getMemberModel().getAuthCl(), "P")) {
    			
    			CompanyModel companyModel = new CompanyModel();
    			for (String key : request.getParameterMap().keySet()) {
//    				log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
    			}

    			String companyCode = request.getParameter("companyCode");
    			String companyNo = request.getParameter("companyNo");
    			String companyNm = request.getParameter("companyNm");
    			String companyDesc = request.getParameter("companyDsc");
    			String address = request.getParameter("address");
    			String telephoneNo = request.getParameter("telephoneNo");
    			String representativeNm = request.getParameter("representativeNm");
    			String note = request.getParameter("note");
    			String logoFileId = request.getParameter("logoFileId");
    			String useYn = request.getParameter("useYn");
    			

    			companyModel.setCompanyCode(companyCode);
    			companyModel.setCompanyNo(companyNo);
    			companyModel.setCompanyNm(companyNm);
    			companyModel.setCompanyDsc(companyDesc);
    			companyModel.setAddress(address);
    			companyModel.setTelephoneNo(telephoneNo);
    			companyModel.setRepresentativeNm(representativeNm);
    			companyModel.setNote(note);
    			companyModel.setLogoFileId(logoFileId);
    			companyModel.setUseYn(useYn);
    			
    			companyModel.setRgstId(authUser.getMemberModel().getUserId());
    			companyModel.setModiId(authUser.getMemberModel().getUserId());
    			
    			result = companyService.save(companyModel);
    		}else {
    			result = "권한이 없습니다./n관리자에게 문의하세요.";
    		}

    		return result;
    }
    
    /**
     * 회사그룹을 삭제한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/company/popup")
    @ResponseBody
    public String companySelect(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
    		String result = null;
    		if(StringUtils.equals(authUser.getMemberModel().getAuthCl(), "P")) {
    			
    			String searchCode = request.getParameter("search");
    			
    			String comapnyCdoe = null; //companyService.selectCode(searchCode); 확인 필요@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
				if( comapnyCdoe == null || StringUtils.equals(comapnyCdoe, "")) {
					return searchCode.toUpperCase();
				}else {
					return "none";
				}
    		} else {
    			result = "권한이 없습니다./n관리자에게 문의하세요.";
    		}
    		
    		return result;
    	} catch (Exception e) {
    		return "권한이 없습니다./n관리자에게 문의하세요.";
    	}
    }
    
    /**
     * 회사그룹을 삭제한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/company/delete")
    @ResponseBody
    public String companyDelete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {
        	 String result = null;
        	if(StringUtils.equals(authUser.getMemberModel().getAuthCl(), "P")) {
	            CompanyModel companyModel = new CompanyModel();
	
	            String companyCode = request.getParameter("companyCode");
	            companyModel.setCompanyCode(companyCode);
	
	            companyModel.setModiId(authUser.getMemberModel().getUserId());
	
	            result = companyService.delete(companyModel);
        	} else {
        		result = "권한이 없습니다./n관리자에게 문의하세요.";
        	}

            return result;
        } catch (Exception e) {
            return "권한이 없습니다./n관리자에게 문의하세요.";
        }
    }
    
    /**
     * 회사 정보를 조회한다.
     *
     * @param companyCode
     * @return
     */
    @PostMapping("/company/detail/{companyCode}")
    @ResponseBody
    public CompanyModel getCompanysForCompanyId(@PathVariable("companyCode") String companyCode) {
		CompanyModel companyModels = companyService.selectCompanyCode(companyCode);

        return companyService.selectCompanyCode(companyCode);
    }
    
}
