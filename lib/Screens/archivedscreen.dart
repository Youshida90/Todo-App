import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/components/todolist.dart';
import 'package:todo_app/modules/todomodel.dart';
import 'package:todo_app/statemangment/cubit.dart';
import 'package:todo_app/statemangment/todostates.dart';

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodoCubit, TodoStates>(
        builder: (context, state) {
          List<TodoModel> todolist = [];
          for (var item in TodoCubit.get(context).addall) {
            if (item.isArchived) {
              todolist.add(item);
            }
          }
          return todolist.isEmpty
              ? Column(
                  children: [
                    Image.asset(
                      "lib/images/Hidden-cuate.png",
                      width: 400,
                      height: 400,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "There is no archived tasks",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Lottie.asset('assets/background.json'),
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      bottom: 10,
                      child: SizedBox(
                        height: 800,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: todolist.length,
                          itemBuilder: (context, index) => Todolist(
                            index: index,
                            todomodel: todolist[index],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
