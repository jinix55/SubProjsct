package com.portal.adm.board;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 게시판 공통 컨트롤러
 */
@RequestMapping("/board")
@Controller
public class BoardController {

    /**
     * 분석게시판 페이지로 이동한다.
     *
     * @param model
     * @return
     */
    @GetMapping("/analBoard")
    public String analysis(Model model) {
        return "board/analysis";
    }

    /**
     * 분석게시판 등록 페이지로 이동한다.
     *
     * @param model
     * @return
     */
    @GetMapping("/analBoard/regist")
    public String analysisRegist(Model model) {
        return "board/analysisRegist";
    }
}
