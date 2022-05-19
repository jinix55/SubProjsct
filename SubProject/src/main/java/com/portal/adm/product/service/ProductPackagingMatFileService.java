package com.portal.adm.product.service;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.portal.adm.file.model.FileModel;
import com.portal.adm.file.service.FileService;
import com.portal.adm.product.mapper.ProductPackagingMatFIleMapper;
import com.portal.adm.product.model.ProductPackagingMatFileModel;
import com.portal.adm.product.model.ProductModel;
import com.portal.common.Constant;
import com.portal.common.IdUtil;

/**
 * 상품 그룹 첨부파일 서비스 클래스
 */
@Service
public class ProductPackagingMatFileService {

    @Resource
    private ProductPackagingMatFIleMapper productPackagingMatFIleMapper;

    @Resource(name="fileService")
	private FileService fileService;
    
    @Resource
    private IdUtil idUtil;    

    /**
   	 * 첨부파일 목록 카운트를 조회한다.
   	 *
   	 * @param criteria 페이징 모델
   	 * @return
   	 */
   	public int selectProductPackagingMatFileListCount(ProductPackagingMatFileModel productPackagingMatFileModel) {
   		return productPackagingMatFIleMapper.selectProductPackagingMatFileListCount(productPackagingMatFileModel);
   	}
    
    /**
	 * 첨부파일관리 목록을 조회한다.
	 *
	 * @param criteria 페이징 모델
	 * @return
	 */
    public List<ProductPackagingMatFileModel> selectProductPackagingMatFileList(ProductPackagingMatFileModel productPackagingMatFileModel) {
    	List<ProductPackagingMatFileModel> productPackagingMatFileList = productPackagingMatFIleMapper.selectProductPackagingMatFileList(productPackagingMatFileModel);
        return productPackagingMatFileList;
    }
	
    /**
	 * 첨부파일관리 목록을 조회한다.
	 *
	 * @param criteria 페이징 모델
	 * @return
	 */
    public List<ProductPackagingMatFileModel> selectProductPackagingMatFileListByGfileId(ProductPackagingMatFileModel productPackagingMatFileModel) {
    	List<ProductPackagingMatFileModel> productPackagingMatFileList = productPackagingMatFIleMapper.selectProductPackagingMatFileListByGfileId(productPackagingMatFileModel);
        return productPackagingMatFileList;
    }
    
    /**
	 * 첨부파일관리 상세정보을 조회한다.
	 *
	 * @param productPackagingMatFileModel 모델
	 * @return
	 */
    public ProductPackagingMatFileModel selectProductPackagingMatFile(ProductPackagingMatFileModel productPackagingMatFileModel) {
    	ProductPackagingMatFileModel productPackagingMatFile = productPackagingMatFIleMapper.selectProductPackagingMatFile(productPackagingMatFileModel);
        return productPackagingMatFile;
    }
    
	/**
	 * 첨부파일 정보를 등록한다.
	 *
	 * @param model 첨부파일아이디를 사용
	 * @return
	 */
	@Transactional
	public String insertProductPackagingMatFile(ProductPackagingMatFileModel productPackagingMatFileModel) {
		long count = productPackagingMatFIleMapper.insertProductPackagingMatFile(productPackagingMatFileModel);
		
		if (count > 0) {
			return Constant.DB.INSERT;
		} else {
			return Constant.DB.FAIL;
		}
	}

	/**
	 * 첨부파일 정보를 수정한다.
	 *
	 * @param model 첨부파일아이디를 사용
	 * @return
	 */
	
	@Transactional
	public String updateProductRecycleGrade(ProductPackagingMatFileModel productPackagingMatFileModel) {
		long count = productPackagingMatFIleMapper.updateProductPackagingMatFile(productPackagingMatFileModel);
		if (count > 0) {
			return Constant.DB.UPDATE;
		} else {
			return Constant.DB.FAIL;
		}
	}
	
	/**
	 * 첨부파일 정보를 수정(삭제,미사용)한다.
	 *
	 * @param model 첨부파일아이디를 사용
	 * @return
	 */
	@Transactional
	public String deleteProduct(ProductPackagingMatFileModel productPackagingMatFileModel) {
		long count = productPackagingMatFIleMapper.deleteProductPackagingMatFile(productPackagingMatFileModel);
		if (count > 0) {
			return Constant.DB.DELETE;
		} else {
			return Constant.DB.FAIL;
		}
	}
	
	/**
	 * 첨부파일 저장한다
	 *
	 * @param model 첨부파일아이디를 사용
	 * @return
	 */
	public String saveProuductPackagingMatFile(ProductModel productModel, MultipartRequest multipart, String productPackagingMatFileId) {
		try {
    		String fileUrl = "C:/PPLUS/" + productModel.getProductCode() + "/selfPackaging/";
    		String result = "success";
    		String resultMessage = "성공";
    		
    		ProductPackagingMatFileModel productPackagingMatFileModel = new ProductPackagingMatFileModel();
    		
    		//사진 업로드
    		final Map<String, MultipartFile> files = multipart.getFileMap();
        	MultipartFile file = null;
        	for (String key : files.keySet()) {
    			if(file.getOriginalFilename().equals("")) {
    				continue;
    				//return new ResponseEntity<>("notFile", HttpStatus.NOT_ACCEPTABLE);
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
    			f.setRefId(productModel.getProductCode());
    			f.setRgstId(productModel.getModiId());
    			f.setModiId(productModel.getModiId());
    			f.setFileCl(Constant.File.API);
    			
    			try {
    				f.setInputStream(file.getResource().getInputStream());
    			} catch (IOException e) {
    				result = "fail";
    				resultMessage = "실패";
    			}
    			
    			// 파일 생성
    			if (!"fail".equals(result)) {
    				fileService.insertFile(f);
    				
    				if(productPackagingMatFileId == null || "".equals(productPackagingMatFileId)) {
//    					productPackagingMatFileId = idUtil.getProductPackagingMatFileId();
    				}
    				productPackagingMatFileModel.setPackagingMatFileId(productPackagingMatFileId);
    				productPackagingMatFileModel.setFileId(f.getFileId());
    				productPackagingMatFileModel.setRgstId(productModel.getModiId());
    				productPackagingMatFileModel.setModiId(productModel.getModiId());
    				insertProductPackagingMatFile(productPackagingMatFileModel);
    				
    				Path directoryPath = Paths.get(fileUrl+f.getFileId() + "/");

    				try {
    					Files.createDirectories(directoryPath);
    				} catch (IOException e1) {
//    					return "1.파일 생성시 오류났습니다.";
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
//    					return "1.FileNotFoundException.";
    				}
    				catch (IOException e) {
//    					return "1.IOException.";
    				}
    			}
    		}
		} catch (Exception e) {
			System.out.println(e.getMessage());
//        	return e.getMessage();
        }
		return productPackagingMatFileId;
	}
	
}
