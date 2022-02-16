package com.portal.adm.common;

import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.portal.adm.alarm.model.AlarmModel;
import com.portal.adm.alarm.service.AlarmService;
import com.portal.adm.member.model.MemberModel;
import com.portal.common.IdUtil;
import com.portal.config.security.mapper.SecurityMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 스프링 시큐리티 로그인등의 페이지를 커스텀하기 위한 컨트롤러
 */
@Controller
@Slf4j
public class LoginController {
	
	@Resource(name = "securityMapper")
	private SecurityMapper securityMapper;
	
    @Resource
    private IdUtil idUtil;
    
    @Resource
    private AlarmService alarmService;
    
	/**
	 * 로그인
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/login", method= {RequestMethod.GET,RequestMethod.POST})
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
		log.debug("call /login");
		Object obj = request.getSession().getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
		if (obj != null && obj instanceof Exception) {
			Exception e = (Exception) obj;
			model.addAttribute("result",e.getMessage());
			request.getSession().removeAttribute("SPRING_SECURITY_LAST_EXCEPTION");
		}
		return "/login";
	}
	
	/**
	 * 비밀번호 변경
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/login/pwdChange", method= {RequestMethod.GET,RequestMethod.POST})
	public String pwdChange(HttpServletRequest request, HttpServletResponse response, Model model) {
		log.debug("call /login/pwdChange");
		
		MemberModel member = new MemberModel();
		
		Map<String,String> param = new HashMap<String,String>();
		param.put("userId", request.getParameter("ch_userId"));
		param.put("password", request.getParameter("ch_pwdOld"));
		
		member = securityMapper.selectUserPassCheck(param);
		if(member != null){
			member.setUserId(request.getParameter("ch_userId"));
			member.setPassword(request.getParameter("ch_pwdOld"));
			member.setNewPassword(request.getParameter("ch_pwdNew"));
			securityMapper.updateUserPassword(member);
		}else{
			model.addAttribute("changeRes","사용자 또는 비밀번호가 틀립니다.");
		}
		
		
		return "/login";
	}
	
	/**
	 * 비밀번호 초기화
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/login/pwdChangeInit", method= {RequestMethod.GET,RequestMethod.POST})
	public String pwdChangeInit(HttpServletRequest request, HttpServletResponse response, Model model) {
		log.debug("call /login/pwdChangeInit");
		
		
		MemberModel member = new MemberModel();
		AlarmModel alarmModel = new AlarmModel();
		member.setCompanyNm(request.getParameter("re_companyNm"));
		member.setUserId(request.getParameter("re_userId"));
		member.setUserNm(request.getParameter("re_userNm"));
		
		MemberModel authMember = new MemberModel();
		authMember = alarmService.selectAlarmAuth(member);
		
		
		alarmModel.setSenderId(request.getParameter("re_userId"));
		alarmModel.setRecipientId(authMember.getUserId());
		alarmModel.setRgstId(request.getParameter("re_userId"));
		alarmModel.setModiId(request.getParameter("re_userId"));
		alarmModel.setCheckYn("N");
		
		AlarmModel alarmCheck = alarmService.selectAlarmCheck(alarmModel);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		if(alarmCheck == null) {
			alarmModel.setAlarmId(idUtil.getAlarmId());
			alarmService.save(alarmModel);
			authMember.setPassword("rt12#$");
			securityMapper.updateUserPassword(authMember);
		}else {
			model.addAttribute("resetRes", formatter.format(alarmCheck.getRgstDt())+"에 초기화 신청을 하셧습니다.");
		}
		
		
		return "/login";
	}
}
