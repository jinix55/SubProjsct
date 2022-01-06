package com.portal.adm.packagingCode;

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

import com.portal.adm.packagingCode.model.PackagingCodeModel;
import com.portal.adm.packagingCode.service.PackagingCodeService;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템관리 / 코드관리 컨트롤러
 */
@Slf4j
@RequestMapping("/system")
@Controller
public class PackagingCodeController {

    @Resource
    private PackagingCodeService packagingCodeService;
    
    /**
     * 코드관리 페이지로 이동
     *
     * @param model
     * @return
     */
    @GetMapping("/packagingCode")
    public String code(@ModelAttribute PackagingCodeModel packagingCodeMapper, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	String largeCategory = "GROUP_ID";
    	String middleCategory = "";
    	packagingCodeMapper.setGroupId("GROUP_ID");
		packagingCodeMapper.setAuthId(authUser.getMemberModel().getAuthId());
    	packagingCodeMapper.setUpCompanyCode(authUser.getMemberModel().getCompanyCode());
        List<PackagingCodeModel> models = packagingCodeService.selectGroupIdList(packagingCodeMapper);
        packagingCodeMapper.setTotalCount(packagingCodeService.selectGroupIdListCount(packagingCodeMapper));
        model.addAttribute("codes", models);
        model.addAttribute("pages", packagingCodeMapper);

//        if(models.size() > 0) {
//            model.addAttribute("firstCodeId", models.get(0).getCodeId());
//            model.addAttribute("firstCodeNm", models.get(0).getCodeNm());
//            model.addAttribute("firstCodeDsc", models.get(0).getCodeDsc());
//            model.addAttribute("firstCodeUseYn", models.get(0).getUseYn());
//        }

        return "packagingCode/packagingCode";
    }

    /**
     * 코드관리 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @PostMapping("/packagingCode")
    public String codePost(@ModelAttribute PackagingCodeModel packagingCodeMapper, Model model) {
    	if(packagingCodeMapper.getGroupId() == null) {
    		packagingCodeMapper.setGroupId("GROUP_ID");
    	}
        List<PackagingCodeModel> models = packagingCodeService.selectGroupIdList(packagingCodeMapper);
        packagingCodeMapper.setTotalCount(packagingCodeService.selectGroupIdListCount(packagingCodeMapper));
        model.addAttribute("codes", models);
        model.addAttribute("pages", packagingCodeMapper);

        return "packagingCode/packagingCode";
    }

    /**
     * 코드그룹을 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/packagingCode/insert")
    public ResponseEntity<String> groupSave(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
            PackagingCodeModel packagingCodeMapper = new PackagingCodeModel();
            for (String key : request.getParameterMap().keySet()) {
            	log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
            }
            String groupId = request.getParameter("groupId");
            String codeId = request.getParameter("codeId");
            String codeNm = request.getParameter("codeNm");
            String codeDesc = request.getParameter("codeDsc");
            String codeUseYn = request.getParameter("useYn");

            packagingCodeMapper.setCodeId(codeId);
            packagingCodeMapper.setCodeNm(codeNm);
            packagingCodeMapper.setCodeDsc(codeDesc);
            packagingCodeMapper.setUseYn(codeUseYn);
            if(groupId != null) {
            	 packagingCodeMapper.setGroupId(groupId);
            }else {
            	packagingCodeMapper.setGroupId("GROUP_ID");
            }

            packagingCodeMapper.setRgstId(authUser.getMemberModel().getUserId());
            packagingCodeMapper.setModiId(authUser.getMemberModel().getUserId());

            String result = packagingCodeService.save(packagingCodeMapper);

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
    @PostMapping("/packagingCode/delete")
    public ResponseEntity<String> groupDelete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {
            PackagingCodeModel packagingCodeMapper = new PackagingCodeModel();

            String codeId = request.getParameter("codeId");

            packagingCodeMapper.setCodeId(codeId);
            packagingCodeMapper.setGroupId("GROUP_ID");

            packagingCodeMapper.setRgstId(authUser.getMemberModel().getUserId());
            packagingCodeMapper.setModiId(authUser.getMemberModel().getUserId());

            String result = packagingCodeService.delete(packagingCodeMapper);

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
    @RequestMapping(value="/packagingCode/detail/{codeId}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<PackagingCodeModel> codesForGroupCd(@ModelAttribute PackagingCodeModel packagingCodeMapper, @PathVariable("codeId") String codeId) {
    	packagingCodeMapper.setCodeId(codeId);
    	packagingCodeMapper.setGroupId("GROUP_ID");
        packagingCodeMapper = packagingCodeService.select(packagingCodeMapper);

        return new ResponseEntity<>(packagingCodeMapper, HttpStatus.OK);
    }
    
    
    /**
     * 그룹코드 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping("/packagingCode/detail/code/{groupCd}")
    public ResponseEntity<List<PackagingCodeModel>> codesForCodeCd(@PathVariable("groupCd") String groupId) {
    	List<PackagingCodeModel> packagingCodeMappers = packagingCodeService.selectGroupIdAllList(groupId);
    	
    	return new ResponseEntity<>(packagingCodeMappers, HttpStatus.OK);
    }

    /**
     * 코드를 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param packagingCodeMapper
     * @return
     */
    @PostMapping("/packagingCode/insert/code")
    public ResponseEntity<String> save(@ModelAttribute PackagingCodeModel packagingCodeMapper, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
            for (String key : request.getParameterMap().keySet()) {
            	log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
            }
            String groupId = request.getParameter("groupId");
            String codeId = request.getParameter("codeId");
            String codeNm = request.getParameter("codeNm");
            String codeDesc = request.getParameter("codeDsc");
            String codeUseYn = request.getParameter("code_useYn");

            packagingCodeMapper.setCodeId(codeId);
            packagingCodeMapper.setCodeNm(codeNm);
            packagingCodeMapper.setCodeDsc(codeDesc);
            packagingCodeMapper.setUseYn(codeUseYn);
            if(groupId != null) {
            	 packagingCodeMapper.setGroupId(groupId);
            }else {
            	packagingCodeMapper.setGroupId("GROUP_ID");
            }

            packagingCodeMapper.setRgstId(authUser.getMemberModel().getUserId());
            packagingCodeMapper.setModiId(authUser.getMemberModel().getUserId());

            String result = packagingCodeService.save(packagingCodeMapper);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }



    /**
     * 코드를 삭제한다.
     *
     * @param packagingCodeMapper
     * @return
     */
    @PostMapping("/packagingCode/delete/code")
    public ResponseEntity<String> delete(@ModelAttribute PackagingCodeModel packagingCodeMapper, @AuthenticationPrincipal AuthUser authUser) {
        try {
            packagingCodeMapper.setRgstId(authUser.getMemberModel().getUserId());
            packagingCodeMapper.setModiId(authUser.getMemberModel().getUserId());

            String result = packagingCodeService.delete(packagingCodeMapper);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }


}
