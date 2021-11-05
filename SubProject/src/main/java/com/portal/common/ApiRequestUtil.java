package com.portal.common;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHeaders;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.ssl.SSLContextBuilder;
import org.apache.http.ssl.TrustStrategy;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Component;

import com.portal.config.props.ApiProps;

import lombok.extern.slf4j.Slf4j;

/**
 * 외부 API 요청 Util
 * 
 * @since 2020.12.18.
 */
@Slf4j
@Component
public class ApiRequestUtil {
	
	@Resource(name="apiProps")
	private ApiProps props; 

	/**
	 * HTTP timeout 설정
	 */
	private RequestConfig getRequestConfig() {
		// timeout 기본 설정 30초
		return RequestConfig.custom().setSocketTimeout(30000).setConnectTimeout(30000)
				.setConnectionRequestTimeout(30000).build();
	}
	
	/**
	 * 사설 인증서 검증 우회 HttpClient 반환
	 * 사설 인증서인 경우 HttpClient client = HttpClients.createDefault();를 HttpClient client = getHttpClient();로 변경
	 */
	public CloseableHttpClient getHttpClient() throws Exception {
		return HttpClients.custom().setSSLHostnameVerifier(NoopHostnameVerifier.INSTANCE)
				.setSSLContext(new SSLContextBuilder().loadTrustMaterial(null, new TrustStrategy() {
					public boolean isTrusted(X509Certificate[] arg0, String arg1) throws CertificateException {
						return true;
					}
				}).build()).build();
	}

	/**
	 * GET방식의 url 및 파라미터 가공
	 * 
	 * @param String             url 요청 주소
	 * @param Map<String,String> param 파라메터
	 * @return String
	 */	
	public String buildGetUrl(String url, Map<String, String> param) {
		String urlWithParam = StringUtils.EMPTY;
		try {
			// 요청 객체 생성
			URIBuilder builder = new URIBuilder(new URI(url));
			// 요청 파라메터 처리
			if (param != null) {
				List<NameValuePair> params = new ArrayList<NameValuePair>();
				for (String key : param.keySet()) {
					params.add(new BasicNameValuePair(key, param.get(key)));
				}
				// 요청 파라메터 추가
				builder.addParameters(params);
			}
			urlWithParam = builder.toString();
		} catch (URISyntaxException uriSyntaxException) {
			log.warn("외부 API GET - param 요청 중 URISyntexException 발생");
			log.warn(uriSyntaxException.getMessage());			
		}
		return urlWithParam;
	}	
	
	/**
	 * 외부 API 요청 - GET
	 * 
	 * @param String             url 요청 주소
	 * @param Map<String,String> param 파라메터
	 * @return String
	 */
	public String requestGet(String url, Map<String, String> param) {
		String result = StringUtils.EMPTY;
		
		try {
			//url 생성
			String urlWithParam = buildGetUrl(url, param);

			// 요청 객체 생성
			HttpClient client = HttpClients.createDefault();
			HttpGet request = new HttpGet(urlWithParam);
			// request config
			request.setConfig(getRequestConfig());

			// 요청 후 응답 변환
			HttpResponse response = client.execute(request);
			HttpEntity entity = response.getEntity();
			result = EntityUtils.toString(entity, StandardCharsets.UTF_8);
			log.debug(result);
		} catch (IOException ioException) {
			log.warn("외부 API GET - param 요청 중 IOException 발생");
			log.warn(ioException.getMessage());
		} catch (ParseException parseException) {
			log.warn("외부 API GET - param 요청 중 ParseException 발생");
			log.warn(parseException.getMessage());
		} catch (Exception e) {
			log.warn("외부 API GET - param 요청 중 Exception 발생");
			log.warn(e.getMessage());
		}
		log.debug("APIREQUESTUTILL test: {}", result);
		return result;
	}

	/**
	 * 외부 API 요청 - POST with Parameter
	 * 
	 * @param String             url 요청 주소
	 * @param Map<String,String> param 파라메터
	 * @return String
	 */
	public String requestPost(String url, Map<String, String> param) {
		String result = null;

		try {
			// 요청 객체 생성
			HttpClient client = HttpClients.createDefault();
			HttpPost request = new HttpPost(url);
			// request config
			request.setConfig(getRequestConfig());

			// 요청 파라메터 처리
			if (param != null) {
				List<NameValuePair> params = new ArrayList<NameValuePair>();
				for (String key : param.keySet()) {
					params.add(new BasicNameValuePair(key, param.get(key)));
				}
				request.setEntity(new UrlEncodedFormEntity(params, "UTF-8"));
			}

			// 요청 후 응답 처리
			HttpResponse response = client.execute(request);
			HttpEntity entity = response.getEntity();
			result = EntityUtils.toString(entity, StandardCharsets.UTF_8);
			log.debug(result);
		} catch (UnsupportedEncodingException unsupportedEncodingException) {
			log.warn("외부 API POST - param 요청 중 UnsupportedEncodingException 발생");
			log.warn(unsupportedEncodingException.getMessage());
		} catch (IOException ioException) {
			log.warn("외부 API POST - param 요청 중 IOException 발생");
			log.warn(ioException.getMessage());
		} catch (ParseException parseException) {
			log.warn("외부 API POST - param 요청 중 ParseException 발생");
			log.warn(parseException.getMessage());
		} catch (Exception e) {
			log.warn("외부 API POST - param 요청 중 Exception 발생");
			log.warn(e.getMessage());
		}
		return result;
	}

	/**
	 * 외부 API 요청 - POST with body from JSONObject
	 * 
	 * @param String     url 요청 주소
	 * @param JSONObject body
	 * @return
	 */
	public String requestPost(String url, JSONObject body) {
		String result = null;
		if (body != null) {
			result = requestPost(url, body.toString());
		} else {
			result = requestPost(url, StringUtils.EMPTY);
		}
		return result;
	}

	/**
	 * 외부 API 요청 - POST with body from JSONArray
	 * 
	 * @param String    url 요청 주소
	 * @param JSONArray body
	 * @return
	 */
	public String requestPost(String url, JSONArray body) {
		String result = null;
		if (body != null) {
			result = requestPost(url, body.toString());
		} else {
			result = requestPost(url, StringUtils.EMPTY);
		}
		return result;
	}

	/**
	 * 외부 API 요청 - POST with body from String
	 * 
	 * @param String url 요청 주소
	 * @param String body
	 * @return
	 */
	public String requestPost(String url, String body) {
		String result = null;

		try {
			// 요청 객체 생성
			HttpClient client = HttpClients.createDefault();
			HttpPost request = new HttpPost(url);

			// body String 처리
			request.setHeader(HttpHeaders.CONTENT_TYPE, "application/json; charset=utf-8");
			request.setEntity(new StringEntity(body, StandardCharsets.UTF_8));

			// 요청 후 응답 처리
			HttpResponse response = client.execute(request);
			HttpEntity entity = response.getEntity();
			result = EntityUtils.toString(entity, StandardCharsets.UTF_8);
			log.debug("requestPost: " + result);

		} catch (UnsupportedEncodingException unsupportedEncodingException) {
			log.warn("외부 API POST - body 요청 중 UnsupportedEncodingException 발생");
			log.warn(unsupportedEncodingException.getMessage());
		} catch (IOException ioException) {
			log.warn("외부 API POST - body 요청 중 IOException 발생");
			log.warn(ioException.getMessage());
		} catch (ParseException parseException) {
			log.warn("외부 API POST - body 요청 중 ParseException 발생");
			log.warn(parseException.getMessage());
		} catch (Exception e) {
			log.warn("외부 API POST - body 요청 중 Exception 발생");
			log.warn(e.getMessage());
		}
		return result;
	}
	
	/**
	 * 외부 API 요청 - GET
	 * 
	 * @param String             url 요청 주소
	 * @param Map<String,String> param 파라메터
	 * @return String
	 */
	public String requesChatbotCloudetGet(String url, Map<String, String> param) {
		String result = StringUtils.EMPTY;
		
		try {
			//url 생성
			String urlWithParam = buildGetUrl(url, param);

			// 요청 객체 생성
			HttpClient client = HttpClients.createDefault();
			HttpGet request = new HttpGet(urlWithParam);
			// request config
			request.setConfig(getRequestConfig());
			
			String cookie = props.getCookieId();
			 
			request.addHeader("Accept","application/json, text/plain, */*");
			request.addHeader("Accept-Encoding","gzip, deflate, br");
			request.addHeader("Accept-Language","ko,en;q=0.9,en-US;q=0.8");
			request.addHeader("Cache-control","no-cache");
			request.addHeader("Connection","keep-alive");
			request.addHeader("Cookie",cookie);
			request.addHeader("Host","clovachatbot.fin-ncloud.com");
			request.addHeader("Pragma","no-cache");
			request.addHeader("Referer","https://clovachatbot.fin-ncloud.com/indicator?domainId=372");
			request.addHeader("sec-ch-ua","\"Not;A Brand\";v=\"99\", \"Microsoft Edge\";v=\"91\", \"Chromium\";v=\"91\"");
			request.addHeader("sec-ch-ua-mobile","?0");
			request.addHeader("Sec-Fetch-Dest","empty");
			request.addHeader("Sec-Fetch-Mode","cors");
			request.addHeader("Sec-Fetch-Site","same-origin");
			request.addHeader("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36 Edg/91.0.864.41");
			request.addHeader("X-Requested-With","XMLHttpRequest");
			
			// 요청 후 응답 변환
			HttpResponse response = client.execute(request);
			HttpEntity entity = response.getEntity();
			result = EntityUtils.toString(entity, StandardCharsets.UTF_8);
			log.debug(result);
		} catch (IOException ioException) {
			log.warn("외부 API GET - param 요청 중 IOException 발생");
			log.warn(ioException.getMessage());
		} catch (ParseException parseException) {
			log.warn("외부 API GET - param 요청 중 ParseException 발생");
			log.warn(parseException.getMessage());
		} catch (Exception e) {
			log.warn("외부 API GET - param 요청 중 Exception 발생");
			log.warn(e.getMessage());
		}
		log.debug("APIREQUESTUTILL test: {}", result);
		return result;
	}
	
	public String requesKakaoAdressGet(String url, Map<String, String> param) {
		String result = StringUtils.EMPTY;
		url = "https://dapi.kakao.com/v2/local/search/address.json?analyze_type=similar&page=1&size=10&query=%EB%B6%88%EA%B4%91%EB%8F%99";
		try {
			//url 생성
			String urlWithParam = buildGetUrl(url, param);

			// 요청 객체 생성
			HttpClient client = HttpClients.createDefault();
			HttpGet request = new HttpGet(urlWithParam);
			// request config
			request.setConfig(getRequestConfig());
			
			String cookie = props.getCookieId();
			 
			request.addHeader("Authorization","KakaoAK "+Constant.ApiKey.KAKAO_REST_API_KEY);

			
			// 요청 후 응답 변환
			HttpResponse response = client.execute(request);
			HttpEntity entity = response.getEntity();
			result = EntityUtils.toString(entity, StandardCharsets.UTF_8);
			log.debug(result);
		} catch (IOException ioException) {
			log.warn("외부 API GET - param 요청 중 IOException 발생");
			log.warn(ioException.getMessage());
		} catch (ParseException parseException) {
			log.warn("외부 API GET - param 요청 중 ParseException 발생");
			log.warn(parseException.getMessage());
		} catch (Exception e) {
			log.warn("외부 API GET - param 요청 중 Exception 발생");
			log.warn(e.getMessage());
		}
		log.debug("APIREQUESTUTILL requesKakaoAdressGet test: {}", result);
		return result;
	}
	
	public String requesGetWeather(String url, Map<String, String> param) {
		String result = StringUtils.EMPTY;
		
    	String apiKey = "P2U/o5nc8LA8bshLYK2RfTx5d3IrnLlfqJZW57JooVetMMGiTrXdHo43HEhsD/WFiC50Y9IJkEXXuAmlLcMYaQ==";
    	
    	//단기예보
    	String weatherUrl1 = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";
    	Map<String, String> weatherParam1 = new HashMap<String, String>();
    	weatherParam1.put("serviceKey", apiKey);
    	weatherParam1.put("pageNo", "1");			// 페이지번호
    	weatherParam1.put("numOfRows", "50");		// 한 페이지 결과 수
    	weatherParam1.put("dataType", "JSON");	// 요청자료형식(XML/JSON)Default: XML
    	weatherParam1.put("base_date", "20211026");	//'21년 10월 21일발표
    	weatherParam1.put("base_time", "0500");		// 05시 발표
    	weatherParam1.put("nx", "55");				// 예보지점의 X 좌표값
    	weatherParam1.put("ny", "127");				// 예보지점의 Y 좌표값
		
    	//중기예보
    	String weatherUrl2 = "http://apis.data.go.kr/1360000/MidFcstInfoService/getMidFcst";
    	Map<String, String> weatherParam2 = new HashMap<String, String>();
    	weatherParam2.put("serviceKey", apiKey);
    	weatherParam2.put("pageNo", "1");	// 페이지번호
    	weatherParam2.put("numOfRows", "10");	// 한 페이지 결과 수
    	weatherParam2.put("dataType", "JSON");	// 요청자료형식(XML/JSON)Default: XML
    	weatherParam2.put("stnId", "109");	// 108 전국, 109 서울, 인천, 경기도 등 (활용가이드 하단 참고자료 참조)
    	weatherParam2.put("tmFc", "202110261800");	//	-일 2회(06:00,18:00)회 생성 되며 발표시각을 입력 YYYYMMDD0600 (1800)-최근 24시간 자료만 제공
    	
    	url = weatherUrl2;
    	param = weatherParam2;
    	
		try {
			//url 생성
			String urlWithParam = buildGetUrl(url, param);

			// 요청 객체 생성
			HttpClient client = HttpClients.createDefault();
			HttpGet request = new HttpGet(urlWithParam);
			// request config
			request.setConfig(getRequestConfig());
			
			// 요청 후 응답 변환
			HttpResponse response = client.execute(request);
			HttpEntity entity = response.getEntity();
			result = EntityUtils.toString(entity, StandardCharsets.UTF_8);
			log.debug(result);
		} catch (IOException ioException) {
			log.warn("외부 API GET - param 요청 중 IOException 발생");
			log.warn(ioException.getMessage());
		} catch (ParseException parseException) {
			log.warn("외부 API GET - param 요청 중 ParseException 발생");
			log.warn(parseException.getMessage());
		} catch (Exception e) {
			log.warn("외부 API GET - param 요청 중 Exception 발생");
			log.warn(e.getMessage());
		}
		log.debug("APIREQUESTUTILL requesGetWeather test: {}", result);
		return result;
	}
	
	
	public String requesGetDust(String url, Map<String, String> param) {
		String apiKey = "P2U/o5nc8LA8bshLYK2RfTx5d3IrnLlfqJZW57JooVetMMGiTrXdHo43HEhsD/WFiC50Y9IJkEXXuAmlLcMYaQ==";
		String result = StringUtils.EMPTY;
		String dustUrl = "http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst";
    	Map<String, String> dustParam = new HashMap<String, String>();
    	dustParam.put("serviceKey", apiKey);
    	dustParam.put("returnType", "JSON");
    	dustParam.put("numOfRows", "100");
    	dustParam.put("pageNo", "1");
    	dustParam.put("itemCode", "PM10");
    	dustParam.put("dataGubun", "DAILY");
    	dustParam.put("searchCondition", "WEEK");
    	
    	url = dustUrl;
    	param = dustParam;
    	
		try {
			//url 생성
			String urlWithParam = buildGetUrl(url, param);

			// 요청 객체 생성
			HttpClient client = HttpClients.createDefault();
			HttpGet request = new HttpGet(urlWithParam);
			// request config
			request.setConfig(getRequestConfig());
			
//			request.addHeader("Authorization","KakaoAK "+Constant.ApiKey.KAKAO_REST_API_KEY);

			
			// 요청 후 응답 변환
			HttpResponse response = client.execute(request);
			HttpEntity entity = response.getEntity();
			result = EntityUtils.toString(entity, StandardCharsets.UTF_8);
			log.debug(result);
		} catch (IOException ioException) {
			log.warn("외부 API GET - param 요청 중 IOException 발생");
			log.warn(ioException.getMessage());
		} catch (ParseException parseException) {
			log.warn("외부 API GET - param 요청 중 ParseException 발생");
			log.warn(parseException.getMessage());
		} catch (Exception e) {
			log.warn("외부 API GET - param 요청 중 Exception 발생");
			log.warn(e.getMessage());
		}
		log.debug("APIREQUESTUTILL requesGetDust test: {}", result);
		return result;
	}
}
