import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/Screens/homescreen.dart';
import 'package:todo_app/category/category.dart';
import 'package:todo_app/modules/todomodel.dart';
import 'package:todo_app/statemangment/blocobserver.dart';
import 'package:todo_app/statemangment/cubit.dart';

Future<void> main() async {
  Hive.registerAdapter(TodoModelAdapter());
  Hive.registerAdapter(Category1Adapter());
  await Hive.initFlutter();
  await Hive.openBox("TodoBox");
  Bloc.observer = MyBlocObserver();
  runApp(
    const TodoApp(),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoCubit()..getBox(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
