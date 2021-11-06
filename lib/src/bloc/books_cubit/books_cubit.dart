import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http_example/src/bloc/books_cubit/books_repository.dart';
import 'package:http_example/src/models/api_response.dart';
import 'package:http_example/src/models/books_model.dart';

part 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  BooksCubit() : super(BooksInitial());

  BooksRepository repository = BooksRepository();

  fetchBooks() async{
    emit(BooksLoading());
    ApiResponse response = await repository.fetchBooks();
    if(response.status??false){
      List<BooksModel> books = response.data.map<BooksModel>((e)=>BooksModel.fromJSON(e)).toList();
      emit(BooksLoaded(books));
    }else{
      emit(BooksLoadError("Internal server error"));
      await Future.delayed(Duration(seconds: 2));
      emit(BooksLoaded([]));
    }
  }


  Future<bool> addBooks(String title,String author) async{
    ApiResponse apiResponse = await repository.addBook(title, author);
    return apiResponse.status??false;
  }


}
