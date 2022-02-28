package com.portal.adm.environPrice;

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

import com.portal.adm.environPrice.model.EnvironPriceModel;
import com.portal.adm.environPrice.service.EnvironPriceService;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템관리 / 코드관리 컨트롤러
 */
@Slf4j
@RequestMapping("/system")
@Controller
public class EnvironPriceController {

    @Resource
    private EnvironPriceService environPriceService;
    
    /**
     * 코드관리 페이지로 이동
     *
     * @param model
     * @return
     */
    @GetMapping("/environPrice")
    public String code(@ModelAttribute EnvironPriceModel cnvironPriceModel, Model model) {
    	String codeKey = "";
    	if(cnvironPriceModel.getGroupId() == null) {
    		cnvironPriceModel.setGroupId("GROUP_ID");
    	}
        List<EnvironPriceModel> models = environPriceService.selectGroupIdList(cnvironPriceModel);
        cnvironPriceModel.setTotalCount(environPriceService.selectGroupIdListCount(cnvironPriceModel));
        model.addAttribute("codes", models);
        model.addAttribute("pages", cnvironPriceModel);

        return "environPrice/environPrice";
    }

    /**
     * 코드관리 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @PostMapping("/environPrice")
    public String codePost(@ModelAttribute EnvironPriceModel cnvironPriceModel, Model model) {
    	if(cnvironPriceModel.getGroupId() == null) {
    		cnvironPriceModel.setGroupId("GROUP_ID");
    	}
        List<EnvironPriceModel> models = environPriceService.selectGroupIdList(cnvironPriceModel);
        cnvironPriceModel.setTotalCount(environPriceService.selectGroupIdListCount(cnvironPriceModel));
        model.addAttribute("codes", models);
        model.addAttribute("pages", cnvironPriceModel);

        return "environPrice/environPrice";
    }

    /**
     * 코드그룹을 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/environPrice/insert")
    public ResponseEntity<String> groupSave(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
            EnvironPriceModel cnvironPriceModel = new EnvironPriceModel();
            for (String key : request.getParameterMap().keySet()) {
            	log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
            }
            String groupId = request.getParameter("groupId");
            String codeId = request.getParameter("codeId");
            String codeNm = request.getParameter("codeNm");
            String codeDesc = request.getParameter("codeDsc");
            String codeUseYn = request.getParameter("useYn");

            cnvironPriceModel.setCodeId(codeId);
            cnvironPriceModel.setCodeNm(codeNm);
            cnvironPriceModel.setCodeDsc(codeDesc);
            cnvironPriceModel.setUseYn(codeUseYn);
            if(groupId != null) {
            	 cnvironPriceModel.setGroupId(groupId);
            }else {
            	cnvironPriceModel.setGroupId("GROUP_ID");
            }

            cnvironPriceModel.setRgstId(authUser.getMemberModel().getUserId());
            cnvironPriceModel.setModiId(authUser.getMemberModel().getUserId());

            String result = environPriceService.save(cnvironPriceModel);

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
    @PostMapping("/environPrice/delete")
    public ResponseEntity<String> groupDelete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {
            EnvironPriceModel cnvironPriceModel = new EnvironPriceModel();

            String codeId = request.getParameter("codeId");

            cnvironPriceModel.setCodeId(codeId);
            cnvironPriceModel.setGroupId("GROUP_ID");

            cnvironPriceModel.setRgstId(authUser.getMemberModel().getUserId());
            cnvironPriceModel.setModiId(authUser.getMemberModel().getUserId());

            String result = environPriceService.delete(cnvironPriceModel);

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
    @RequestMapping(value="/environPrice/detail/{codeId}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<EnvironPriceModel> codesForGroupCd(@ModelAttribute EnvironPriceModel cnvironPriceModel, @PathVariable("codeId") String codeId) {
    	cnvironPriceModel.setCodeId(codeId);
    	cnvironPriceModel.setGroupId("GROUP_ID");
        cnvironPriceModel = environPriceService.select(cnvironPriceModel);

        return new ResponseEntity<>(cnvironPriceModel, HttpStatus.OK);
    }
    
    
    /**
     * 그룹코드 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping("/environPrice/detail/environPrice/{groupCd}")
    public ResponseEntity<List<EnvironPriceModel>> codesForCodeCd(@PathVariable("groupCd") String groupId) {
    	List<EnvironPriceModel> cnvironPriceModels = environPriceService.selectGroupIdAllList(groupId);
    	
    	return new ResponseEntity<>(cnvironPriceModels, HttpStatus.OK);
    }

    /**
     * 코드를 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param cnvironPriceModel
     * @return
     */
    @PostMapping("/environPrice/insert/price")
    public ResponseEntity<String> save(@ModelAttribute EnvironPriceModel cnvironPriceModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
            for (String key : request.getParameterMap().keySet()) {
            	log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
            }
            String groupId = request.getParameter("groupId");
            String codeId = request.getParameter("codeId");
            String codeNm = request.getParameter("codeNm");
            String codeDesc = request.getParameter("codeDsc");
            String codeUseYn = request.getParameter("code_useYn");

            cnvironPriceModel.setCodeId(codeId);
            cnvironPriceModel.setCodeNm(codeNm);
            cnvironPriceModel.setCodeDsc(codeDesc);
            cnvironPriceModel.setUseYn(codeUseYn);
            if(groupId != null) {
            	 cnvironPriceModel.setGroupId(groupId);
            }else {
            	cnvironPriceModel.setGroupId("GROUP_ID");
            }

            cnvironPriceModel.setRgstId(authUser.getMemberModel().getUserId());
            cnvironPriceModel.setModiId(authUser.getMemberModel().getUserId());

            String result = environPriceService.save(cnvironPriceModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }



    /**
     * 코드를 삭제한다.
     *
     * @param cnvironPriceModel
     * @return
     */
    @PostMapping("/environPrice/delete/price")
    public ResponseEntity<String> delete(@ModelAttribute EnvironPriceModel cnvironPriceModel, @AuthenticationPrincipal AuthUser authUser) {
        try {
            cnvironPriceModel.setRgstId(authUser.getMemberModel().getUserId());
            cnvironPriceModel.setModiId(authUser.getMemberModel().getUserId());

            String result = environPriceService.delete(cnvironPriceModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }


}
