package com.portal.adm.environmentCode;

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
    @GetMapping("/environmentCode")
    public String code(@ModelAttribute EnvironmentCodeModel environmentCodeMapper, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	String largeCategory = "GROUP_ID";
    	String middleCategory = "";
    	environmentCodeMapper.setGroupId("GROUP_ID");
		environmentCodeMapper.setAuthId(authUser.getMemberModel().getAuthId());
    	environmentCodeMapper.setUpCompanyCode(authUser.getMemberModel().getCompanyCode());
        List<EnvironmentCodeModel> models = environmentCodeService.selectGroupIdList(environmentCodeMapper);
        environmentCodeMapper.setTotalCount(environmentCodeService.selectGroupIdListCount(environmentCodeMapper));
        model.addAttribute("codes", models);
        model.addAttribute("pages", environmentCodeMapper);

//        if(models.size() > 0) {
//            model.addAttribute("firstCodeId", models.get(0).getCodeId());
//            model.addAttribute("firstCodeNm", models.get(0).getCodeNm());
//            model.addAttribute("firstCodeDsc", models.get(0).getCodeDsc());
//            model.addAttribute("firstCodeUseYn", models.get(0).getUseYn());
//        }

        return "environmentCode/environmentCode";
    }

    /**
     * 코드관리 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @PostMapping("/environmentCode")
    public String codePost(@ModelAttribute EnvironmentCodeModel environmentCodeMapper, Model model) {
    	if(environmentCodeMapper.getGroupId() == null) {
    		environmentCodeMapper.setGroupId("GROUP_ID");
    	}
        List<EnvironmentCodeModel> models = environmentCodeService.selectGroupIdList(environmentCodeMapper);
        environmentCodeMapper.setTotalCount(environmentCodeService.selectGroupIdListCount(environmentCodeMapper));
        model.addAttribute("codes", models);
        model.addAttribute("pages", environmentCodeMapper);

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
            EnvironmentCodeModel environmentCodeMapper = new EnvironmentCodeModel();
            for (String key : request.getParameterMap().keySet()) {
            	log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
            }
            String groupId = request.getParameter("groupId");
            String codeId = request.getParameter("codeId");
            String codeNm = request.getParameter("codeNm");
            String codeDesc = request.getParameter("codeDsc");
            String codeUseYn = request.getParameter("useYn");

            environmentCodeMapper.setCodeId(codeId);
            environmentCodeMapper.setCodeNm(codeNm);
            environmentCodeMapper.setCodeDsc(codeDesc);
            environmentCodeMapper.setUseYn(codeUseYn);
            if(groupId != null) {
            	 environmentCodeMapper.setGroupId(groupId);
            }else {
            	environmentCodeMapper.setGroupId("GROUP_ID");
            }

            environmentCodeMapper.setRgstId(authUser.getMemberModel().getUserId());
            environmentCodeMapper.setModiId(authUser.getMemberModel().getUserId());

            String result = environmentCodeService.save(environmentCodeMapper);

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
            EnvironmentCodeModel environmentCodeMapper = new EnvironmentCodeModel();

            String codeId = request.getParameter("codeId");

            environmentCodeMapper.setCodeId(codeId);
            environmentCodeMapper.setGroupId("GROUP_ID");

            environmentCodeMapper.setRgstId(authUser.getMemberModel().getUserId());
            environmentCodeMapper.setModiId(authUser.getMemberModel().getUserId());

            String result = environmentCodeService.delete(environmentCodeMapper);

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
    public ResponseEntity<EnvironmentCodeModel> codesForGroupCd(@ModelAttribute EnvironmentCodeModel environmentCodeMapper, @PathVariable("codeId") String codeId) {
    	environmentCodeMapper.setCodeId(codeId);
    	environmentCodeMapper.setGroupId("GROUP_ID");
        environmentCodeMapper = environmentCodeService.select(environmentCodeMapper);

        return new ResponseEntity<>(environmentCodeMapper, HttpStatus.OK);
    }
    
    
    /**
     * 그룹코드 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping("/environmentCode/detail/code/{groupCd}")
    public ResponseEntity<List<EnvironmentCodeModel>> codesForCodeCd(@PathVariable("groupCd") String groupId) {
    	List<EnvironmentCodeModel> environmentCodeMappers = environmentCodeService.selectGroupIdAllList(groupId);
    	
    	return new ResponseEntity<>(environmentCodeMappers, HttpStatus.OK);
    }

    /**
     * 코드를 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param environmentCodeMapper
     * @return
     */
    @PostMapping("/environmentCode/insert/code")
    public ResponseEntity<String> save(@ModelAttribute EnvironmentCodeModel environmentCodeMapper, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
            for (String key : request.getParameterMap().keySet()) {
            	log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
            }
            String groupId = request.getParameter("groupId");
            String codeId = request.getParameter("codeId");
            String codeNm = request.getParameter("codeNm");
            String codeDesc = request.getParameter("codeDsc");
            String codeUseYn = request.getParameter("code_useYn");

            environmentCodeMapper.setCodeId(codeId);
            environmentCodeMapper.setCodeNm(codeNm);
            environmentCodeMapper.setCodeDsc(codeDesc);
            environmentCodeMapper.setUseYn(codeUseYn);
            if(groupId != null) {
            	 environmentCodeMapper.setGroupId(groupId);
            }else {
            	environmentCodeMapper.setGroupId("GROUP_ID");
            }

            environmentCodeMapper.setRgstId(authUser.getMemberModel().getUserId());
            environmentCodeMapper.setModiId(authUser.getMemberModel().getUserId());

            String result = environmentCodeService.save(environmentCodeMapper);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }



    /**
     * 코드를 삭제한다.
     *
     * @param environmentCodeMapper
     * @return
     */
    @PostMapping("/environmentCode/delete/code")
    public ResponseEntity<String> delete(@ModelAttribute EnvironmentCodeModel environmentCodeMapper, @AuthenticationPrincipal AuthUser authUser) {
        try {
            environmentCodeMapper.setRgstId(authUser.getMemberModel().getUserId());
            environmentCodeMapper.setModiId(authUser.getMemberModel().getUserId());

            String result = environmentCodeService.delete(environmentCodeMapper);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }


}
