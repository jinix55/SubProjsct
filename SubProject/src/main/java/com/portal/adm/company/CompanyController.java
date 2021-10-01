package com.portal.adm.company;

import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.adm.company.model.CompanyModel;
import com.portal.adm.company.service.CompanyService;
import com.portal.common.paging.Criteria;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템관리 / 코드관리 컨트롤러
 */
@Slf4j
@RequestMapping("/admin")
@Controller
public class CompanyController {

    @Resource
    private CompanyService companyService;
    
    /**
     * 코드관리 페이지로 이동
     *
     * @param model
     * @return
     */
    @GetMapping("/company")
    public String company(@ModelAttribute CompanyModel companyModel,Model model, Criteria criteria) {
    	log.info(" =============== company get in ==============");
        List<CompanyModel> models = companyService.selectCompanyList(companyModel);
        criteria.setTotalCount(companyService.selectCompanyListCount(companyModel));
        model.addAttribute("companys", models);
        model.addAttribute("pages", criteria);
        
        return "company/company";
    }

    /**
     * 코드관리 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @PostMapping("/company")
    public String company(@ModelAttribute Criteria criteria, RedirectAttributes attributes) {
//        List<CompanyModel> models = companyService.selectGroupIdList("GROUP_ID", criteria);
//        criteria.setTotalCount(companyService.selectGroupIdListCount("GROUP_ID"));
//        attributes.addAttribute("companys", models);
//        attributes.addAttribute("criteria", criteria);

        return "company/company";
    }

    /**
     * 코드그룹을 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/company/insert")
    public ResponseEntity<String> groupSave(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
            CompanyModel companyModel = new CompanyModel();
            for (String key : request.getParameterMap().keySet()) {
            	log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
            }
            String companyId = request.getParameter("groupCompanyId");
            String companyNm = request.getParameter("groupCompanyNm");
            String companyDesc = request.getParameter("groupCompanyDsc");
            String companyUseYn = request.getParameter("groupCompanyUseYn");

            companyModel.setCompanyId(companyId);
            companyModel.setCompanyNm(companyNm);
            companyModel.setCompanyDsc(companyDesc);
            companyModel.setUseYn(companyUseYn);
            companyModel.setGroupId("GROUP_ID");

            companyModel.setRgstId(authUser.getMemberModel().getUserId());
            companyModel.setModiId(authUser.getMemberModel().getUserId());

//            String result = companyService.save(companyModel);
            String result = "";

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
    @PostMapping("/company/delete")
    public ResponseEntity<String> groupDelete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {
            CompanyModel companyModel = new CompanyModel();

            String companyId = request.getParameter("groupCompanyId");
            String companyNm = request.getParameter("groupCompanyNm");
            String companyDesc = request.getParameter("groupCompanyDsc");

            companyModel.setCompanyId(companyId);
            companyModel.setCompanyNm(companyNm);
            companyModel.setCompanyDsc(companyDesc);
            companyModel.setGroupId("GROUP_ID");

            companyModel.setRgstId(authUser.getMemberModel().getUserId());
            companyModel.setModiId(authUser.getMemberModel().getUserId());

//            String result = companyService.delete(companyModel);
            String result = "";

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }    
    
    
    
    
    /**
     * 그룹코드 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @GetMapping("/company/detail/{groupCd}")
    public ResponseEntity<List<CompanyModel>> companysForGroupCd(@PathVariable("groupCd") String groupId) {
//        List<CompanyModel> companyModels = companyService.selectGroupIdAllList(groupId);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
//        companyModels.stream().forEach(company -> company.setRgstDtStr(formatter.format(company.getRgstDt())));
        List<CompanyModel> companyModels = null;

        return new ResponseEntity<>(companyModels, HttpStatus.OK);
    }
    
    
    /**
     * 그룹코드 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @PostMapping("/company/detail/{groupCd}")
    public ResponseEntity<List<CompanyModel>> postCompanysForGroupCd(@PathVariable("groupCd") String groupId) {
//    	List<CompanyModel> companyModels = companyService.selectGroupIdAllList(groupId);
    	
    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
//    	companyModels.stream().forEach(company -> company.setRgstDtStr(formatter.format(company.getRgstDt())));
    	List<CompanyModel> companyModels = null;
    	
    	return new ResponseEntity<>(companyModels, HttpStatus.OK);
    }

    /**
     * 코드를 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param companyModel
     * @return
     */
    @PostMapping("/company/insert/company")
    public ResponseEntity<String> save(@ModelAttribute CompanyModel companyModel, @AuthenticationPrincipal AuthUser authUser) {
    	try {
            companyModel.setRgstId(authUser.getMemberModel().getUserId());
            companyModel.setModiId(authUser.getMemberModel().getUserId());

//            String result = companyService.save(companyModel);
            String result = "";
            
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }



    /**
     * 코드를 삭제한다.
     *
     * @param companyModel
     * @return
     */
    @PostMapping("/company/delete/company")
    public ResponseEntity<String> delete(@ModelAttribute CompanyModel companyModel, @AuthenticationPrincipal AuthUser authUser) {
        try {
            companyModel.setRgstId(authUser.getMemberModel().getUserId());
            companyModel.setModiId(authUser.getMemberModel().getUserId());

//            String result = companyService.delete(companyModel);
            String result = "";
            
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }


}
