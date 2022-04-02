package com.portal.adm.product;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.portal.adm.environmentCode.model.EnvironmentCodeModel;
import com.portal.adm.environmentCode.service.EnvironmentCodeService;
import com.portal.adm.file.model.FileModel;
import com.portal.adm.file.service.FileService;
import com.portal.adm.member.model.MemberModel;
import com.portal.adm.member.service.MemberService;
import com.portal.adm.product.model.ProdPackagingMatModel;
import com.portal.adm.product.model.ProdPackagingModel;
import com.portal.adm.product.model.ProdSelfPackagingModel;
import com.portal.adm.product.model.ProductModel;
import com.portal.adm.product.service.ProductService;
import com.portal.adm.supplier.model.SupplierModel;
import com.portal.adm.supplier.service.SupplierService;
import com.portal.common.Constant;
import com.portal.common.IdUtil;
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
    
    @Resource
	private SupplierService supplierService;
    
	@Resource
    private MemberService memberService;
	
    @Resource
    private IdUtil idUtil;
    
    @Resource(name="fileService")
	private FileService fileService;
    
    @Resource
    private EnvironmentCodeService environmentCodeService;
    
    /**
     * 상품 페이지로 이동
     *
     * @param model
     * @return
     */
    @RequestMapping(value="/prodList", method= {RequestMethod.GET,RequestMethod.POST})
    public String product(@ModelAttribute ProductModel productModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	// 상품 목록 조회
    	List<ProductModel> models = productService.selectProductList(productModel);
    	
    	System.out.println("models " + models);
    	
    	productModel.setTotalCount(productService.selectProductListCount(productModel));
        model.addAttribute("products", models);
        model.addAttribute("pages", productModel);
    	
        
//		<if test="searchKey != '' and searchKey == 'ALL' and searchValue != ''">
//		and (upper(PRODUCT_NM) like concat('%',upper(#{searchValue}),'%') or upper(PACKING_TYPE) like concat('%',upper(#{searchValue}),'%') or (upper(RECYCLE_GRADE) like concat('%',upper(#{searchValue}),'%')))
//	</if>
    	
    	//재질 정보 조회
//    	List<PackagingCodeModel> productMatType = productService.selectProductMatType();
    	EnvironmentCodeModel environmentCodeModel = new EnvironmentCodeModel();
    	environmentCodeModel.setGroupId("GROUP_ID");
    	environmentCodeModel.setRevisionYear("2022");
    	environmentCodeModel.setRevisionMonth("03");
//    	if(environmentCodeModel.getRevision() != null && !StringUtils.equals(environmentCodeModel.getRevision(), "")) {
//    		String[] revision = environmentCodeModel.getRevision().split("-");
//    	}
    	List<EnvironmentCodeModel> productMatType = environmentCodeService.selectList(environmentCodeModel);
    	model.addAttribute("productMatTypeList", productMatType);  
    	
    	//공급업체 정보 조회
    	SupplierModel supplierModel = new SupplierModel();
    	supplierModel.setAuthId(authUser.getMemberModel().getAuthId());
    	supplierModel.setOffSet(0);
    	supplierModel.setPageSize(9999);
        List<SupplierModel> supplierList = supplierService.selectSupplierList(supplierModel);
        model.addAttribute("suppliers", supplierList);
        
        
        return "product/prodList";
    }

    /**
     * 상품 상세정보를 조회한다.
     *
     * @param productId
     * @return
     */
    @RequestMapping(value="/detail/{productId}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<ProductModel> selectProduct(@PathVariable("productId") String productId) {
    	//상품 상세정보 조회
    	ProductModel productModel = new ProductModel();
    	productModel.setProductId(productId);
    	ProductModel product = productService.selectProduct(productModel);
		
    	System.out.println("product" + product);
    	
        return new ResponseEntity<>(product, HttpStatus.OK);
    }
    
    /**
     * 상품을 저장한다.
     *
     * @param request
     * @return
     */
    @RequestMapping(value="/insert" , method= {RequestMethod.GET,RequestMethod.POST}, produces=MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<String> groupSave(HttpServletRequest request, @ModelAttribute ProductModel productModel,@AuthenticationPrincipal AuthUser authUser, @RequestParam("photos") MultipartFile[] photos, @RequestParam("specs") MultipartFile[] specs) {
        if(productService.selectProductListCountByProductCode(productModel.getProductCode()) > 0) {
        	return ResponseEntity.badRequest().body("동일한 상품코드로 등록된 상품이 있습니다.");
        }
        
        if(productModel.getProductNm() == null || productModel.getProductNm().trim().equals("")) {
        	return ResponseEntity.badRequest().body("상품명이 누락 되었습니다");
        }
        
    	try {
    		productModel.setProductId(idUtil.getProductId());
    		productModel.setRgstId(authUser.getMemberModel().getUserId());
    		productModel.setModiId(authUser.getMemberModel().getUserId());
    		String fileUrl = "C:/PPLUS/" + productModel.getProductId() + "/";
    		String result = "success";
    		String resultMessage = "성공";
    		//사진 업로드
    		for(MultipartFile photo : photos) {
    			if(photo.getOriginalFilename().equals("")) {
    				continue;
    				//return new ResponseEntity<>("notFile", HttpStatus.NOT_ACCEPTABLE);
    			}
    			
    			FileModel f = new FileModel();
				f.setFileId(idUtil.getFileId());
				
				// s3 기본 처리
    			f.setStorageSe("LOCAL");
    			f.setFileNm(photo.getOriginalFilename());
    			f.setFileExtsn(FilenameUtils.getExtension(photo.getOriginalFilename()));
    			f.setFileSize(photo.getSize());
    			f.setFileUrl(fileUrl+f.getFileId() + "/");
    			f.setUseYn("Y");
    			f.setRefId("photos_"+productModel.getProductId());
    			f.setRgstId(productModel.getRgstId());
    			f.setModiId(productModel.getRgstId());
    			f.setFileCl(Constant.File.API);
    			
    			try {
    				f.setInputStream(photo.getResource().getInputStream());
    			} catch (IOException e) {
    				result = "fail";
    				resultMessage = "실패";
    			}
    			
    			// 파일 생성
    			if (!"fail".equals(result)) {
    				fileService.insertFile(f);
    				if(productModel.getPhoto() == null || "".equals(productModel.getPhoto())) {
    					productModel.setPhoto(f.getFileId());
    				}
    				
    				Path directoryPath = Paths.get(fileUrl+f.getFileId() + "/");

    				try {
    					Files.createDirectories(directoryPath);
    				} catch (IOException e1) {
    					return ResponseEntity.badRequest().body("1.파일 생성시 오류났습니다.");
    				}

    				try {
    					FileOutputStream fos = new FileOutputStream(fileUrl+f.getFileId() + "/" + photo.getOriginalFilename());

    					InputStream is = photo.getInputStream();

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
    					return ResponseEntity.badRequest().body("1.FileNotFoundException.");
    				}
    				catch (IOException e) {
    					return ResponseEntity.badRequest().body("1.IOException.");
    				}
    			}
    		}
    		
    		//도면첨부파일 업로드
    		for(MultipartFile spec : specs) {
    			if(spec.getOriginalFilename().equals("")) {
    				continue;
    				//return new ResponseEntity<>("notFile", HttpStatus.NOT_ACCEPTABLE);
    			}

    			FileModel f = new FileModel();
				f.setFileId(idUtil.getFileId());
				
				// s3 기본 처리
    			f.setStorageSe("LOCAL");
    			f.setFileNm(spec.getOriginalFilename());
    			f.setFileExtsn(FilenameUtils.getExtension(spec.getOriginalFilename()));
    			f.setFileSize(spec.getSize());
    			f.setFileUrl(fileUrl+f.getFileId() + "/");
    			f.setUseYn("Y");
    			f.setRefId("specs_"+productModel.getProductId());
    			f.setRgstId(productModel.getRgstId());
    			f.setModiId(productModel.getRgstId());
    			f.setFileCl(Constant.File.API);
    			
    			try {
    				f.setInputStream(spec.getResource().getInputStream());
    			} catch (IOException e) {
    				result = "fail";
    				resultMessage = "실패";
    			}
    			
    			// 파일 생성
    			if (!"fail".equals(result)) {
    				fileService.insertFile(f);
    				
    				Path directoryPath = Paths.get(fileUrl+f.getFileId() + "/");

    				try {
    					Files.createDirectories(directoryPath);
    				} catch (IOException e1) {
    					return ResponseEntity.badRequest().body("2.파일 생성시 오류났습니다.");
    				}

    				try {
    					FileOutputStream fos = new FileOutputStream(fileUrl+f.getFileId() + "/" + spec.getOriginalFilename());

    					InputStream is = spec.getInputStream();

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
    					return ResponseEntity.badRequest().body("2.FileNotFoundException.");
    				}
    				catch (IOException e) {
    					return ResponseEntity.badRequest().body("2.IOException.");
    				}
    			}
    		}
    		
            result = productService.insertProduct(productModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
        	return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    
//    @PostMapping("/update")
    @RequestMapping(value="/update" , method= {RequestMethod.GET,RequestMethod.POST}, produces=MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<String> update(HttpServletRequest request,
                                       @ModelAttribute ProductModel productModel,
                                       @AuthenticationPrincipal AuthUser authUser
                                       , @RequestParam("photos") MultipartFile[] photos
                                       , @RequestParam("specs") MultipartFile[] specs) {
    	
    	if((productModel.getMasterApply().equals("UNPROCEED")) || (productModel.getMasterApply().equals("EXCEPT"))) { //미진행
    		if(!(productModel.getReceiptNumber() == null || productModel.getReceiptNumber().trim().equals(""))) {
    			return ResponseEntity.badRequest().body("접수번호를 등록 할수 없습니다.");	
    		}
    		
    		if(!(productModel.getApprovalNumber() == null || productModel.getApprovalNumber().trim().equals(""))) {
    			return ResponseEntity.badRequest().body("승인번호를 등록 할수 없습니다.");	
    		}

    		if(!(productModel.getMappingProductCode() == null || productModel.getMappingProductCode().trim().equals(""))) {
    			return ResponseEntity.badRequest().body("매핑상품코드를 등록 할수 없습니다.");	
    		}
    	}
    	
    	
    	if(productModel.getMasterApply().equals("PROCEEDING")) { //진행중
    		if(productModel.getReceiptNumber() == null || productModel.getReceiptNumber().trim().equals("")) {
    			return ResponseEntity.badRequest().body("접수번호가 누락 되었습니다.");	
    		}
    		
    		if(!(productModel.getApprovalNumber() == null || productModel.getApprovalNumber().trim().equals(""))) {
    			return ResponseEntity.badRequest().body("승인번호를 등록 할수 없습니다.");	
    		}

    		if(!(productModel.getMappingProductCode() == null || productModel.getMappingProductCode().trim().equals(""))) {
    			return ResponseEntity.badRequest().body("매핑상품코드를 등록 할수 없습니다.");	
    		}
    	}
    	
    	if(productModel.getMasterApply().equals("COMPLETION")) { //완료
    		if(productModel.getApprovalNumber() == null || productModel.getApprovalNumber().trim().equals("")) {
    			return ResponseEntity.badRequest().body("승인번호가가 누락 되었습니다.");	
    		}

    	}
    	
    	
    	if(productModel.getMasterMapping().equals("UNMAPPING")) { //매핑전
    	   productModel.setMappingProductCode(""); 
    	}    	
    	

        try {
    		productModel.setModiId(authUser.getMemberModel().getUserId());
    		String result = "";
    		String resultMessage = "성공";
    		String fileUrl = "C:/PPLUS/" + productModel.getProductId() + "/";
    		int count = 0;
    		//사진 업로드
    		for(MultipartFile photo : photos) {
    			System.out.println("----"+count+"---");
    			System.out.println(photo.getOriginalFilename());
    			count++;
    			if(photo.getOriginalFilename().equals("")) {
    				continue;
    				//return new ResponseEntity<>("notFile", HttpStatus.NOT_ACCEPTABLE);
    			}
    			
    			FileModel f = new FileModel();
				f.setFileId(idUtil.getFileId());
				
				// s3 기본 처리
    			f.setStorageSe("LOCAL");
    			f.setFileNm(photo.getOriginalFilename());
    			f.setFileExtsn(FilenameUtils.getExtension(photo.getOriginalFilename()));
    			f.setFileSize(photo.getSize());
    			f.setFileUrl(fileUrl+f.getFileId() + "/");
    			f.setUseYn("Y");
    			f.setRefId("photos_"+productModel.getProductId());
    			f.setRgstId(productModel.getModiId());
    			f.setModiId(productModel.getModiId());
    			f.setFileCl(Constant.File.API);
    			
    			try {
    				f.setInputStream(photo.getResource().getInputStream());
    			} catch (IOException e) {
    				return ResponseEntity.badRequest().body("1.IOException.");
    			}
    			
    			// 파일 생성
    			if (!"fail".equals(result)) {
    				fileService.insertFile(f);
    				if(productModel.getPhoto() == null || "".equals(productModel.getPhoto())) {
    					productModel.setPhoto(f.getFileId());
    				}
    				
    				Path directoryPath = Paths.get(fileUrl+f.getFileId() + "/");

    				try {
    					Files.createDirectories(directoryPath);
    				} catch (IOException e1) {
    					e1.printStackTrace();
    				}

    				try {
    					FileOutputStream fos = new FileOutputStream(fileUrl+f.getFileId() + "/" + photo.getOriginalFilename());

    					InputStream is = photo.getInputStream();

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
    					return ResponseEntity.badRequest().body("2.FileNotFoundException.");
    				}
    				catch (IOException e) {
    					return ResponseEntity.badRequest().body("3.IOException.");
    				}
    			}
    		}
    		
    		//도면첨부파일 업로드
    		for(MultipartFile spec : specs) {
    			if(spec.getOriginalFilename().equals("")) {
    				continue;
    				//return new ResponseEntity<>("notFile", HttpStatus.NOT_ACCEPTABLE);
    			}

    			FileModel f = new FileModel();
				f.setFileId(idUtil.getFileId());
				
				// s3 기본 처리
    			f.setStorageSe("LOCAL");
    			f.setFileNm(spec.getOriginalFilename());
    			f.setFileExtsn(FilenameUtils.getExtension(spec.getOriginalFilename()));
    			f.setFileSize(spec.getSize());
    			f.setFileUrl(fileUrl+f.getFileId() + "/");
    			f.setUseYn("Y");
    			f.setRefId("specs_"+productModel.getProductId());
    			f.setRgstId(productModel.getModiId());
    			f.setModiId(productModel.getModiId());
    			f.setFileCl(Constant.File.API);
    			
    			try {
    				f.setInputStream(spec.getResource().getInputStream());
    			} catch (IOException e) {
    				return ResponseEntity.badRequest().body("1.IOException.");
    			}
    			
    			// 파일 생성
    			if (!"fail".equals(result)) {
    				fileService.insertFile(f);
    				
    				Path directoryPath = Paths.get(fileUrl+f.getFileId() + "/");

    				try {
    					Files.createDirectories(directoryPath);
    				} catch (IOException e1) {
    					e1.printStackTrace();
    				}

    				try {
    					FileOutputStream fos = new FileOutputStream(fileUrl+f.getFileId() + "/" + spec.getOriginalFilename());

    					InputStream is = spec.getInputStream();

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
    					return ResponseEntity.badRequest().body("2.IOException.");
    				}
    				catch (IOException e) {
    					return ResponseEntity.badRequest().body("3.IOException.");
    				}
    			}
    		}
    		
            result = productService.updateProduct(productModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
        	return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    
    /**
     * 상품을 삭제한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/delete")
    public ResponseEntity<String> productDelete(@ModelAttribute ProductModel productModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {            
            productModel.setModiId(authUser.getMemberModel().getUserId());
            String result = productService.deleteProduct(productModel);
            
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
        	return ResponseEntity.badRequest().body(e.getMessage());
        }
    }    
    
    
    @RequestMapping(value="/detail/packagingOrder", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<List<ProdPackagingModel>> selectProductPackagingOrder(ProdPackagingModel prodPackagingModel) {
    	// 상품 포장 차수 조회
    	List<ProdPackagingModel> packagingOrder = productService.selectProductPackagingOrder(prodPackagingModel);
    	
    	for( int i = 0 ; i < packagingOrder.size() ; i++) {
    		EnvironmentCodeModel environmentCode = new EnvironmentCodeModel();
        	environmentCode.setCodeId(packagingOrder.get(i).getMatType().split("_")[0]);
        	environmentCode.setGroupId("GROUP_ID");
        	environmentCode.setRevisionYear("2022");
        	environmentCode.setRevisionMonth("03");
        	
        	EnvironmentCodeModel detailCodeList = environmentCodeService.select(environmentCode);
        	if(detailCodeList != null) {
        		packagingOrder.get(i).setMatTypeNm(detailCodeList.getCodeNm());
        	}
        }
    	
        return new ResponseEntity<>(packagingOrder, HttpStatus.OK);
    }
    
    @RequestMapping(value="/detail/packaging", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<List<ProdPackagingModel>> selectProductPackaging(@ModelAttribute ProdPackagingModel productPackagingModel) {
    	// 상품 목록 조회
    	List<ProdPackagingModel> models = productService.selectProductPackaging(productPackagingModel);
    	for( int i = 0 ; i < models.size() ; i++) {
	    	EnvironmentCodeModel environmentCode = new EnvironmentCodeModel();
	    	environmentCode.setCodeId(models.get(i).getPartType());
	    	environmentCode.setGroupId(models.get(i).getMatType().split("_")[0]);
	    	environmentCode.setRevisionYear("2022");
	    	environmentCode.setRevisionMonth("03");
	    	EnvironmentCodeModel detailCodeList = environmentCodeService.select(environmentCode);
	    	if(detailCodeList != null) {
	    		models.get(i).setPartTypeNm(detailCodeList.getCodeNm());
	    	}
    	}
        return new ResponseEntity<>(models, HttpStatus.OK);
    }

    /**
     * 상품포장정보 상세정보를 조회한다.
     *
     * @param productId
     * @return
     */
    @RequestMapping(value="/detail/{productId}/packaging/{packagingId}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<ProdPackagingModel> selectProduct(@PathVariable("productId") String productId, @PathVariable("packagingId") String packagingId) {
    	ProdPackagingModel prodPackagingModel = new ProdPackagingModel();
    	prodPackagingModel.setPackagingId(packagingId);
    	prodPackagingModel.setProductId(productId);
    	ProdPackagingModel productPackaging = productService.selectProductPackagingDetail(prodPackagingModel);
    	if(productPackaging.getMatFileId() != null && !"".equals(productPackaging.getMatFileId())) {
    		FileModel f = new FileModel();
    		f.setFileId(productPackaging.getMatFileId());
    		FileModel f1 = fileService.selectFile(f);
    		if(f1 != null) {
    			productPackaging.setMatFileNm(f1.getFileNm());
//    			productPackaging.setMatFileId(f1.getFileUrl());
    		}else {
    			productPackaging.setMatFileId("");
    			productPackaging.setMatFileNm("");
    		}
    	}else {
    		productPackaging.setMatFileId("");
			productPackaging.setMatFileNm("");
    	}
    	EnvironmentCodeModel environmentCode = new EnvironmentCodeModel();
    	environmentCode.setCodeId(productPackaging.getPartType());
    	environmentCode.setGroupId(productPackaging.getMatType().split("_")[0]);
    	environmentCode.setRevisionYear("2022");
    	environmentCode.setRevisionMonth("03");
    	
    	EnvironmentCodeModel detailCodeList = environmentCodeService.select(environmentCode);
    	if(detailCodeList != null) {
    		productPackaging.setPartTypeNm(detailCodeList.getCodeNm());
    	}
    	
        return new ResponseEntity<>(productPackaging, HttpStatus.OK);
    }
    
    /**
     * 상품포장정보을 저장한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/insert/{productId}/packaging")
    public ResponseEntity<ProdPackagingModel> insertProductPackaging(HttpServletRequest request, @PathVariable("productId") String productId, @ModelAttribute ProdPackagingModel prodPackagingModel,@AuthenticationPrincipal AuthUser authUser) {
    	try {
    		
			prodPackagingModel.setRgstId(authUser.getMemberModel().getUserId());
			prodPackagingModel.setModiId(authUser.getMemberModel().getUserId());
			prodPackagingModel.setProductId(productId);
			prodPackagingModel.setProductNm("상품1");
			prodPackagingModel.setPackagingNm("1차포장");
			prodPackagingModel.setPackagingId(idUtil.getPackagingId());
			int x= prodPackagingModel.getManagerId().indexOf("||");
			String managerId = prodPackagingModel.getManagerId().substring(0, x);
        	prodPackagingModel.setManagerId(managerId);
			productService.insertProductPackaging(prodPackagingModel);

            return new ResponseEntity<>(prodPackagingModel, HttpStatus.OK);
        } catch (Exception e) {
        	return ResponseEntity.badRequest().body(new ProdPackagingModel());
        }
    }
    
    @PostMapping("/update/{productId}/packaging")
    public ResponseEntity<ProdPackagingModel> updateProductPackaging(HttpServletRequest request, @PathVariable("productId") String productId,
                                       @ModelAttribute ProdPackagingModel prodPackagingModel,
                                       @AuthenticationPrincipal AuthUser authUser) {

        try {
        	prodPackagingModel.setModiId(authUser.getMemberModel().getUserId());
        	prodPackagingModel.setProductNm("상품1");
			prodPackagingModel.setPackagingNm("1차포장");
			int x= prodPackagingModel.getManagerId().indexOf("||");
			String managerId = prodPackagingModel.getManagerId().substring(0, x);
        	prodPackagingModel.setManagerId(managerId);
            productService.updateProductPackaging(prodPackagingModel);

            return new ResponseEntity<>(prodPackagingModel, HttpStatus.OK);
        } catch (Exception e) {
        	return ResponseEntity.badRequest().body(new ProdPackagingModel());
        }
    }
    
    /**
     * 상품포장정보을 삭제한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/delete/{productId}/packaging")
    public ResponseEntity<String> deleteProductPackaging(@ModelAttribute ProdPackagingModel prodPackagingModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {            
        	prodPackagingModel.setModiId(authUser.getMemberModel().getUserId());
            String result = productService.deleteProductPackaging(prodPackagingModel);
            
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
        	return ResponseEntity.badRequest().body(e.getMessage());
        }
    } 
    
    /**
     * 상품자가진단 정보 조회한다.
     *
     * @param request
     * @return
     */
    @RequestMapping(value="/detail/selfPackaging", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<ProdSelfPackagingModel> selectProductSelfPackaging(@ModelAttribute EnvironmentCodeModel environmentCodeModel) {
    	List<EnvironmentCodeModel> middleModels = new ArrayList<EnvironmentCodeModel>();
    	List<EnvironmentCodeModel> smallModels = new ArrayList<EnvironmentCodeModel>();
    	List<EnvironmentCodeModel> lastModels = new ArrayList<EnvironmentCodeModel>();
    	ProdSelfPackagingModel prodSelfPackagingModel = new ProdSelfPackagingModel();
    	
    	middleModels = environmentCodeService.selectGroupIdList(environmentCodeModel);
    	prodSelfPackagingModel.setMiddleModels(middleModels);
    	
    	ArrayList<EnvironmentCodeModel> list = new ArrayList<EnvironmentCodeModel>();
    	for(EnvironmentCodeModel m : middleModels) {
    		environmentCodeModel.setGroupId(m.getCodeId());
    		smallModels = environmentCodeService.selectGroupIdList(environmentCodeModel);
    		list.addAll(smallModels);
    	}
    	
    	Collections.sort(list,new Comparator<EnvironmentCodeModel>() {
			@Override
			public int compare(EnvironmentCodeModel o1, EnvironmentCodeModel o2) {
				return o1.getOrdSeq() - o2.getOrdSeq();
			}
		});
    	prodSelfPackagingModel.setSmallModels(list);
    	
    	ArrayList<EnvironmentCodeModel> lalist = new ArrayList<EnvironmentCodeModel>();
    	for(EnvironmentCodeModel l :list) {
    		environmentCodeModel.setGroupId(l.getCodeId());
    		lastModels = environmentCodeService.selectGroupIdList(environmentCodeModel);
    		lalist.addAll(lastModels);
    	}
    	prodSelfPackagingModel.setLastModels(lalist);
    	
        return new ResponseEntity<>(prodSelfPackagingModel, HttpStatus.OK);
    }
    
    /**
     * 
     *
     * @param request
     * @return
     */
    @RequestMapping(value="/insert/selfPackaging" , method= {RequestMethod.GET,RequestMethod.POST}, produces=MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<ProdPackagingMatModel> saveSelfPackaging(HttpServletRequest request
    		, @AuthenticationPrincipal AuthUser authUser
    		, @ModelAttribute ProdPackagingMatModel prodPackagingMatModel
    		, MultipartRequest multipart
    		, @RequestParam(value = "checkbox_PA_B", required = false) List<String> paBs
    		, @RequestParam(value = "checkbox_PE_L", required = false) List<String> paLs
    		, @RequestParam(value = "checkbox_PA_G", required = false) List<String> paGs) {
    	
    	prodPackagingMatModel.setRgstId(authUser.getMemberModel().getUserId());
    	prodPackagingMatModel.setModiId(authUser.getMemberModel().getUserId());
		
    	productService.deleteProductSelfPackaging(prodPackagingMatModel);
    	
    	if(paBs != null) {
	    	for(String paB : paBs) {
	    		prodPackagingMatModel.setGroupId(paB.split("||")[0]);
	    		prodPackagingMatModel.setCodeId(paB.split("||")[1]);
	    		prodPackagingMatModel.setPackagingMatId(idUtil.getPackagingMatId());
	    		productService.insertProductSelfPackaging(prodPackagingMatModel);
	    		
	    	}
    	}
    	
    	if(paLs != null) {
	    	for(String paL : paLs) {
	    		prodPackagingMatModel.setGroupId(paL.split("||")[0]);
	    		prodPackagingMatModel.setCodeId(paL.split("||")[1]);
	    		prodPackagingMatModel.setPackagingMatId(idUtil.getPackagingMatId());
	    		productService.insertProductSelfPackaging(prodPackagingMatModel);
	    		
	    	}
    	}
    	
    	if(paGs != null) {
	    	for(String paG : paGs) {
	    		prodPackagingMatModel.setGroupId(paG.split("||")[0]);
	    		prodPackagingMatModel.setCodeId(paG.split("||")[1]);
	    		prodPackagingMatModel.setPackagingMatId(idUtil.getPackagingMatId());
	    		productService.insertProductSelfPackaging(prodPackagingMatModel);
	    		
	    	}
    	}
    	
    	return new ResponseEntity<>(prodPackagingMatModel, HttpStatus.OK);
    }
    
    /**
     * 코드변경시점정보를 조회한다.
     *
     * @param productId
     * @return
     */
    @RequestMapping(value="/detail/getCodeDayList", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<List<EnvironmentCodeModel>> getCodeDayList() {
    	List<EnvironmentCodeModel> dayList = environmentCodeService.selectCodeDayList();
    	
        return new ResponseEntity<>(dayList, HttpStatus.OK);
    }
    
    /**
     * 상품 페이지로 이동
     *
     * @param criteria
     * @return
     */
    @RequestMapping(value="/prodImage", method= {RequestMethod.GET,RequestMethod.POST})
    public String codePost(@ModelAttribute ProductModel productModel, Model model, @AuthenticationPrincipal AuthUser authUser) {

    	// 상품 목록 조회
    	List<ProductModel> models = productService.selectProductList(productModel);
    	productModel.setTotalCount(productService.selectProductListCount(productModel));
        model.addAttribute("products", models);
        model.addAttribute("pages", productModel);
        
        return "product/prodImage";
    }

    
    
    /**
     * 공급업체 페이지로 이동
     *
     * @param model
     * @return
     */
    @RequestMapping(value="/supplier", method= {RequestMethod.GET,RequestMethod.POST})
    public String code(@ModelAttribute SupplierModel supplierModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	supplierModel.setUpCompanyCode(authUser.getMemberModel().getCompanyCode());
    	supplierModel.setAuthId(authUser.getMemberModel().getAuthId());
        List<SupplierModel> models = supplierService.selectSupplierList(supplierModel);
        supplierModel.setTotalCount(supplierService.selectSupplierListCount(supplierModel));
        
        for( int i = 0 ; i < models.size() ; i++) {
        	MemberModel memberModel = new MemberModel();
        	
        	String memId = models.get(i).getManagementId();
        	memberModel.setUserId(memId);
        	memberModel = memberService.selectMember(memberModel);
        	models.get(i).setManagementId(memId);
        	models.get(i).setManagementNm(memberModel.getUserNm());
        	models.get(i).setManagementPhone(memberModel.getPhone());
        	models.get(i).setManagementMail(memberModel.getEmail());
        	models.get(i).setManagementDept(memberModel.getDeptNm());
        	models.get(i).setManagementPstn(memberModel.getPstnNm());
        }
        
        model.addAttribute("suppliers", models);
        model.addAttribute("pages", supplierModel);
        
        return "product/supplierView";
    }

    /**
     * 공급업체 목록을 상세 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping(value="/supplier/detail/{supplierId}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<SupplierModel> codesForGroupCd(@ModelAttribute SupplierModel supplierModel, @PathVariable("supplierId") String supplierId) {
    	supplierModel = supplierService.selectSupplierId(supplierId);
    	return new ResponseEntity<>(supplierModel, HttpStatus.OK);
    }
    
    /**
     * 공급업체 책임자를 상세 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping(value="/supplier/detail/manager/{managerId}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<SupplierModel> selectManagerId(@ModelAttribute SupplierModel supplierModel, @PathVariable("managerId") String managerId) {
    	supplierModel = supplierService.selectSupplierManager(managerId);
        return new ResponseEntity<>(supplierModel, HttpStatus.OK);
    }
    
    /**
     * 그룹코드 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping(value="/supplier/detail/managers/{supplierCode}", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<List<SupplierModel>> selectManagersBySupplierCode(@ModelAttribute SupplierModel supplierModel, @PathVariable("supplierCode") String supplierCode) {
    	List<SupplierModel> models = supplierService.selectSupplierManagers(supplierCode);
        return new ResponseEntity<>(models, HttpStatus.OK);
    }
    
    
    /**
     * 재활용분담금 계산.
     *
     * @param 
     * @return
     */
    @RequestMapping(value="/detail/{productId}/recyle_contributions/", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String calcRecyleContributions1(@ModelAttribute ProductModel productModel, @PathVariable("productId") String productId) {
    	
//    	ProductModel productModel = new ProductModel();
//    	productModel.setBaseYear("2022");
//    	productModel.setAccumulateSaleQty(123);
//    	productModel.setPackingTotalWeight(456);

        return productService.calcRecyleContributions(productModel);
    }    
    
    
    /**
     * 환경부 승인번호 상품 매핑 ##########
     *  1
     * @param 
     * @return
     */

    @RequestMapping(value="/detail/mapping/", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<ProductModel> mapping(@ModelAttribute ProductModel productModel) {
    	System.out.println("mapping productModel" + productModel);
    	
    	if(!(productModel.getMasterApply().equals("UNPROCEED"))) { //미진행
    		productModel.setErrorString("진행상태가 미진행이 아닙니다.");
  	    	return ResponseEntity.badRequest().body(productModel);	
    	}
    	
    	ProductModel product = productService.mapping(productModel);
        return new ResponseEntity<>(product, HttpStatus.OK);

    }
    
    
    /**
     * 환경부 승인번호 상품 매핑
     *
     * @param 
     * @return
     */

    @RequestMapping(value="/detail/apply/", method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
	public ResponseEntity<List<ProdPackagingModel>> apply(@ModelAttribute ProductModel productModel) {

    	
    	
    	List<ProdPackagingModel>  prodPackagingList = productService.apply(productModel);
    	return new ResponseEntity<>(prodPackagingList, HttpStatus.OK);
    }    

    /**
     * 상품별 등록할 차수를 조회
     *  
     * @param 
     * @return
     */
	@RequestMapping(value="/detail/{productCode}/getPackagingOrderByNew", method= {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public ResponseEntity<List<ProdPackagingModel>> getPackagingOrderByNew(@PathVariable("productCode") String productCode) {
		// 상품 포장 차수 조회
		int  maxPackagingOrder = productService.selectMaxProductPackagingOrder(productCode);
 		
	    List<ProdPackagingModel> ProdPackagingList = new ArrayList<>() ;
	    ProdPackagingModel prodPackagingModel = new ProdPackagingModel();
	    prodPackagingModel.setPackagingOrder(maxPackagingOrder + 1);
        
	    if(maxPackagingOrder == 0) {
	    	prodPackagingModel.setPackagingNm("기준포장");
	    	ProdPackagingList.add(prodPackagingModel);
        } else {
        	prodPackagingModel.setPackagingNm(Integer.toString(maxPackagingOrder + 1) + "차포장");
	    	ProdPackagingList.add(prodPackagingModel);
	    	
	    	int  maxPartPackagingOrder = productService.selectMaxPartProductPackagingOrder(productService.getProductId(productCode));
		    prodPackagingModel = new ProdPackagingModel();
		    prodPackagingModel.setPackagingOrder(maxPartPackagingOrder + 1);
		    prodPackagingModel.setPackagingNm("부속포장");
		    ProdPackagingList.add(prodPackagingModel);
        }
	    
		return new ResponseEntity<>(ProdPackagingList, HttpStatus.OK);
	}
	
	
	/**
     * 에러 전달
     *  
     * @param 
     * @return
     */
	@RequestMapping(value="/detail/{productCode}/error", method= {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public ResponseEntity<String> throwError(@PathVariable("productCode") String productCode) {
		if(productCode == null) {
			return ResponseEntity.badRequest().body("에러났다.");
		}else {
			String val = productService.throwError("정상");
			if(!"정상".equals(val)) {
				return ResponseEntity.badRequest().body("service 에러났다."+val);
			}
			
			return new ResponseEntity<>(productCode, HttpStatus.OK);
		}
	    
	}
}

