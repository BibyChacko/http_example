

class BooksModel{

  String? title;
  String? author;
  String? url;

  BooksModel({this.title, this.author, this.url});


  factory BooksModel.fromJSON(Map json){
    try{
      return BooksModel(title: json['title'],author: json['author'],url: json['url']);
    }catch(ex){
      print(ex);
      return BooksModel();
    }
  }

}