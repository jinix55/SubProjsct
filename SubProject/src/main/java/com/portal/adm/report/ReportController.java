package com.portal.adm.report;

import java.time.format.DateTimeFormatter;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.adm.report.model.ReportModel;
import com.portal.adm.report.service.ReportService;
import com.portal.common.IdUtil;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템관리 / 회사관리 컨트롤러
 */
@Slf4j
@RequestMapping("/menu")
@Controller
public class ReportController {

    @Resource
    private ReportService reportService;
    
    @Resource
    private IdUtil idUtil;
    
    /**
     * 회사관리 페이지로 이동
     *
     * @param model
     * @return
     */
    @GetMapping("/report")
    public String report(@ModelAttribute ReportModel reportModel, Model model) {
    	log.info(" =============== report get in ==============");
        List<ReportModel> models = reportService.selectReportList(reportModel);
        reportModel.setTotalCount(reportService.selectReportListCount(reportModel));
        model.addAttribute("reports", models);
        model.addAttribute("pages", reportModel);
        
        return "report/reportMgt";
    }

    /**
     * 회사관리 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @PostMapping("/report")
    public String report(@ModelAttribute ReportModel reportModel, RedirectAttributes attributes) {
    	log.info(" =============== report get in ==============");
        List<ReportModel> models = reportService.selectReportList(reportModel);
        reportModel.setTotalCount(reportService.selectReportListCount(reportModel));
        attributes.addAttribute("reports", models);
        attributes.addAttribute("pages", reportModel);
        
        return "report/reportMgt";
    }

    /**
     * 회사그룹을 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/report/insert")
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
    			String companyId = request.getParameter("companyId");
    			String reportSize = request.getParameter("reportSize");
    			String useYn = request.getParameter("useYn");
    			
    			if(StringUtils.equals(reportId, null) || StringUtils.equals(reportId, "")) {
    				reportId = idUtil.getReportId();
    			}
    			reportModel.setReportId(reportId);
    			reportModel.setReportNm(reportNm);
    			reportModel.setReportUrl(reportUrl);
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
     * 회사그룹을 삭제한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/report/delete")
    public ResponseEntity<String> reportDelete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {
        	 String result = null;
        	if(StringUtils.equals(authUser.getMemberModel().getAuthCl(), "P")) {
	            ReportModel reportModel = new ReportModel();
	
	            String reportId = request.getParameter("reportId");
    			String reportNm = request.getParameter("reportNm");
    			String reportUrl = request.getParameter("reportUrl");
    			String companyId = request.getParameter("companyId");
	
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
     * 회사 정보를 조회한다.
     *
     * @param reportId
     * @return
     */
    @GetMapping("/report/detail/{reportId}")
    public ResponseEntity<ReportModel> getReportsForReportId(@PathVariable("reportId") String reportId) {
		ReportModel reportModels = reportService.selectReportId(reportId);

        return new ResponseEntity<>(reportModels, HttpStatus.OK);
    }
    
}
