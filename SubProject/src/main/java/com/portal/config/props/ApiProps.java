package com.portal.config.props;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

/**
 * UDB 설정 정보
 */
@Data
@Component
@ConfigurationProperties(prefix = "naver-api-props")
public class ApiProps {
	private String id;
	private String cookieId;
	private String domainId;
	private String uploadPath;
}
