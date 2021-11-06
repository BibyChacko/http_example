


import 'package:http_example/src/models/api_response.dart';
import 'package:http_example/src/web_service/api_helper.dart';

class BooksRepository{


  Future<ApiResponse> fetchBooks() async{
    String route = "books";
    ApiResponse response = await ApiHelper.internal().getData(route);
    return response;
  }

  Future<ApiResponse> addBook(String title,String authorName) async{
    String route = "add-books";
    Map sendData = {
      'title': title,
      'author':authorName
    };
    ApiResponse response = await ApiHelper.internal().postData(route, sendData);
    return response;
  }

}