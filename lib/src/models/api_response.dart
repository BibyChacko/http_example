

class ApiResponse{
  bool? status;
  dynamic data;

  ApiResponse(this.status,{this.data});

  factory ApiResponse.fromJSON(Map json){
    try{
      return ApiResponse(json['status'],data: json['data']);
    }catch(ex){
      print(ex);
      return ApiResponse(false,data: null);
    }
  }
}