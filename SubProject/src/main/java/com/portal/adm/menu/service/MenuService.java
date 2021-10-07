package com.portal.adm.menu.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.adm.menu.mapper.MenuMapper;
import com.portal.adm.menu.model.MenuModel;

/**
 * 메뉴관리 서비스 클래스
 *
 */
@Service
public class MenuService {

    @Resource
    private MenuMapper menuMapper;

    /**
     * 메뉴모델 리스트를 조회한다.
     *
     * @return
     */
    public List<MenuModel> selectList() {
        return menuMapper.selectList();
    }
    
    /**
     * 메뉴모델 권한별 리스트를 조회한다.
     *
     * @return
     */
    public List<MenuModel> selectList(String authId) {
        return menuMapper.selectList(authId);
    }

    /**
     * 메뉴 목록을 조회한다.
     *
     * @param model 메뉴ID를 사용
     * @return
     */
    public MenuModel select(MenuModel model) {
        return menuMapper.select(model);
    }

    /**
     * 메뉴모델을 삭제한다.
     *
     * @param model
     * @return
     */
    @Transactional
    public long delete(MenuModel model) {
        return menuMapper.delete(model);
    }

    /**
     * 메뉴모델을 저장한다. 메뉴ID의 메뉴모델이 존재하면 업데이트 아니면 신규생성한다.
     *
     * @param model
     * @return
     */
    @Transactional
    public long save(MenuModel model) {
        MenuModel existModel = select(model);

        if(existModel != null) {
            return menuMapper.update(model);
        } else {
            return menuMapper.insert(model);
        }
    }

    /**
     * 메뉴URL에 따른 상위메뉴ID를 조회한다.
     *
     * @param model 메뉴URL을 사용
     * @return
     */
    public String selectUpperMenuIdForMenuUrl(MenuModel model) {
        return menuMapper.selectUpperMenuIdForMenuUrl(model);
    }

    /**
     * 메뉴URL에 따른 상위메뉴ID를 조회한다.
     *
     * @param url 메뉴URL
     * @return
     */
    public String selectUpperMenuIdForMenuUrl(String url) {
        MenuModel model = new MenuModel();
        model.setMenuUrl(url);

        return selectUpperMenuIdForMenuUrl(model);
    }
    
    /**
     * 최상위 메뉴 ID 조회
     */
    public List<MenuModel> selectTopMenuListWithAuth(String authId) {
    	return menuMapper.selectTopMenuListWithAuth(authId);
    }
    
    /**
     * 권한과 상위 메뉴 ID에 따른 메뉴 리스트를 조회
     */
    public List<MenuModel> selectLeftMenuListWithAuth(String upMenuId, String authId) {
    	Map<String,String> param = new HashMap<>();
    	param.put("upMenuId", upMenuId);
    	param.put("authId", authId);
    	return menuMapper.selectLeftMenuListWithAuth(param);
    }
    
    /**
     * 권한으로 접근 가능한 첫번째 메뉴 URL 조회
     */
    public String selectFirstMenuUrl(String menuUrl, String authId) {
    	Map<String,String> param = new HashMap<>();
    	param.put("menuUrl", menuUrl);
    	param.put("authId", authId);
    	return menuMapper.selectFirstMenuUrl(param);
    }
    
    /**
     * 권한별 메뉴 리스트
     */
    public List<MenuModel> selectMenuListWithAuth(String authId) {
    	return menuMapper.selectMenuListWithAuth(authId);
    }
    
    /**
     * 권한별 메뉴를 업데이트 한다.
     *
     * @param model
     * @return
     */
    @Transactional
    public long updateMenuListWithAuth(MenuModel model) {
    	return menuMapper.updateMenuListWithAuth(model);
    }
}
