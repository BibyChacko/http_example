import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_example/src/models/api_response.dart';

class ApiHelper{
  static final ApiHelper _instance = ApiHelper.internal();

  factory ApiHelper() => _instance;

  ApiHelper.internal();

  static final  _BASE_URL = "http://fluttertrainer.in:8000/";

  Future<ApiResponse> getData(String route) async{
    String url = _BASE_URL+route;
    try{
      Response response = await get(Uri.parse(url));
      if(response.statusCode == 200){
        return ApiResponse.fromJSON(jsonDecode(response.body));
      }else{
        return ApiResponse(false);
      }
    }catch(ex){
      print(ex);
      return ApiResponse(false);
    }
  }

  Future<ApiResponse> postData(String route,Map data) async{
    String url = _BASE_URL+route;
    try{
      Response response = await post(Uri.parse(url),body: jsonEncode(data));
      if(response.statusCode == 200){
        return ApiResponse.fromJSON(jsonDecode(response.body));
      }else{
        return ApiResponse(false);
      }
    }catch(ex){
      print(ex);
      return ApiResponse(false);
    }
  }


  Future<ApiResponse> updateData(String route,Map data) async{
    String url = _BASE_URL+route;
    try{
      Response response = await put(Uri.parse(url),body: jsonEncode(data));
      if(response.statusCode == 200){
        return ApiResponse.fromJSON(jsonDecode(response.body));
      }else{
        return ApiResponse(false);
      }
    }catch(ex){
      print(ex);
      return ApiResponse(false);
    }
  }

}