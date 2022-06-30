package com.portal.adm.reset;

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

import com.portal.adm.reset.model.ResetModel;
import com.portal.adm.reset.service.ResetService;
import com.portal.common.IdUtil;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템관리 / 회사관리 컨트롤러
 */
@Slf4j
@RequestMapping("/admin")
@Controller
public class ResetController {

    @Resource
    private ResetService resetService;
    
    @Resource
    private IdUtil idUtil;
    
    /**
     * 회사관리 페이지로 이동
     *
     * @param model
     * @return
     */
    @GetMapping("/reset")
    public String reset(@ModelAttribute ResetModel resetModel, Model model) {
        List<ResetModel> models = resetService.selectResetList(resetModel);
        resetModel.setTotalCount(resetService.selectResetListCount(resetModel));
        model.addAttribute("resets", models);
        model.addAttribute("pages", resetModel);
        
        return "reset/reset";
    }

    /**
     * 회사관리 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @PostMapping("/reset")
    public String reset(@ModelAttribute ResetModel resetModel, RedirectAttributes attributes) {
        List<ResetModel> models = resetService.selectResetList(resetModel);
        resetModel.setTotalCount(resetService.selectResetListCount(resetModel));
        attributes.addAttribute("resets", models);
        attributes.addAttribute("pages", resetModel);
        
        return "reset/reset";
    }

    /**
     * 회사그룹을 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/reset/insert")
    public ResponseEntity<String> resetSave(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
    		String result = null;
    		if(StringUtils.equals(authUser.getMemberModel().getAuthCode(), "P")) {
    			
    			ResetModel resetModel = new ResetModel();
    			for (String key : request.getParameterMap().keySet()) {
//    				log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
    			}
    			String resetId = request.getParameter("resetId");
    			String companyNm = request.getParameter("companyNm");
    			String userNm = request.getParameter("userNm");
    			String userId = request.getParameter("userId");
    			String useYn = request.getParameter("useYn");
    			
    			if(StringUtils.equals(resetId, null) || StringUtils.equals(resetId, "")) {
    				resetId = idUtil.getResetId();
    			}
    			resetModel.setResetId(resetId);
    			resetModel.setCompanyNm(companyNm);
    			resetModel.setUserId(userNm);
    			resetModel.setUserNm(userId);
    			resetModel.setUseYn(useYn);
    			
    			resetModel.setRgstId(authUser.getMemberModel().getUserId());
    			resetModel.setModiId(authUser.getMemberModel().getUserId());
    			
    			result = resetService.save(resetModel);
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
    @PostMapping("/reset/delete")
    public ResponseEntity<String> resetDelete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {
        	 String result = null;
        	if(StringUtils.equals(authUser.getMemberModel().getAuthCode(), "P")) {
	            ResetModel resetModel = new ResetModel();
	
    			String resetId = request.getParameter("resetId");
    			String companyNm = request.getParameter("companyNm");
    			String userNm = request.getParameter("userNm");
    			String userId = request.getParameter("userId");
    			String useYn = "N";
	
    			resetModel.setResetId(resetId);
    			resetModel.setCompanyNm(companyNm);
    			resetModel.setUserId(userNm);
    			resetModel.setUserNm(userId);
    			resetModel.setUseYn(useYn);
	
	            resetModel.setModiId(authUser.getMemberModel().getUserId());
	
	            result = resetService.delete(resetModel);
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
     * @param resetId
     * @return
     */
    @GetMapping("/reset/detail/{resetId}")
    public ResponseEntity<ResetModel> getResetsForResetId(@PathVariable("resetId") String resetId) {
		ResetModel resetModels = resetService.selectResetId(resetId);

        return new ResponseEntity<>(resetModels, HttpStatus.OK);
    }
    
}
