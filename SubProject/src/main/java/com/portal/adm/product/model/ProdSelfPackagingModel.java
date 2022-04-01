package com.portal.adm.product.model;

import java.util.ArrayList;
import java.util.List;

import com.portal.adm.environmentCode.model.EnvironmentCodeModel;
import com.portal.common.paging.Criteria;

import lombok.Data;

@Data
public class ProdSelfPackagingModel extends Criteria{
	private String rownum;          // 순번
    private String matType;
    private String matTypeNm;
    private String revisionYear;
    private String revisionMonth;

    List<EnvironmentCodeModel> middleModels = new ArrayList<EnvironmentCodeModel>();
	List<EnvironmentCodeModel> smallModels = new ArrayList<EnvironmentCodeModel>();
	List<EnvironmentCodeModel> lastModels = new ArrayList<EnvironmentCodeModel>();

}
