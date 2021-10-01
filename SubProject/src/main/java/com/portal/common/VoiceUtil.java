package com.portal.common;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Component;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.slf4j.Slf4j;
import software.amazon.awssdk.utils.StringUtils;

@Slf4j
@Component
public class VoiceUtil {
	
	
	public static JSONArray sortJsonArray(JSONArray array) {
		List<JSONObject> jsons = new ArrayList<JSONObject>();
		for (int i = 0; i < array.length(); i++) {
		    jsons.add(array.getJSONObject(i));
		}
		Collections.sort(jsons, new Comparator<JSONObject>() {
		    @Override
		    public int compare(JSONObject lhs, JSONObject rhs) {
		        String lid = lhs.getString("name");
		        String rid = rhs.getString("name");
		        // Here you could parse string id to integer and then compare.
		        return lid.compareTo(rid);
		    }
		});
		return new JSONArray(jsons);
		}
	
	
	
	public List<Object> parseList(String data) {
		List<Object> list = new ArrayList<Object>();
		JSONObject jsonData ;
		JSONArray arrays = new JSONArray(data);
		for(int i = 0 ; i < arrays.length() ; i++) {
			jsonData = (JSONObject) arrays.opt(i);
			JsonElement element = JsonParser.parseString(jsonData.toString());
			JsonObject objKey = element.getAsJsonObject();
			Set<Map.Entry<String, JsonElement>> entries = objKey.entrySet();
			Map<String, Object> map2 = new HashMap<String, Object>();
			for (Map.Entry<String, JsonElement> entry: entries) {
				if(StringUtils.equals(entry.getKey(), "date") ) {
					map2.put(entry.getKey(),entry.getValue().toString().substring(1, 11));
				}else {
					map2.put(entry.getKey(), entry.getValue().getAsString());
				}
			}
			list.add(map2);
		}
		return list;
	}
	
}
