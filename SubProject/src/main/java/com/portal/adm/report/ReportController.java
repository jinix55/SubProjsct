package com.portal.adm.report;

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

import com.portal.adm.report.model.ReportModel;
import com.portal.adm.report.service.ReportService;
import com.portal.adm.role.model.RoleModel;
import com.portal.adm.role.service.RoleService;
import com.portal.common.IdUtil;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템관리 / 레포트관리 컨트롤러
 */
@Slf4j
@RequestMapping("/menu")
@Controller
public class ReportController {

    @Resource
    private ReportService reportService;
    
    @Resource
    private RoleService roleService;
    
    @Resource
    private IdUtil idUtil;
    
    /**
     * 레포트관리 페이지로 이동
     *
     * @param model
     * @return
     */
    @GetMapping("/report")
    public String reportGet(@ModelAttribute ReportModel reportModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	log.info(" =============== report get in ==============");
        List<ReportModel> models = reportService.selectReportList(reportModel);
        reportModel.setTotalCount(reportService.selectReportListCount(reportModel));
        RoleModel roleModel = new RoleModel();
        roleModel.setCompanyCode(authUser.getMemberModel().getCompanyCode());
        roleModel.setAuthId(authUser.getMemberModel().getAuthId());
        model.addAttribute("roles", roleService.selectList(roleModel));
        model.addAttribute("reports", models);
        model.addAttribute("pages", reportModel);
        
        return "report/reportMgt";
    }

    /**
     * 레포트관리 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @PostMapping("/report")
    public String reportPost(@ModelAttribute ReportModel reportModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	log.info(" =============== report Post in ==============");
        List<ReportModel> models = reportService.selectReportList(reportModel);
        reportModel.setTotalCount(reportService.selectReportListCount(reportModel));
        RoleModel roleModel = new RoleModel();
        roleModel.setCompanyCode(authUser.getMemberModel().getCompanyCode());
        roleModel.setAuthId(authUser.getMemberModel().getAuthId());
        model.addAttribute("roles", roleService.selectList(roleModel));
        model.addAttribute("reports", models);
        model.addAttribute("pages", reportModel);
        
        return "report/reportMgt";
    }

    /**
     * 레포트그룹을 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/report/insert")
    @ResponseBody
    public ResponseEntity<String> reportSave(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
    		String result = null;
    		if(StringUtils.equals(authUser.getMemberModel().getAuthCl(), "P")) {
    			
    			ReportModel reportModel = new ReportModel();
    			for (String key : request.getParameterMap().keySet()) {
    				log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
    			}
    			String reportId = request.getParameter("reportId");
    			String reportNm = request.getParameter("reportNm");
    			String reportUrl = request.getParameter("reportUrl");
    			String groupId = request.getParameter("groupId");
    			String reportDsc = request.getParameter("reportDsc");
    			String reportType = request.getParameter("reportType");
    			String companyId = authUser.getMemberModel().getCompanyCode();
    			String reportSize = request.getParameter("reportSize");
    			String useYn = request.getParameter("useYn");
    			
    			if(StringUtils.equals(reportId, null) || StringUtils.equals(reportId, "")) {
    				reportId = idUtil.getReportId();
    			}
    			reportModel.setReportId(reportId);
    			reportModel.setReportNm(reportNm);
    			reportModel.setReportUrl(reportUrl);
    			reportModel.setGroupId(groupId);
    			reportModel.setReportType(reportType);
    			reportModel.setReportDsc(reportDsc);
    			reportModel.setCompanyId(companyId);
    			reportModel.setReportSize(reportSize);
    			reportModel.setUseYn(useYn);
    			
    			reportModel.setRgstId(authUser.getMemberModel().getUserId());
    			reportModel.setModiId(authUser.getMemberModel().getUserId());
    			
    			result = reportService.save(reportModel);
    		}else {
    			result = "권한이 없습니다./n관리자에게 문의하세요.";
    		}

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    /**
     * 레포트그룹을 삭제한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/report/delete")
    @ResponseBody
    public ResponseEntity<String> reportDelete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {
        	 String result = null;
        	if(StringUtils.equals(authUser.getMemberModel().getAuthCl(), "P")) {
	            ReportModel reportModel = new ReportModel();
	
	            String reportId = request.getParameter("reportId");
    			String reportNm = request.getParameter("reportNm");
    			String reportUrl = request.getParameter("reportUrl");
    			String companyId = authUser.getMemberModel().getCompanyCode();
	
	            reportModel.setReportId(reportId);
    			reportModel.setReportNm(reportNm);
    			reportModel.setReportUrl(reportUrl);
    			reportModel.setCompanyId(companyId);
	
	            reportModel.setModiId(authUser.getMemberModel().getUserId());
	
	            result = reportService.delete(reportModel);
        	} else {
        		result = "권한이 없습니다./n관리자에게 문의하세요.";
        	}

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }    
    
    /**
     * 레포트 정보를 조회한다.
     *
     * @param reportId
     * @return
     */
    @PostMapping("/report/detail/{reportId}")
    public ResponseEntity<ReportModel> getReportsForReportId(@PathVariable("reportId") String reportId) {
    	ReportModel reportModel = new ReportModel();
    	reportModel.setReportId(reportId);
		reportModel = reportService.selectReportId(reportModel);

        return new ResponseEntity<>(reportModel, HttpStatus.OK);
    }
    
}
