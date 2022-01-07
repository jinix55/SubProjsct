package com.portal.adm.environmentCode;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.portal.adm.environmentCode.model.EnvironmentCodeModel;
import com.portal.adm.environmentCode.service.EnvironmentCodeService;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템관리 / 코드관리 컨트롤러
 */
@Slf4j
@RequestMapping("/system")
@Controller
public class EnvironmentCodeController {

    @Resource
    private EnvironmentCodeService environmentCodeService;
    
    /**
     * 코드관리 페이지로 이동
     *
     * @param model
     * @return
     */
    @RequestMapping(value="/environmentCode", method= {RequestMethod.GET,RequestMethod.POST})
    public String environmentCode(@ModelAttribute EnvironmentCodeModel environmentCodeModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	System.out.println("===================environmentCode==================");
    	System.out.println("=== environmentCodeModel => : "+environmentCodeModel);
    	String largeCategory = "GROUP_ID";
    	if(environmentCodeModel.getGroupId() == null || StringUtils.equals(environmentCodeModel.getGroupId(),"")) {
    		largeCategory = "GROUP_ID";
    	}
    	model.addAttribute("setLargeCategory", environmentCodeModel.getLargeCategory());
    	List<EnvironmentCodeModel> dayList = new ArrayList<EnvironmentCodeModel>();
    	List<EnvironmentCodeModel> largeModels = new ArrayList<EnvironmentCodeModel>();
    	List<EnvironmentCodeModel> middleModels = new ArrayList<EnvironmentCodeModel>();
    	List<EnvironmentCodeModel> smallModels = new ArrayList<EnvironmentCodeModel>();
    	
    	dayList = environmentCodeService.selectCodeDayList(environmentCodeModel);
    	model.addAttribute("dayList", dayList);
    	
    	if(environmentCodeModel.getRevisionMonth() == null || environmentCodeModel.getRevisionYear() == null || StringUtils.equals(environmentCodeModel.getRevisionMonth(), "") || StringUtils.equals(environmentCodeModel.getRevisionYear(), "") ) {
    		environmentCodeModel.setRevisionMonth(dayList.get(0).getRevisionMonth());
    		environmentCodeModel.setRevisionYear(dayList.get(0).getRevisionYear());
    	}
    	
    	// 재질 리스트
    	environmentCodeModel.setGroupId(largeCategory);
		environmentCodeModel.setAuthId(authUser.getMemberModel().getAuthId());
        largeModels = environmentCodeService.selectGroupIdList(environmentCodeModel);
        model.addAttribute("largeCodeList", largeModels);
        
    	if(largeModels.size() > 0) {
    		if(environmentCodeModel.getLargeCategory() == null){
    			largeModels.get(0).setGroupId(largeModels.get(0).getCodeId());
    		}else {
    			largeModels.get(0).setGroupId(environmentCodeModel.getLargeCategory());
    		}
    		middleModels = environmentCodeService.selectGroupIdList(largeModels.get(0));
    		model.addAttribute("middleCodeList", middleModels);
    		model.addAttribute("middlePages", environmentCodeModel);
    	}

        
        // 부위 리스트
        if(middleModels.size() > 0) {
        	middleModels.get(0).setGroupId(middleModels.get(0).getCodeId());
        	smallModels = environmentCodeService.selectGroupIdList(middleModels.get(0));
        	environmentCodeModel.setGroupId(middleModels.get(0).getCodeId());
        	environmentCodeModel.setTotalCount(environmentCodeService.selectGroupIdListCount(environmentCodeModel));
        	model.addAttribute("smallCodeList", smallModels);
        	model.addAttribute("pages", environmentCodeModel);
        }
        
        return "environmentCode/environmentCode";
    }


    /**
     * 코드그룹을 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/environmentCode/insert")
    public ResponseEntity<String> groupSave(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
        	String _groupId = "";
            EnvironmentCodeModel environmentCodeModel = new EnvironmentCodeModel();
            for (String key : request.getParameterMap().keySet()) {
            	log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
            }
            String groupId = request.getParameter("groupId");
            String codeId = request.getParameter("codeId");
            String codeNm = request.getParameter("codeNm");
            String codeDesc = request.getParameter("codeDsc");
            String codeUseYn = request.getParameter("useYn");

            if(groupId == null || StringUtils.equals(groupId,"")) {
            	_groupId = "GROUP_ID";
            }else {
            	_groupId = groupId;
            }
            
            environmentCodeModel.setCodeId(codeId);
            environmentCodeModel.setCodeNm(codeNm);
            environmentCodeModel.setCodeDsc(codeDesc);
            environmentCodeModel.setUseYn(codeUseYn);
        	environmentCodeModel.setGroupId(_groupId);

            environmentCodeModel.setRgstId(authUser.getMemberModel().getUserId());
            environmentCodeModel.setModiId(authUser.getMemberModel().getUserId());

            String result = environmentCodeService.save(environmentCodeModel);

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
    @PostMapping("/environmentCode/delete")
    public ResponseEntity<String> groupDelete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {
            EnvironmentCodeModel environmentCodeModel = new EnvironmentCodeModel();

            String codeId = request.getParameter("codeId");

            environmentCodeModel.setCodeId(codeId);
            environmentCodeModel.setGroupId("GROUP_ID");

            environmentCodeModel.setRgstId(authUser.getMemberModel().getUserId());
            environmentCodeModel.setModiId(authUser.getMemberModel().getUserId());

            String result = environmentCodeService.delete(environmentCodeModel);

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
    @RequestMapping(value="/environmentCode/detail/{codeId}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<EnvironmentCodeModel> codesForGroupCd(@ModelAttribute EnvironmentCodeModel environmentCodeModel, @PathVariable("codeId") String codeId) {
    	environmentCodeModel.setCodeId(codeId);
    	environmentCodeModel.setGroupId("GROUP_ID");
        environmentCodeModel = environmentCodeService.select(environmentCodeModel);

        return new ResponseEntity<>(environmentCodeModel, HttpStatus.OK);
    }
    
    
    /**
     * 그룹코드 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping("/environmentCode/detail/code/{groupCd}")
    public ResponseEntity<List<EnvironmentCodeModel>> codesForCodeCd(@PathVariable("groupCd") String groupId) {
    	List<EnvironmentCodeModel> environmentCodeModels = environmentCodeService.selectGroupIdAllList(groupId);
    	
    	return new ResponseEntity<>(environmentCodeModels, HttpStatus.OK);
    }

    /**
     * 코드를 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param environmentCodeModel
     * @return
     */
    @PostMapping("/environmentCode/insert/code")
    public ResponseEntity<String> save(@ModelAttribute EnvironmentCodeModel environmentCodeModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
            for (String key : request.getParameterMap().keySet()) {
            	log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
            }
            String groupId = request.getParameter("groupId");
            String codeId = request.getParameter("codeId");
            String codeNm = request.getParameter("codeNm");
            String codeDesc = request.getParameter("codeDsc");
            String codeUseYn = request.getParameter("code_useYn");

            environmentCodeModel.setCodeId(codeId);
            environmentCodeModel.setCodeNm(codeNm);
            environmentCodeModel.setCodeDsc(codeDesc);
            environmentCodeModel.setUseYn(codeUseYn);
            if(groupId != null) {
            	 environmentCodeModel.setGroupId(groupId);
            }else {
            	environmentCodeModel.setGroupId("GROUP_ID");
            }

            environmentCodeModel.setRgstId(authUser.getMemberModel().getUserId());
            environmentCodeModel.setModiId(authUser.getMemberModel().getUserId());

            String result = environmentCodeService.save(environmentCodeModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }



    /**
     * 코드를 삭제한다.
     *
     * @param environmentCodeModel
     * @return
     */
    @PostMapping("/environmentCode/delete/code")
    public ResponseEntity<String> delete(@ModelAttribute EnvironmentCodeModel environmentCodeModel, @AuthenticationPrincipal AuthUser authUser) {
        try {
            environmentCodeModel.setRgstId(authUser.getMemberModel().getUserId());
            environmentCodeModel.setModiId(authUser.getMemberModel().getUserId());

            String result = environmentCodeService.delete(environmentCodeModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }


}
