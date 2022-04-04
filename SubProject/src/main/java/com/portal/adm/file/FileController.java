package com.portal.adm.file;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartRequest;

import com.portal.adm.file.model.FileModel;
import com.portal.adm.file.service.FileService;
import com.portal.common.annotation.NoLogging;
import com.portal.config.security.AuthUser;

/**
 * File Upload and Download Controller
 */
@Controller
public class FileController {

	@Resource(name="fileService")
	private FileService service;
	
	
	/**
	 * File Upload
	 * @param request
	 * @param multipart
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/file/list/{refId}", method=RequestMethod.GET)
	public ResponseEntity<List<FileModel>> selectList(HttpServletRequest request, @PathVariable String refId, @AuthenticationPrincipal AuthUser authUser) {
		//파일 조회
		FileModel f = new FileModel();
		f.setRefId(refId);    	
		List<FileModel> fileList = service.selectFileList(f);
		
		return new ResponseEntity<>(fileList, HttpStatus.OK);
	}
	
	/**
	 * File Upload
	 * @param request
	 * @param multipart
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/file/insert", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_VALUE)
	public Map<String,Object> upload(HttpServletRequest request, MultipartRequest multipart, @AuthenticationPrincipal AuthUser authUser) {
		Map<String,Object> result = service.upload(request, multipart, authUser);
		return result;
	}
	
	/**
	 * File Download
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/file/detail/{uuid}", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<ByteArrayResource> download(HttpServletRequest request, @PathVariable String uuid) {
		ResponseEntity<ByteArrayResource> result = service.download(uuid);
		return result;
	}
	
	/**
	 * File delete
	 * @param request
	 * @param multipart
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/file/delete/{uuid}", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_VALUE)
	public Map<String,Object> delete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser, @ModelAttribute FileModel fileModel, @PathVariable String uuid) {
		
		//Map<String,Object> result = null;
		Map<String,Object> result = new HashMap<String, Object>();
		fileModel.setFileId(uuid);
		fileModel = service.selectFile(fileModel);
//		fileModel.setFileUrl(uuid);
		fileModel.setUseYn("N");
		fileModel.setModiId(authUser.getMemberModel().getUserId());
		long cnt = service.deleteFile(fileModel);

		result.put("cnt", cnt);
		//파일 조회
		//FileModel file = service.selectFile(fileModel);
		
		//result = service.delete(request, file, authUser);
		return result;
	}
	
	/**
	 * Tableau preview Download
	 * @param request
	 * @return
	 */
	@NoLogging
	@RequestMapping(value="/file/preview/{uuid}", method=RequestMethod.GET)
	public ResponseEntity<ByteArrayResource> previewUrl(HttpServletRequest request, @PathVariable String uuid) {
		ResponseEntity<ByteArrayResource> result = service.getPreview(request, uuid);
		return result;
	}
	
	/**
	 * Tableau view Download
	 * @param request
	 * @return
	 */
	@NoLogging
	@RequestMapping(value="/file/view/{uuid}", method=RequestMethod.GET)
	public ResponseEntity<ByteArrayResource> viewUrl(HttpServletRequest request, @PathVariable String uuid) {
		ResponseEntity<ByteArrayResource> result = service.getView(request, uuid);
		return result;
	}
	
	/**
	 * 사원 사진 Download - 특정 사용자 사진
	 * @param request
	 * @return
	 */
	@NoLogging
	@RequestMapping(value="/file/photo/{uuid}", method=RequestMethod.GET)
	public ResponseEntity<ByteArrayResource> userPhotoUrl(HttpServletRequest request, @PathVariable String uuid) {
		ResponseEntity<ByteArrayResource> result = service.getUserPhoto(request, uuid);
		return result;
	}

	/**
	 * 사원 사진 Download - 로그인 사용자 사진
	 * @param request
	 * @return
	 */
	@NoLogging
	@RequestMapping(value="/file/photo", method=RequestMethod.GET)
	public ResponseEntity<ByteArrayResource> userPhoto(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
		ResponseEntity<ByteArrayResource> result = service.getUserPhoto(request, authUser);
		return result;
	}
	
	/**
	 * editor 이미지 Download
	 * @param request
	 * @return
	 */
	@NoLogging
	@RequestMapping(value="/file/edimage/{uuid}", method=RequestMethod.GET)
	public ResponseEntity<ByteArrayResource> editorImageUrl(HttpServletRequest request, @PathVariable String uuid) {
		ResponseEntity<ByteArrayResource> result = service.getEditorImage(request, uuid);
		return result;
	}
}
