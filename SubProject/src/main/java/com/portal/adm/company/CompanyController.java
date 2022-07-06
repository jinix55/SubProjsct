package com.portal.adm.company;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.portal.adm.company.model.CompanyModel;
import com.portal.adm.company.service.CompanyService;
import com.portal.adm.file.model.FileModel;
import com.portal.adm.file.service.FileService;
import com.portal.adm.member.model.MemberCriteria;
import com.portal.adm.member.model.MemberModel;
import com.portal.adm.member.service.MemberService;
import com.portal.common.Constant;
import com.portal.common.IdUtil;
import com.portal.config.security.AuthUser;
import com.portal.config.security.mapper.SecurityMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템관리 / 회사관리 컨트롤러
 */
@Slf4j
@RequestMapping("/system")
@Controller
public class CompanyController {

    @Resource
    private CompanyService companyService;
    
    @Resource(name = "securityMapper")
	private SecurityMapper securityMapper;
    
    @Resource
    private MemberService memberService;
    
    @Resource(name="fileService")
	private FileService fileService;
    
    @Resource
    private IdUtil idUtil;
    
    /**
     * 회사관리 페이지로 이동
     *
     * @param model
     * @return
     */
    @GetMapping("/company")
    public String company(@ModelAttribute CompanyModel companyModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	
    	companyModel.setCompanyCode(authUser.getMemberModel().getCompanyCode());
    	companyModel.setAuthId(authUser.getMemberModel().getAuthId());

    	
        List<CompanyModel> models = companyService.selectCompanyList(companyModel);
        companyModel.setTotalCount(companyService.selectCompanyListCount(companyModel));
        model.addAttribute("companys", models);
        model.addAttribute("pages", companyModel);
        
        return "company/companyMgt";
    }

    /**
     * 회사관리 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @PostMapping("/company")
    public String companyPost(@ModelAttribute CompanyModel companyModel, Model model) {
        List<CompanyModel> models = companyService.selectCompanyList(companyModel);
        companyModel.setTotalCount(companyService.selectCompanyListCount(companyModel));
        model.addAttribute("companys", models);
        model.addAttribute("pages", companyModel);
        
        return "company/companyMgt";
    }

    /**
     * 회사그룹을 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param request
     * @return
     */
//    @PostMapping("/company/insert")
    @RequestMapping(value="/company/insert" , method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String companySave(@ModelAttribute CompanyModel companyModel, MultipartRequest multipart, @AuthenticationPrincipal AuthUser authUser) {
    		String result = null;
    		String companyId = companyModel.getCompanyId();
    		boolean saveYn = false;
    		if(StringUtils.equals(companyId, null) || StringUtils.equals(companyId, "")) {
    			if(StringUtils.equals(authUser.getMemberModel().getAuthCl(), "P")) {
    				saveYn = true;
    			}
    		}else {
    			if(StringUtils.equals(authUser.getMemberModel().getAuthCl(), "P") || StringUtils.equals(authUser.getMemberModel().getAuthCl(), "A")) {
    				saveYn = true;
    			}
    		}
    		if(saveYn) {
    			
//    			CompanyModel companyModel = new CompanyModel();
//    			for (String key : request.getParameterMap().keySet()) {
//    				log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
//    			}
//    			String companyCode = request.getParameter("companyCode");
//    			String companyNo = request.getParameter("companyNo");
//    			String companyNm = request.getParameter("companyNm");
//    			String companyDesc = request.getParameter("companyDsc");
//    			String address = request.getParameter("address");
//    			String telephoneNo = request.getParameter("telephoneNo");
//    			String representativeNm = request.getParameter("representativeNm");
//    			String note = request.getParameter("note");
//    			String useYn = request.getParameter("useYn");
    			
    			if(StringUtils.equals(companyId, null) || StringUtils.equals(companyId, "")) {
    				companyId = idUtil.getCompanyId();
    			}
    			companyModel.setCompanyId(companyId);
//    			companyModel.setCompanyCode(companyCode);
//    			companyModel.setCompanyNo(companyNo);
//    			companyModel.setCompanyNm(companyNm);
//    			companyModel.setCompanyDsc(companyDesc);
//    			companyModel.setAddress(address);
//    			companyModel.setTelephoneNo(telephoneNo);
//    			companyModel.setRepresentativeNm(representativeNm);
//    			companyModel.setNote(note);
//    			companyModel.setUseYn(useYn);
    			
    			companyModel.setRgstId(authUser.getMemberModel().getUserId());
    			companyModel.setModiId(authUser.getMemberModel().getUserId());
    			
    			String fileUrl = "C:/PPLUS/" + companyModel.getCompanyCode() + "/";
    			final Map<String, MultipartFile> files = multipart.getFileMap();
    			MultipartFile file = null;
    			for (String key : files.keySet()) {
    				file = files.get(key);
    				if (file.getOriginalFilename().equals("")) {
    					continue;
    				}
        			
        			FileModel f = new FileModel();
    				f.setFileId(idUtil.getFileId());
    				
    				// s3 기본 처리
        			f.setStorageSe("LOCAL");
        			f.setFileNm(file.getOriginalFilename());
        			f.setFileExtsn(FilenameUtils.getExtension(file.getOriginalFilename()));
        			f.setFileSize(file.getSize());
        			f.setFileUrl(fileUrl+f.getFileId() + "/");
        			f.setUseYn("Y");
        			f.setRefId(companyModel.getCompanyCode());
        			f.setRgstId(authUser.getMemberModel().getUserId());
        			f.setModiId(authUser.getMemberModel().getUserId());
        			f.setFileCl(Constant.File.API);
        			
        			try {
        				f.setInputStream(file.getResource().getInputStream());
        			} catch (IOException e) {
        				result = "fail";
        			}
        			
        			// 파일 생성
        			if (!"fail".equals(result)) {
        				fileService.insertFile(f);
        				
        				companyModel.setLogoFileId(f.getFileId());
        				Path directoryPath = Paths.get(fileUrl+f.getFileId() + "/");

        				try {
        					Files.createDirectories(directoryPath);
        				} catch (IOException e1) {
//        					return "1.파일 생성시 오류났습니다.";
        				}

        				try {
        					FileOutputStream fos = new FileOutputStream(fileUrl+f.getFileId() + "/" + file.getOriginalFilename());

        					InputStream is = file.getInputStream();

        					int readCount = 0;
        					byte[] buffer = new byte[1024];
        					// 파일을 읽을 크기 만큼의 buffer를 생성하고
        					// ( 보통 1024, 2048, 4096, 8192 와 같이 배수 형식으로 버퍼의 크기를 잡는 것이 일반적이다.)
        					while ((readCount = is.read(buffer)) != -1) {
        						// 파일에서 가져온 fileInputStream을 설정한 크기 (1024byte) 만큼 읽고
        						fos.write(buffer, 0, readCount);
        						// 위에서 생성한 fileOutputStream 객체에 출력하기를 반복한다
        					}
        				} catch (FileNotFoundException e) {
//        					return "1.FileNotFoundException.";
        				}
        				catch (IOException e) {
//        					return "1.IOException.";
        				}
        			}
    			}
    			
    			result = companyService.save(companyModel);
    			
    			//company 등록 후 사이트 관리자 자동 등록 해줌
    			if("Insert".equals(result)) {
    				MemberModel memberModel = new MemberModel();
    				//저장시 회사코드와 같이 적용
    				memberModel.setUserId("admin@"+companyModel.getCompanyCode());
    				memberModel.setPassword("admin");
//    				memberModel.setEmail("admin@"+companyModel.getCompanyCode().toLowerCase()+".pplusecho.com");
    				memberModel.setUserNm("사이트 관리자");
    				memberModel.setAuthId("au2000002");
    				memberModel.setPassInit("Y");
    				memberModel.setDtLimitYn("N");
    				memberModel.setUseYn("Y");
    				memberModel.setCompanyCode(companyModel.getCompanyCode());
    				memberModel.setRgstId(authUser.getMemberModel().getUserId());
    				memberModel.setModiId(authUser.getMemberModel().getUserId());
    				result = memberService.insert(memberModel);
    			}

    		}else {
    			result = "권한이 없습니다./n관리자에게 문의하세요.";
    		}

    		return result;
    }
    
    /**
     * 회사그룹을 삭제한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/company/popup")
    @ResponseBody
    public String companySelect(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
    		String result = null;
    		if(StringUtils.equals(authUser.getMemberModel().getAuthCl(), "P")) {
    			
    			String searchCode = request.getParameter("search");
    			
    			String comapnyCdoe = companyService.selectCode(searchCode);
				if( comapnyCdoe == null || StringUtils.equals(comapnyCdoe, "")) {
					return searchCode.toUpperCase();
				}else {
					return "none";
				}
    		} else {
    			result = "권한이 없습니다./n관리자에게 문의하세요.";
    		}
    		
    		return result;
    	} catch (Exception e) {
    		return "권한이 없습니다./n관리자에게 문의하세요.";
    	}
    }
    
    /**
     * 회사그룹을 삭제한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/company/delete")
    @ResponseBody
    public String companyDelete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {
        	 String result = null;
        	if(StringUtils.equals(authUser.getMemberModel().getAuthCl(), "P")) {
	            CompanyModel companyModel = new CompanyModel();
	
	            String companyId = request.getParameter("companyId");
	            companyModel.setCompanyId(companyId);
	
	            companyModel.setModiId(authUser.getMemberModel().getUserId());
	
	            result = companyService.delete(companyModel);
        	} else {
        		result = "권한이 없습니다./n관리자에게 문의하세요.";
        	}

            return result;
        } catch (Exception e) {
            return "권한이 없습니다./n관리자에게 문의하세요.";
        }
    }
    
    /**
     * 회사 정보를 조회한다.
     *
     * @param companyId
     * @return
     */
    @PostMapping("/company/detail/{companyId}")
    @ResponseBody
    public CompanyModel getCompanysForCompanyId(@PathVariable("companyId") String companyId) {
		CompanyModel companyModels = companyService.selectCompanyId(companyId);

        return companyService.selectCompanyId(companyId);
    }
    
    @GetMapping("/company/detail/{companyCode}/members")
    @ResponseBody
    public List<MemberModel> getMembers(@PathVariable String companyCode, @ModelAttribute MemberCriteria criteria, @ModelAttribute MemberModel memberModel, @AuthenticationPrincipal AuthUser authUser) {
    	if("au2000001".equals(authUser.getMemberModel().getAuthId())) {
        	criteria.setCompanyCode(companyCode);
        }else {
        	criteria.setCompanyCode(authUser.getMemberModel().getCompanyCode());
        }
    	return memberService.selectMemberList(criteria);
    }
    
    @GetMapping("/company/detail/{companyCode}/members/{memberId}")
    @ResponseBody
    public MemberModel selectPopup(@PathVariable String companyCode, @PathVariable String memberId, Model model) {
    	MemberModel memberModel = new MemberModel();
    	memberModel.setUserId(memberId+"@"+companyCode);
    	return memberService.selectMember(memberModel);
    }
    
    @PostMapping("/company/update/{companyCode}/members")
    public ResponseEntity<String> update(HttpServletRequest request,
    								   @PathVariable String companyCode, 
                                       @ModelAttribute MemberModel memberModel,
                                       @AuthenticationPrincipal AuthUser authUser) {

        try {
            if(!StringUtils.isEmpty(request.getParameter("dateFrom"))) {
                memberModel.setStartDt(LocalDateTime.parse(request.getParameter("dateFrom") + "T" + LocalTime.now().toString()));
            }
            if(!StringUtils.isEmpty(request.getParameter("dateTo"))) {
                memberModel.setEndDt(LocalDateTime.parse(request.getParameter("dateTo")+"T"+LocalTime.now().toString()));
            }

            memberModel.setRgstId(authUser.getMemberModel().getUserId());
            memberModel.setModiId(authUser.getMemberModel().getUserId());

            memberModel.setUserId(memberModel.getUserId()+"@"+memberModel.getCompanyCode());	
            String result = memberService.save(memberModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    @PostMapping("/company/insert/{companyCode}/members")
    public ResponseEntity<String> insert(HttpServletRequest request,
							    		@PathVariable String companyCode, 
							    		@ModelAttribute MemberModel memberModel,
                                        @AuthenticationPrincipal AuthUser authUser) {
		for (String key : request.getParameterMap().keySet()) {
//			log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
		}
		String subdomain = request.getServerName().split("\\.")[0];
        try {
            if(!StringUtils.isEmpty(request.getParameter("dateFrom"))) {
                memberModel.setStartDt(LocalDateTime.parse(request.getParameter("dateFrom") + "T" + LocalTime.now().toString()));
            }
            if(!StringUtils.isEmpty(request.getParameter("dateTo"))) {
                memberModel.setEndDt(LocalDateTime.parse(request.getParameter("dateTo")+"T"+LocalTime.now().toString()));
            }

            memberModel.setRgstId(authUser.getMemberModel().getUserId());
            memberModel.setModiId(authUser.getMemberModel().getUserId());
            //저장시 회사코드와 같이 적용
            memberModel.setPassword(memberModel.getUserId());
            memberModel.setUserId(memberModel.getUserId()+"@"+memberModel.getCompanyCode());	
            memberModel.setPassInit("Y");
            String result = memberService.insert(memberModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    @PostMapping("/company/delete/{companyCode}/members")
    public ResponseEntity<String> delete(HttpServletRequest request,
    									@PathVariable String companyCode, 
                                        @ModelAttribute MemberModel memberModel,
                                        @AuthenticationPrincipal AuthUser authUser) {
		for (String key : request.getParameterMap().keySet()) {
			log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
		}
        try {

            memberModel.setModiId(authUser.getMemberModel().getUserId()+"@"+memberModel.getCompanyCode());
            memberModel.setUserId(memberModel.getUserId()+"@"+memberModel.getCompanyCode());
            String result = memberService.delete(memberModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    @PostMapping("/company/detail/popup/{companyCode}/members/{memberId}")
    @ResponseBody
    public String select(@PathVariable String memberId, @PathVariable String companyCode, Model model) {
        MemberModel memberModel = new MemberModel();
        if(!StringUtils.equals(memberId, "")) {
        	memberModel.setUserId(memberId+"@"+companyCode);
        	memberModel = memberService.selectMember(memberModel);
        }
        
        if(memberModel == null) {
        	return memberId;
        }else {
        	return "none";
        }
        
    }
    
    /**
     * 회사관리 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @PostMapping("/company/detail/{companyCode}/members/{memberId}/login")
    @ResponseBody
    public String login(HttpServletRequest request, @PathVariable String companyCode, @PathVariable String memberId, @ModelAttribute MemberModel memberModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	String result = "N";
    	if(StringUtils.equals(authUser.getMemberModel().getAuthCl(), "P") || StringUtils.equals(authUser.getMemberModel().getAuthCl(), "A")) {
    		result = "Y";
    		HttpSession session = request.getSession();
    		if(session != null) {
    			session.setAttribute("loginId", memberModel.getUserId()+"@"+companyCode);
    		}
		}
        return result;
    }
    
    /**
     * 회사관리 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @PostMapping("/company/detail/{companyCode}/members/{memberId}/initPassword")
    @ResponseBody
    public String updatePasswordInit(HttpServletRequest request, @PathVariable String companyCode, @PathVariable String memberId, @ModelAttribute MemberModel memberModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	String result = "N";
    	if(StringUtils.equals(authUser.getMemberModel().getAuthCl(), "P") || StringUtils.equals(authUser.getMemberModel().getAuthCl(), "A")) {
    		memberModel.setNewPassword(memberId);
    		memberModel.setUserId(memberId+"@"+companyCode);
    		securityMapper.updatePasswordInit(memberModel);
    		result = "Y";
		}
        return result;
    }
    
}
