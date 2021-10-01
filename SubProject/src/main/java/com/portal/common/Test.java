package com.portal.common;

import java.io.IOException;
import java.util.UUID;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class Test {

   private static final String url = "https://ac86e44bd82542c39b6bfbc2fb6f488a.test-apigw.ntruss.com";
   private static final String key = "90d97f24-6f0b-4d9a-bbf9-ed391b44c6ea";
   private static final String version = "2";
   private static final String write_api_prefix = "/write/v1";
   private static final String read_api_prefix = "/read/v1";

   public static void main(String[] args) throws IOException {
      OkHttpClient client = new OkHttpClient().newBuilder()
         .build();
      Response addCampaignTargetResponse = invokeAddCampaignTarget(client);
      System.out.println("Response:" + addCampaignTargetResponse.body().string());
      Response getCampaignResultResponse = invokeGetCampaignResult(client);
      System.out.println("Response:" + getCampaignResultResponse.body().string());
      Response campaignCallStopResponse = invokeCampaignCallStop(client);
      System.out.println("Response status:" + campaignCallStopResponse.code());
      Response getCampaignListResponse = invokeGetCampaignList(client);
      System.out.println("Response:" + getCampaignListResponse.body().string());
      Response addCampaigResponse = invokeAddCampaign(client);
      System.out.println("Response:" + addCampaigResponse.body().string());
      Response updateCampaignStatusResponse = invokeUpdateCampaignStatus(client);
      System.out.println("Response status:" + updateCampaignStatusResponse.code());
      Response getPhoneListResponse = invokeGetPhoneList(client);
      System.out.println("Response:" + getPhoneListResponse.body().string());
      Response getAgentListResponse = invokeGetAgentList(client);
      System.out.println("Response:" + getAgentListResponse.body().string());
      Response getCampaignTargetDetailResponse = invokeGetCampaignTargetDetail(client);
      System.out.println("Response:" + getCampaignTargetDetailResponse.body().string());
      Response deleteCampaignResponse = invokeDeleteCampaign(client);
      System.out.println("Response status:" + deleteCampaignResponse.code());
   }

   public static Response invokeAddCampaignTarget(OkHttpClient client) throws IOException {
      String json = "{\n"
         + "    \"name\": \"test100088\",\n"
         + "    \"description\": \"description1\",\n"
         + "    \"targetNumbers\": [\n"
         + "        {\n"
         + "            \"number\": \"1122334455\",\n"
         + "            \"key1\": \"e123qa\",\n"
         + "            \"key2\": \"3f\"\n"
         + "        },\n"
         + "        {\n"
         + "            \"number\": \"1020304050\"\n"
         + "        }\n"
         + "    ]\n"
         + "}";
      RequestBody body = RequestBody.create(MediaType.parse("application/json"), json);
      Request request = new Request.Builder()
         .url(
            url + write_api_prefix + "/campaign/target?contactCenterId=1")
         .method("POST", body)
         .addHeader("X-CLOVA-AICALL-API-KEY", key)
         .addHeader("X-CLOVA-AICALL-API-VERSION", version)
         .addHeader("X-CLOVA-AICALL-TRACE-ID", UUID.randomUUID().toString())
         .build();
      System.out.println(request);
      return client.newCall(request).execute();
   }

   public static Response invokeGetCampaignResult(OkHttpClient client) throws IOException {
      Request request = new Request.Builder()
         .url(url + read_api_prefix + "/campaign/result/74?contactCenterId=1")
         .method("GET", null)
         .addHeader("X-CLOVA-AICALL-API-KEY", key)
         .addHeader("X-CLOVA-AICALL-API-VERSION", version)
         .addHeader("X-CLOVA-AICALL-TRACE-ID", UUID.randomUUID().toString())
         .build();
      System.out.println(request);
      return client.newCall(request).execute();
   }

   public static Response invokeCampaignCallStop(OkHttpClient client) throws IOException {
      String json = "{\n"
         + "    \"campaignId\": 34,\n"
         + "    \"targetNumbers\": [\n"
         + "        {\n"
         + "            \"number\": \"1122334455\",\n"
         + "            \"key1\": \"e123qa\",\n"
         + "            \"key2\": \"3f\"\n"
         + "        },\n"
         + "        {\n"
         + "            \"number\": \"1020304050\"\n"
         + "        }\n"
         + "    ]\n"
         + "}";
      RequestBody body = RequestBody.create(MediaType.parse("application/json"), json);
      Request request = new Request.Builder()
         .url(url + write_api_prefix + "/campaign/call/stop?contactCenterId=1")
         .method("POST", body)
         .addHeader("X-CLOVA-AICALL-API-KEY", key)
         .addHeader("X-CLOVA-AICALL-API-VERSION", version)
         .addHeader("X-CLOVA-AICALL-TRACE-ID", UUID.randomUUID().toString())
         .build();
      System.out.println(request);
      return client.newCall(request).execute();
   }

   public static Response invokeGetCampaignList(OkHttpClient client) throws IOException {
      Request request = new Request.Builder()
         .url(url + read_api_prefix + "/campaign?contactCenterId=1")
         .method("GET", null)
         .addHeader("X-CLOVA-AICALL-API-KEY", key)
         .addHeader("X-CLOVA-AICALL-API-VERSION", version)
         .addHeader("X-CLOVA-AICALL-TRACE-ID", UUID.randomUUID().toString())
         .build();
      System.out.println(request);
      return client.newCall(request).execute();
   }

   public static Response invokeGetPhoneList(OkHttpClient client) throws IOException {
      Request request = new Request.Builder()
         .url(url + read_api_prefix + "/phone?page=1&size=10&createType=REGISTER&contactCenterId=1")
         .method("GET", null)
         .addHeader("X-CLOVA-AICALL-API-KEY", key)
         .addHeader("X-CLOVA-AICALL-API-VERSION", version)
         .addHeader("X-CLOVA-AICALL-TRACE-ID", UUID.randomUUID().toString())
         .build();
      System.out.println(request);
      return client.newCall(request).execute();
   }

   public static Response invokeGetAgentList(OkHttpClient client) throws IOException {
      Request request = new Request.Builder()
         .url(url + read_api_prefix + "/agent?page=1&size=10&contactCenterId=1")
         .method("GET", null)
         .addHeader("X-CLOVA-AICALL-API-KEY", key)
         .addHeader("X-CLOVA-AICALL-API-VERSION", version)
         .addHeader("X-CLOVA-AICALL-TRACE-ID", UUID.randomUUID().toString())
         .build();
      System.out.println(request);
      return client.newCall(request).execute();
   }

   public static Response invokeGetCampaignTargetDetail(OkHttpClient client) throws IOException {
      Request request = new Request.Builder()
         .url(url + read_api_prefix + "/campaign/target/1?contactCenterId=1")
         .method("GET", null)
         .addHeader("X-CLOVA-AICALL-API-KEY", key)
         .addHeader("X-CLOVA-AICALL-API-VERSION", version)
         .addHeader("X-CLOVA-AICALL-TRACE-ID", UUID.randomUUID().toString())
         .build();
      System.out.println(request);
      return client.newCall(request).execute();
   }

   public static Response invokeAddCampaign(OkHttpClient client) throws IOException {
      String json = "{\n"
         + "    \"name\": \"test_0119\",\n"
         + "    \"agentId\": 1,\n"
         + "    \"retryTimes\": 3,\n"
         + "    \"scheduleFromDate\": \"2021-11-01\",\n"
         + "    \"scheduleToDate\": \"2021-11-11\",\n"
         + "    \"scheduleFromTime\": \"09:00\",\n"
         + "    \"scheduleToTime\": \"09:00\",\n"
         + "    \"targetId\": 63,\n"
         + "    \"callerDisplayNumberId\":74\n"
         + "}";
      RequestBody body = RequestBody.create(MediaType.parse("application/json"), json);
      Request request = new Request.Builder()
         .url(url + write_api_prefix + "/campaign?contactCenterId=1")
         .method("POST", body)
         .addHeader("X-CLOVA-AICALL-API-KEY", key)
         .addHeader("X-CLOVA-AICALL-API-VERSION", version)
         .addHeader("X-CLOVA-AICALL-TRACE-ID", UUID.randomUUID().toString())
         .build();
      System.out.println(request);
      return client.newCall(request).execute();
   }

   public static Response invokeUpdateCampaignStatus(OkHttpClient client) throws IOException {
      Request request = new Request.Builder()
         .url(url + write_api_prefix + "/campaign/status/94?contactCenterId=1&status=1")
         .method("PUT", RequestBody.create(MediaType.parse("application/json"), "{}"))
         .addHeader("X-CLOVA-AICALL-API-KEY", key)
         .addHeader("X-CLOVA-AICALL-API-VERSION", version)
         .addHeader("X-CLOVA-AICALL-TRACE-ID", UUID.randomUUID().toString())
         .build();
      System.out.println(request);
      return client.newCall(request).execute();
   }

   public static Response invokeDeleteCampaign(OkHttpClient client) throws IOException {
      Request request = new Request.Builder()
         .url(url + write_api_prefix + "/campaign?contactCenterId=1&ids=1,94")
         .method("PUT", RequestBody.create(MediaType.parse("application/json"), "{}"))
         .addHeader("X-CLOVA-AICALL-API-KEY", key)
         .addHeader("X-CLOVA-AICALL-API-VERSION", version)
         .addHeader("X-CLOVA-AICALL-TRACE-ID", UUID.randomUUID().toString())
         .build();
      System.out.println(request);
      return client.newCall(request).execute();
   }
}
