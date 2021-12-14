package com.portal.adm.code;

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

import com.portal.adm.code.model.CodeModel;
import com.portal.adm.code.service.CodeService;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템관리 / 코드관리 컨트롤러
 */
@Slf4j
@RequestMapping("/system")
@Controller
public class CodeController {

    @Resource
    private CodeService codeService;
    
    /**
     * 코드관리 페이지로 이동
     *
     * @param model
     * @return
     */
    @GetMapping("/code")
    public String code(@ModelAttribute CodeModel codeModel, Model model) {
    	String codeKey = "";
    	if(codeModel.getGroupId() == null) {
    		codeModel.setGroupId("GROUP_ID");
    	}
        List<CodeModel> models = codeService.selectGroupIdList(codeModel);
        codeModel.setTotalCount(codeService.selectGroupIdListCount(codeModel));
        model.addAttribute("codes", models);
        model.addAttribute("pages", codeModel);

//        if(models.size() > 0) {
//            model.addAttribute("firstCodeId", models.get(0).getCodeId());
//            model.addAttribute("firstCodeNm", models.get(0).getCodeNm());
//            model.addAttribute("firstCodeDsc", models.get(0).getCodeDsc());
//            model.addAttribute("firstCodeUseYn", models.get(0).getUseYn());
//        }

        return "code/code";
    }

    /**
     * 코드관리 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @PostMapping("/code")
    public String codePost(@ModelAttribute CodeModel codeModel, Model model) {
    	if(codeModel.getGroupId() == null) {
    		codeModel.setGroupId("GROUP_ID");
    	}
        List<CodeModel> models = codeService.selectGroupIdList(codeModel);
        codeModel.setTotalCount(codeService.selectGroupIdListCount(codeModel));
        model.addAttribute("codes", models);
        model.addAttribute("pages", codeModel);

        return "code/code";
    }

    /**
     * 코드그룹을 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/code/insert")
    public ResponseEntity<String> groupSave(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
            CodeModel codeModel = new CodeModel();
            for (String key : request.getParameterMap().keySet()) {
            	log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
            }
            String groupId = request.getParameter("groupId");
            String codeId = request.getParameter("codeId");
            String codeNm = request.getParameter("codeNm");
            String codeDesc = request.getParameter("codeDsc");
            String codeUseYn = request.getParameter("useYn");

            codeModel.setCodeId(codeId);
            codeModel.setCodeNm(codeNm);
            codeModel.setCodeDsc(codeDesc);
            codeModel.setUseYn(codeUseYn);
            if(groupId != null) {
            	 codeModel.setGroupId(groupId);
            }else {
            	codeModel.setGroupId("GROUP_ID");
            }

            codeModel.setRgstId(authUser.getMemberModel().getUserId());
            codeModel.setModiId(authUser.getMemberModel().getUserId());

            String result = codeService.save(codeModel);

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
    @PostMapping("/code/delete")
    public ResponseEntity<String> groupDelete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {
            CodeModel codeModel = new CodeModel();

            String codeId = request.getParameter("codeId");

            codeModel.setCodeId(codeId);
            codeModel.setGroupId("GROUP_ID");

            codeModel.setRgstId(authUser.getMemberModel().getUserId());
            codeModel.setModiId(authUser.getMemberModel().getUserId());

            String result = codeService.delete(codeModel);

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
    @RequestMapping(value="/code/detail/{codeId}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<CodeModel> codesForGroupCd(@ModelAttribute CodeModel codeModel, @PathVariable("codeId") String codeId) {
    	codeModel.setCodeId(codeId);
    	codeModel.setGroupId("GROUP_ID");
        codeModel = codeService.select(codeModel);

        return new ResponseEntity<>(codeModel, HttpStatus.OK);
    }
    
    
    /**
     * 그룹코드 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping("/code/detail/code/{groupCd}")
    public ResponseEntity<List<CodeModel>> codesForCodeCd(@PathVariable("groupCd") String groupId) {
    	List<CodeModel> codeModels = codeService.selectGroupIdAllList(groupId);
    	
    	return new ResponseEntity<>(codeModels, HttpStatus.OK);
    }

    /**
     * 코드를 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param codeModel
     * @return
     */
    @PostMapping("/code/insert/code")
    public ResponseEntity<String> save(@ModelAttribute CodeModel codeModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
            for (String key : request.getParameterMap().keySet()) {
            	log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
            }
            String groupId = request.getParameter("groupId");
            String codeId = request.getParameter("codeId");
            String codeNm = request.getParameter("codeNm");
            String codeDesc = request.getParameter("codeDsc");
            String codeUseYn = request.getParameter("code_useYn");

            codeModel.setCodeId(codeId);
            codeModel.setCodeNm(codeNm);
            codeModel.setCodeDsc(codeDesc);
            codeModel.setUseYn(codeUseYn);
            if(groupId != null) {
            	 codeModel.setGroupId(groupId);
            }else {
            	codeModel.setGroupId("GROUP_ID");
            }

            codeModel.setRgstId(authUser.getMemberModel().getUserId());
            codeModel.setModiId(authUser.getMemberModel().getUserId());

            String result = codeService.save(codeModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }



    /**
     * 코드를 삭제한다.
     *
     * @param codeModel
     * @return
     */
    @PostMapping("/code/delete/code")
    public ResponseEntity<String> delete(@ModelAttribute CodeModel codeModel, @AuthenticationPrincipal AuthUser authUser) {
        try {
            codeModel.setRgstId(authUser.getMemberModel().getUserId());
            codeModel.setModiId(authUser.getMemberModel().getUserId());

            String result = codeService.delete(codeModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }


}
