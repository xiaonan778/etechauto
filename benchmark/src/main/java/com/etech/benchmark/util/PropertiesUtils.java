package com.etech.benchmark.util;

import java.util.Properties;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 * Properties
 * 
 * @author lzl
 */
@Component
public class PropertiesUtils {
	@Autowired
	@Qualifier("appconfig")
	private Properties properties;
	private static PropertiesUtils piu;

	/**
	 * 
	 */
	@PostConstruct
	public void init() {
		piu = this;
		piu.properties = this.properties;
	}

	public static String getValue(String key) {
		return piu.properties.getProperty(key, null);
	}

}
