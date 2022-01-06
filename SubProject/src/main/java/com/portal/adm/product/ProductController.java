package com.portal.adm.product;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.portal.adm.product.model.ProductModel;
import com.portal.adm.product.service.ProductService;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 상품관리 / 상품 컨트롤러
 */
@Slf4j
@RequestMapping("/product")
@Controller
public class ProductController {

    @Resource
    private ProductService productService;
    
    /**
     * 상품 페이지로 이동
     *
     * @param model
     * @return
     */
    @RequestMapping(value="/prodList", method= {RequestMethod.GET,RequestMethod.POST})
    public String code(@ModelAttribute ProductModel productMapper, Model model, @AuthenticationPrincipal AuthUser authUser) {

        return "product/prodList";
    }

    /**
     * 상품 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @RequestMapping(value="/prodImage", method= {RequestMethod.GET,RequestMethod.POST})
    public String codePost(@ModelAttribute ProductModel productMapper, Model model, @AuthenticationPrincipal AuthUser authUser) {

        return "product/prodImg";
    }

    /**
     * 상품을 저장한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/product/insert")
    public ResponseEntity<String> groupSave(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
    	try {
            ProductModel productMapper = new ProductModel();

            String result = "";

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    /**
     * 상품을 삭제한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/product/delete")
    public ResponseEntity<String> groupDelete(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {

            String result = "";

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }    
    
    
    
    
    /**
     * 상품 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping(value="/product/detail/{prodId}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<ProductModel> codesForGroupCd(@ModelAttribute ProductModel productMapper, @PathVariable("prodId") String prodId) {
    	productMapper.setCodeId(prodId);
    	productMapper.setGroupId("GROUP_ID");
        productMapper = productService.select(productMapper);

        return new ResponseEntity<>(productMapper, HttpStatus.OK);
    }
    
}
