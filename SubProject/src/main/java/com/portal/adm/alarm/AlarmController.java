package com.portal.adm.alarm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.adm.alarm.model.AlarmModel;
import com.portal.adm.alarm.service.AlarmService;
import com.portal.common.ApiRequestUtil;
import com.portal.common.IdUtil;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 알람 컨트롤러
 */
@Slf4j
@RequestMapping("/alarm")
@Controller
public class AlarmController {

    @Resource
    private AlarmService alarmService;
    
    @Resource
    private IdUtil idUtil;
    
    @Resource
    private ApiRequestUtil apiRequestUtil;
    
    /**
     * 알람관리 페이지로 이동
     *
     * @param model
     * @return
     */
    @GetMapping("/alarm")
    public String alarmGet(@ModelAttribute AlarmModel alarmModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	log.info(" =============== alarm get in ==============");
    	List<AlarmModel> models = null;
    	alarmModel.setRecipientId(authUser.getMemberModel().getUserId());
        models = alarmService.selectAlarmList(alarmModel);
        alarmModel.setTotalCount(alarmService.selectAlarmListCount(alarmModel));
        model.addAttribute("alarms", models);
        model.addAttribute("pages", alarmModel);
        
        return "alarm/alarmMgt";
    }

    /**
     * 알람관리 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @PostMapping("/alarm")
    public String alarmPost(@ModelAttribute AlarmModel alarmModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	log.info(" =============== alarm get in ==============");
    	List<AlarmModel> models = null;
    	alarmModel.setRecipientId(authUser.getMemberModel().getUserId());
        models = alarmService.selectAlarmList(alarmModel);
        alarmModel.setTotalCount(alarmService.selectAlarmListCount(alarmModel));
        model.addAttribute("alarms", models);
        model.addAttribute("pages", alarmModel);
        
        return "alarm/alarmMgt";
    }

    /**
     * 알람그룹을 저장한다. 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/alarm/insert")
    public ResponseEntity<String> alarmSave(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
			AlarmModel alarmModel = new AlarmModel();
			for (String key : request.getParameterMap().keySet()) {
				log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
			}
			String sj = request.getParameter("sj");
			String cn = request.getParameter("cn");
			String alarmSe = request.getParameter("alarmSe");
			String recipientId = request.getParameter("recipientId");
			
			alarmModel.setAlarmId(idUtil.getAlarmId());
			alarmModel.setSj(sj);
			alarmModel.setCn(cn);
			alarmModel.setAlarmSe(alarmSe);
			alarmModel.setSenderId(authUser.getMemberModel().getUserId());
			alarmModel.setRecipientId(recipientId);
			
			alarmModel.setRgstId(authUser.getMemberModel().getUserId());
			alarmModel.setModiId(authUser.getMemberModel().getUserId());
			
			String result = alarmService.save(alarmModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    /**
     * 알람을 확인하면 비활성화 한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/alarm/delete")
    public ResponseEntity<String> alarmDelete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {
        	 String result = null;
        	if(StringUtils.equals(authUser.getMemberModel().getAuthCl(), "P")) {
	            AlarmModel alarmModel = new AlarmModel();
	
	            String alarmId = request.getParameter("alarmId");
	
	            alarmModel.setAlarmId(alarmId);
	            alarmModel.setModiId(authUser.getMemberModel().getUserId());
	
	            result = alarmService.delete(alarmModel);
        	} else {
        		result = "권한이 없습니다./n관리자에게 문의하세요.";
        	}

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }    
    
    /**
     * 알람 정보를 조회한다.
     *
     * @param alarmId
     * @return
     */
    @PostMapping("/alarm/detail/{alarmId}")
    public ResponseEntity<AlarmModel> getAlarmsForAlarmId(@PathVariable("alarmId") String alarmId, @AuthenticationPrincipal AuthUser authUser) {
    	AlarmModel alarmModels = new AlarmModel();
    	alarmModels.setAlarmId(alarmId);
    	alarmModels.setModiId(authUser.getMemberModel().getUserId());
		alarmModels = alarmService.selectAlarmId(alarmModels);

        return new ResponseEntity<>(alarmModels, HttpStatus.OK);
    }
    
    /**
     * 알람 정보를 ajax 조회한다.
     *
     * @param alarmId
     * @return
     */
    @GetMapping("/alarm/detail")
    @ResponseBody
    public Map<String,Object> getAjaxAlarmsForUserId(@AuthenticationPrincipal AuthUser authUser) {
    	log.info(" =============== getAjaxAlarmsForUserId ajax in ==============");
    	Map<String,Object> result = new HashMap<String, Object>();
    	List<AlarmModel> alarmList = alarmService.selectAlarmUserId(authUser.getMemberModel().getUserId());
//    	apiRequestUtil.requesKakaoAdressGet(null, null);
//    	apiRequestUtil.requesGetDust(null, null);
//    	apiRequestUtil.requesGetWeather(null, null);
    	
    	result.put("alarmList", alarmList);
        return result;
    }
    
}
