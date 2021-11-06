part of 'books_cubit.dart';

abstract class BooksState extends Equatable {
  const BooksState();
}

class BooksInitial extends BooksState {
  @override
  List<Object> get props => [];
}

class BooksLoading extends BooksState{

  @override
  List<Object> get props => [];
}

class BooksLoaded extends BooksState{

  List<BooksModel> books;

  BooksLoaded(this.books);

  @override
  List<Object> get props => [books];
}

class BooksLoadError extends BooksState{

  final String errorMessage;
  BooksLoadError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
