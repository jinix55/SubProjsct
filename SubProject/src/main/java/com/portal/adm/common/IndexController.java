package com.portal.adm.common;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.portal.adm.alarm.AlarmController;
import com.portal.adm.menu.service.MenuService;
import com.portal.common.annotation.NoLogging;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class IndexController {
	
	@Resource(name="menuService")
	private MenuService menuService;

//	@NoLogging
    @GetMapping("/")
    public String index(Model model, HttpServletRequest request, HttpSession session, @ModelAttribute String modiId, @AuthenticationPrincipal AuthUser authUser) {
    	String result = "redirect:/login";
    	if (authUser != null) {
    		result = "redirect:"+menuService.selectFirstMenuUrl(null, authUser.getMemberModel().getAuthId());
    	}
        return result;
    }
    
//    @NoLogging
    @GetMapping("/admin")
    public String admin(Model model, HttpServletRequest request, HttpSession session, @ModelAttribute String modiId, @AuthenticationPrincipal AuthUser authUser) {
    	String result = "redirect:/login";
    	if (authUser != null) {
    		result = "redirect:"+menuService.selectFirstMenuUrl("/admin",authUser.getMemberModel().getAuthId());
    	}
        return result;
    }
    
//    @NoLogging
    @GetMapping("/member")
    public String member(Model model, HttpServletRequest request, HttpSession session, @ModelAttribute String modiId, @AuthenticationPrincipal AuthUser authUser) {
    	String result = "redirect:/login";
    	if (authUser != null) {
    		result = "redirect:"+menuService.selectFirstMenuUrl("/member",authUser.getMemberModel().getAuthId());
    	}
    	return result;
    }
    
//    @NoLogging
    @GetMapping("/system")
    public String system(Model model, HttpServletRequest request, HttpSession session, @ModelAttribute String modiId, @AuthenticationPrincipal AuthUser authUser) {
    	String result = "redirect:/login";
    	if (authUser != null) {
    		result = "redirect:"+menuService.selectFirstMenuUrl("/system",authUser.getMemberModel().getAuthId());
    	}
    	return result;
    }
    
//    @NoLogging
    @GetMapping("/board")
    public String board(Model model, HttpServletRequest request, HttpSession session, @ModelAttribute String modiId, @AuthenticationPrincipal AuthUser authUser) {
    	String result = "redirect:/login";
    	if (authUser != null) {
    		result = "redirect:"+menuService.selectFirstMenuUrl("/board",authUser.getMemberModel().getAuthId());
    	}
        return result;
    }
    
//    @NoLogging
    @GetMapping("/menu")
    public String menu(Model model, HttpServletRequest request, HttpSession session, @ModelAttribute String modiId, @AuthenticationPrincipal AuthUser authUser) {
    	String result = "redirect:/login";
    	if (authUser != null) {
    		result = "redirect:"+menuService.selectFirstMenuUrl("/menu",authUser.getMemberModel().getAuthId());
    	}
        return result;
    }
    
//    @NoLogging
    @GetMapping("/log")
    public String log(Model model, HttpServletRequest request, HttpSession session, @ModelAttribute String modiId, @AuthenticationPrincipal AuthUser authUser) {
    	String result = "redirect:/login";
    	if (authUser != null) {
    		result = "redirect:"+menuService.selectFirstMenuUrl("/log",authUser.getMemberModel().getAuthId());
    	}
        return result;
    }
    
//    @NoLogging
    @GetMapping("/alarm")
    public String alarm(Model model, HttpServletRequest request, HttpSession session, @ModelAttribute String modiId, @AuthenticationPrincipal AuthUser authUser) {
    	String result = "redirect:/login";
    	if (authUser != null) {
    		result = "redirect:"+menuService.selectFirstMenuUrl("/alarm",authUser.getMemberModel().getAuthId());
    	}
    	return result;
    }
    
}
