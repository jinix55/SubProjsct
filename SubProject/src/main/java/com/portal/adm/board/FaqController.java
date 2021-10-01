package com.portal.adm.board;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.adm.board.model.FaqModel;
import com.portal.adm.board.service.FaqService;
import com.portal.adm.code.service.CodeService;
import com.portal.adm.file.model.FileModel;
import com.portal.adm.file.service.FileService;
import com.portal.common.IdUtil;
import com.portal.common.paging.Criteria;
import com.portal.config.security.AuthUser;

@RequestMapping("/board")
@Controller
public class FaqController {

	@Resource
    private IdUtil idUtil;
	
    @Resource
    private CodeService codeService;	
	
	@Resource
	private FaqService faqService;
	
	@Resource
	private FileService fileService;	
	
    //@GetMapping("/faq")
	@RequestMapping("/faq")
    public String faq(@ModelAttribute Criteria criteria, Model model) {
		List<FaqModel> tmpFaqList = faqService.selectFaqList(criteria);
		FileModel f = new FileModel();
		List<FaqModel> faqList = new ArrayList<FaqModel>();
		for (FaqModel faqModel : tmpFaqList) {
			f.setRefId(faqModel.getFaqId());
			faqModel.setFileList(fileService.selectFileList(f));
			faqList.add(faqModel);
		}
        model.addAttribute("faqList", faqList);
        criteria.setTotalCount(faqService.selectFaqListCount(criteria));
        model.addAttribute("pages", criteria);    	
        return "board/faq/faq";
    }
    
    @PostMapping("/faq")
    public String faq(@ModelAttribute Criteria criteria, RedirectAttributes attributes) {
        attributes.addFlashAttribute("criteria", criteria);
        return "redirect:/board/faq";
    }
    
    @GetMapping("/faq/regist")
    public String regist(Model model) {
    	//FAQ에서 사용하는 공통코드 모두 set
    	faqService.selectAllFaqCodeList(model);
    	
        return "board/faq/faqRegist";
    }    
    
    @GetMapping("/faq/modify/{faqId}")
    public String modify(@PathVariable String faqId, Model model) {
    	//FAQ에서 사용하는 공통코드 모두 set
    	faqService.selectAllFaqCodeList(model);    	
    	
        FaqModel faqModel = new FaqModel();
        faqModel.setFaqId(faqId);
        model.addAttribute("faqInfo", faqService.selectFaq(faqModel));
        
    	//파일 조회
    	FileModel f = new FileModel();
    	f.setRefId(faqId);    	
    	List<FileModel> fileList = fileService.selectFileList(f);
    	JSONArray files = new JSONArray();
    	for(FileModel fm : fileList) {
    		JSONObject obj = new JSONObject();
    		obj.put("fileId", fm.getFileId());
    		obj.put("storageSe", fm.getStorageSe());
    		obj.put("savePath", fm.getSavePath());
    		obj.put("saveFileNm", fm.getSaveFileNm());
    		obj.put("fileNm", fm.getFileNm());
    		obj.put("fileExtsn", fm.getFileExtsn());
    		obj.put("fileSize", fm.getFileSize());
    		obj.put("useYn", fm.getUseYn());
    		obj.put("rgstId", fm.getRgstId());
    		obj.put("rgstDt", fm.getRgstDt());
    		obj.put("modiId", fm.getModiId());
    		obj.put("modiDt", fm.getModiDt());
    		obj.put("bucketNm", fm.getBucketNm());
    		obj.put("fileUrl", fm.getFileUrl());
    		obj.put("fileCl", fm.getFileCl());
    		obj.put("saveFileVer", fm.getSaveFileVer());
    		obj.put("inputStream", fm.getInputStream());
    		obj.put("bytes", fm.getBytes());
    		obj.put("modiByUserYn", fm.getModiByUserYn());
    		obj.put("refId", fm.getRefId());
    		obj.put("refVer", fm.getRefVer());
    		files.put(obj);
    	}
    	
    	model.addAttribute("fileList", fileList);
    	model.addAttribute("fileJsonList", files);        
        
        return "board/faq/faqRegist";
    }	
    
    /**
     * Insert New Info
     * @param noticeId
     * @param model
     * @return
     */
    @PostMapping("/faq/insert")
    public String insert(@ModelAttribute FaqModel faqInfo, @AuthenticationPrincipal AuthUser authUser, Model model) {
    	faqInfo.setRgstId(authUser.getMemberModel().getUserId());
    	faqInfo.setModiId(authUser.getMemberModel().getUserId());
    	faqInfo.setFaqId(idUtil.getFaqId());
    	model.addAttribute("faqInsertInfo", faqService.insertFaq(faqInfo));
    	
    	if(faqInfo.getFileIds() != null) {
	    	for(String fileId : faqInfo.getFileIds()) {
	    		FileModel file = new FileModel();
	    		file.setFileId(fileId);
	    		file.setRefId(faqInfo.getFaqId());
	    		file.setModiId(authUser.getMemberModel().getUserId());
	    		fileService.updateFile(file);
	    	}
    	}    	
    	
    	return "redirect:/board/faq";
    }
    
    /**
     * Update Old Info
     * @param noticeId
     * @param model
     * @return
     */
    @PostMapping("/faq/update")
    public String update(@ModelAttribute FaqModel faqInfo, @AuthenticationPrincipal AuthUser authUser, Model model) {
    	faqInfo.setModiId(authUser.getMemberModel().getUserId());
    	model.addAttribute("faqUpdateInfo", faqService.updateFaq(faqInfo));
    	
    	if(faqInfo.getFileIds() != null) {
    		for(String fileId : faqInfo.getFileIds()) {
    			FileModel file = new FileModel();
    			file.setFileId(fileId);
    			file.setRefId(faqInfo.getFaqId());
    			file.setModiId(authUser.getMemberModel().getUserId());
    			fileService.updateFile(file);
    		}
    	}    	
    	
    	return "redirect:/board/faq";
    }
    
    /**
     * Delete Old Info
     * @param noticeId
     * @param model
     * @return
     */
    @PostMapping("/faq/delete")
    public String delete(@ModelAttribute FaqModel faqInfo, Model model) {
    	model.addAttribute("faqDeleteInfo", faqService.deleteFaq(faqInfo));
    	return "redirect:/board/faq";
    }
	
}
