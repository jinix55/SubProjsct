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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
@RequestMapping("/report")
@Controller
public class ReportBiController {

    @Resource
    private ReportService reportService;
    
    @Resource
    private RoleService roleService;
    
    @Resource
    private IdUtil idUtil;
    
    /**
     * 레포트 정보를 조회한다.
     *
     * @param reportId
     * @return
     */
    @RequestMapping(value="/reportView/{reportId}", method= {RequestMethod.GET,RequestMethod.POST})
    public String getReportView(@PathVariable("reportId") String reportId, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	log.info("========= getReportView in ===========");
    	ReportModel reportModel = new ReportModel();
    	reportModel.setReportId(reportId);
    	reportModel.setAuthId(authUser.getMemberModel().getAuthId());
		reportModel = reportService.selectReportId(reportModel);
		model.addAttribute("report", reportModel);

        return "report/reportView";
    }
    
}
