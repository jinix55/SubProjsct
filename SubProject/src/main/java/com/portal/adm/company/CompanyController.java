package com.portal.adm.company;

import java.time.LocalDateTime;
import java.time.LocalTime;
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

import com.portal.adm.company.model.CompanyModel;
import com.portal.adm.company.service.CompanyService;
import com.portal.adm.member.model.MemberCriteria;
import com.portal.adm.member.model.MemberModel;
import com.portal.adm.member.service.MemberService;
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
    private MemberService memberService;
    
    @Resource
    private IdUtil idUtil;
    
    /**
     * 회사관리 페이지로 이동
     *
     * @param model
     * @return
     */
    @GetMapping("/company")
    public String company(@ModelAttribute CompanyModel companyModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	
    	companyModel.setCompanyCode(authUser.getMemberModel().getCompanyCode());
    	companyModel.setAuthId(authUser.getMemberModel().getAuthId());

    	
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
    			String companyId = request.getParameter("companyId");
    			String companyCode = request.getParameter("companyCode");
    			String companyNo = request.getParameter("companyNo");
    			String companyNm = request.getParameter("companyNm");
    			String companyDesc = request.getParameter("companyDsc");
    			String address = request.getParameter("address");
    			String telephoneNo = request.getParameter("telephoneNo");
    			String representativeNm = request.getParameter("representativeNm");
    			String note = request.getParameter("note");
    			String useYn = request.getParameter("useYn");
    			
    			if(StringUtils.equals(companyId, null) || StringUtils.equals(companyId, "")) {
    				companyId = idUtil.getCompanyId();
    			}
    			companyModel.setCompanyId(companyId);
    			companyModel.setCompanyCode(companyCode);
    			companyModel.setCompanyNo(companyNo);
    			companyModel.setCompanyNm(companyNm);
    			companyModel.setCompanyDsc(companyDesc);
    			companyModel.setAddress(address);
    			companyModel.setTelephoneNo(telephoneNo);
    			companyModel.setRepresentativeNm(representativeNm);
    			companyModel.setNote(note);
    			companyModel.setUseYn(useYn);
    			
    			companyModel.setRgstId(authUser.getMemberModel().getUserId());
    			companyModel.setModiId(authUser.getMemberModel().getUserId());
    			
    			result = companyService.save(companyModel);
    			
    			//company 등록 후 사이트 관리자 자동 등록 해줌
    			if("Insert".equals(result)) {
    				MemberModel memberModel = new MemberModel();
    				//저장시 회사코드와 같이 적용
    				memberModel.setUserId("admin@"+companyModel.getCompanyCode());
    				memberModel.setEmail("admin@"+companyModel.getCompanyCode().toLowerCase()+".pplusecho.com");
    				memberModel.setUserNm("사이트 관리자");
    				memberModel.setAuthId("au2000002");
    				memberModel.setDtLimitYn("N");
    				memberModel.setUseYn("Y");
    				memberModel.setCompanyCode(companyModel.getCompanyCode());
    				memberModel.setRgstId(authUser.getMemberModel().getUserId());
    				memberModel.setModiId(authUser.getMemberModel().getUserId());
    				result = memberService.insert(memberModel);
    			}

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
    			
    			String comapnyCdoe = companyService.selectCode(searchCode);
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
	
	            String companyId = request.getParameter("companyId");
	            companyModel.setCompanyId(companyId);
	
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
     * @param companyId
     * @return
     */
    @PostMapping("/company/detail/{companyId}")
    @ResponseBody
    public CompanyModel getCompanysForCompanyId(@PathVariable("companyId") String companyId) {
		CompanyModel companyModels = companyService.selectCompanyId(companyId);

        return companyService.selectCompanyId(companyId);
    }
    
    @GetMapping("/company/detail/{companyCode}/members")
    @ResponseBody
    public List<MemberModel> getMembers(@PathVariable String companyCode, @ModelAttribute MemberCriteria criteria, @ModelAttribute MemberModel memberModel, @AuthenticationPrincipal AuthUser authUser) {
    	if("au2000001".equals(authUser.getMemberModel().getAuthId())) {
        	criteria.setCompanyCode(companyCode);
        }else {
        	criteria.setCompanyCode(authUser.getMemberModel().getCompanyCode());
        }
    	return memberService.selectMemberList(criteria);
    }
    
    @GetMapping("/company/detail/{companyCode}/members/{memberId}")
    @ResponseBody
    public MemberModel selectPopup(@PathVariable String companyCode, @PathVariable String memberId, Model model) {
    	MemberModel memberModel = new MemberModel();
    	memberModel.setUserId(memberId+"@"+companyCode);
    	return memberService.selectMember(memberModel);
    }
    
    @PostMapping("/company/update/{companyCode}/members")
    public ResponseEntity<String> update(HttpServletRequest request,
    								   @PathVariable String companyCode, 
                                       @ModelAttribute MemberModel memberModel,
                                       @AuthenticationPrincipal AuthUser authUser) {

        try {
            if(!StringUtils.isEmpty(request.getParameter("dateFrom"))) {
                memberModel.setStartDt(LocalDateTime.parse(request.getParameter("dateFrom") + "T" + LocalTime.now().toString()));
            }
            if(!StringUtils.isEmpty(request.getParameter("dateTo"))) {
                memberModel.setEndDt(LocalDateTime.parse(request.getParameter("dateTo")+"T"+LocalTime.now().toString()));
            }

            memberModel.setRgstId(authUser.getMemberModel().getUserId());
            memberModel.setModiId(authUser.getMemberModel().getUserId());

            memberModel.setUserId(memberModel.getUserId()+"@"+memberModel.getCompanyCode());	
            String result = memberService.save(memberModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    @PostMapping("/company/insert/{companyCode}/members")
    public ResponseEntity<String> insert(HttpServletRequest request,
							    		@PathVariable String companyCode, 
							    		@ModelAttribute MemberModel memberModel,
                                        @AuthenticationPrincipal AuthUser authUser) {
		for (String key : request.getParameterMap().keySet()) {
//			log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
		}
		String subdomain = request.getServerName().split("\\.")[0];
        try {
            if(!StringUtils.isEmpty(request.getParameter("dateFrom"))) {
                memberModel.setStartDt(LocalDateTime.parse(request.getParameter("dateFrom") + "T" + LocalTime.now().toString()));
            }
            if(!StringUtils.isEmpty(request.getParameter("dateTo"))) {
                memberModel.setEndDt(LocalDateTime.parse(request.getParameter("dateTo")+"T"+LocalTime.now().toString()));
            }

            memberModel.setRgstId(authUser.getMemberModel().getUserId());
            memberModel.setModiId(authUser.getMemberModel().getUserId());
            //저장시 회사코드와 같이 적용
            memberModel.setUserId(memberModel.getUserId()+"@"+memberModel.getCompanyCode());	
            String result = memberService.insert(memberModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    @PostMapping("/company/delete/{companyCode}/members")
    public ResponseEntity<String> delete(HttpServletRequest request,
    									@PathVariable String companyCode, 
                                        @ModelAttribute MemberModel memberModel,
                                        @AuthenticationPrincipal AuthUser authUser) {
		for (String key : request.getParameterMap().keySet()) {
			log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
		}
        try {

            memberModel.setModiId(authUser.getMemberModel().getUserId());

            String result = memberService.delete(memberModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
}
