import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_example/src/bloc/books_cubit/books_cubit.dart';
import 'pages/dashboard_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "HTTP Example",
        theme: ThemeData(
            primarySwatch: Colors.blue
        ),
        home: BlocProvider(
          create: (context) => BooksCubit(),
          child: DashboardPage(),
        )
    );
  }
}
