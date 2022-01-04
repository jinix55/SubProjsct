package com.portal.adm.supplier;

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

import com.portal.adm.supplier.model.SupplierModel;
import com.portal.adm.supplier.service.SupplierService;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 공급업체 / 공급업체 관리 컨트롤러
 */
@Slf4j
@RequestMapping("/supplier")
@Controller
public class SupplierController {

    @Resource
    private SupplierService supplierService;
    
    /**
     * 공급업체 페이지로 이동
     *
     * @param model
     * @return
     */
    @GetMapping("/supplier")
    public String code(@ModelAttribute SupplierModel supplierModel, Model model) {

        return "supplier/supplier";
    }

    /**
     * 공급업체 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @PostMapping("/supplier")
    public String codePost(@ModelAttribute SupplierModel supplierModel, Model model) {

        return "supplier/supplier";
    }

    /**
     * 공급업체 저장 및 수정
     *
     * @param request
     * @return
     */
    @PostMapping("/supplier/insert")
    public ResponseEntity<String> groupSave(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {

            String result = "";

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
    @PostMapping("/supplier/delete")
    public ResponseEntity<String> groupDelete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {

            String result = "";

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
    @RequestMapping(value="/supplier/detail/{supplierId}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<SupplierModel> codesForGroupCd(@ModelAttribute SupplierModel supplierModel, @PathVariable("supplierId") String codeId) {

        return new ResponseEntity<>(supplierModel, HttpStatus.OK);
    }
    
}
