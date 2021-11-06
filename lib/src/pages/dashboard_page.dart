import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_example/src/bloc/books_cubit/books_cubit.dart';
import 'package:http_example/src/models/books_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: ()=>showForm(context),
        child: Icon(Icons.add),
      ),
      body: BlocListener<BooksCubit, BooksState>(
        listener: (context, state) {
          if(state is BooksLoadError){
              Fluttertoast.showToast(msg: state.errorMessage);
          }
        },
        child: SafeArea(
            child: BlocBuilder<BooksCubit, BooksState>(
              builder: (context, state) {
                if (state is BooksLoaded) {
                  List<BooksModel> books = state.books;
                  return ListView.separated(
                      itemBuilder: (context, pos) {
                        BooksModel book = books[pos];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(book.url ?? ''),
                            ListTile(
                              title: Text(book.title ?? ''),
                              subtitle: Text(book.author ?? ''),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, pos) => Divider(),
                      itemCount: books.length
                  );
                }
                else if (state is BooksLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container();
              },
            )
        ),
      ),
    );
  }

  void fetchData() {
    BlocProvider.of<BooksCubit>(context).fetchBooks();
  }

  showForm(BuildContext mainContext) {
    showDialog(
        context: context,
        builder: (context){
          TextEditingController _titleController = TextEditingController();
          TextEditingController _authorController = TextEditingController();
          GlobalKey<FormState> _formKey = GlobalKey();
          return AlertDialog(
            title: Text("Add a new book"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (val){
                      if((val??'').isEmpty){
                        return 'Please fill book title';
                      }else{
                        return null;
                      }
                    },
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: "Enter book title"
                    ),
                  ),
                  TextFormField(
                    validator: (val){
                      if((val??'').isEmpty){
                        return 'Please fill author name';
                      }else{
                        return null;
                      }
                    },
                    controller: _authorController,
                    decoration: InputDecoration(
                        hintText: "Enter author name"
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){Navigator.pop(context);},child: Text('CANCEL'),),
              TextButton(onPressed: () async{
                if(!_formKey.currentState!.validate()){
                  return;
                }
                String title = _titleController.text;
                String author = _authorController.text;
                bool status = await BlocProvider.of<BooksCubit>(mainContext).addBooks(title, author);
                Navigator.pop(context);
                if(status){
                  Fluttertoast.showToast(msg: "Book added succssfully");
                }else{
                  Fluttertoast.showToast(msg: "Failed to add book");
                }
              },child: Text('SUBMIT'),),
            ],
          );
        }
    );
  }


}
