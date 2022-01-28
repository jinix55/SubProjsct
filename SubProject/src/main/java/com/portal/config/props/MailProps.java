package com.portal.config.props;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

/**
 * 메일 설정 정보
 */
@Data
@Component
@ConfigurationProperties(prefix = "mail-props")
public class MailProps {
	private String userId;
	private String password;
	private String mailSmtpHost;
	private String mailSmtpPort;
	private String mailSmtpAuth;
	private String mailSmtpSslEnable;
	private String mailSmtpSslTrust;
	private String smtpMailUrl;
}
