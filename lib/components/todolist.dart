import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/modules/todomodel.dart';
import 'package:todo_app/statemangment/cubit.dart';
import 'package:todo_app/statemangment/todostates.dart';

// ignore: must_be_immutable
class Todolist extends StatelessWidget {
  final TodoModel todomodel;
  int index;
  Todolist({
    super.key,
    required this.todomodel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<TodoCubit, TodoStates>(
        builder: (context, state) => Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  TodoCubit.get(context).updateTodo(TodoModel(
                    title: todomodel.title,
                    description: todomodel.description,
                    date: todomodel.date,
                    category: todomodel.category,
                    color: todomodel.color,
                    isDone: true,
                    isArchived: false,
                  ));
                },
                icon: Icons.done,
                backgroundColor: Colors.blue,
                borderRadius: BorderRadius.circular(4),
                padding: const EdgeInsets.all(5),
                spacing: 5,
              ),
              SlidableAction(
                onPressed: (context) {
                  TodoCubit.get(context).updateTodo(TodoModel(
                    title: todomodel.title,
                    description: todomodel.description,
                    date: todomodel.date,
                    category: todomodel.category,
                    color: todomodel.color,
                    isDone: false,
                    isArchived: true,
                  ));
                },
                icon: Icons.archive,
                backgroundColor: Colors.green,
                borderRadius: BorderRadius.circular(4),
                padding: const EdgeInsets.all(5),
                spacing: 5,
              ),
              SlidableAction(
                onPressed: (context) {
                  TodoCubit.get(context).deleteTodo(TodoModel(
                    title: todomodel.title,
                    description: todomodel.description,
                    date: todomodel.date,
                    category: todomodel.category,
                    color: todomodel.color,
                    isDone: false,
                    isArchived: false,
                  ));
                },
                icon: Icons.delete,
                backgroundColor: Colors.amber,
                borderRadius: BorderRadius.circular(4),
                padding: const EdgeInsets.all(5),
                spacing: 5,
              ),
            ],
          ),
          child: Card(
            color: Color(todomodel.color),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todomodel.title,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          todomodel.description,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          softWrap: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.date_range,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              todomodel.date.toString().split(' ').first,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      alignment: Alignment.topCenter,
                      child: BlocBuilder<TodoCubit, TodoStates>(
                        builder: (context, state) => Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors
                                    .orange, // Change this to your preferred color
                                border: Border.all(
                                  color: Colors
                                      .black, // Change this to your preferred color
                                  width:
                                      2, // Change this to your preferred width
                                ),
                                borderRadius: BorderRadius.circular(
                                    12), // Change this to your preferred border radius
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  todomodel.category.name
                                      .toString()
                                      .split('.')
                                      .last,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors
                                    .orange, // Change this to your preferred color
                                border: Border.all(
                                  color: Colors
                                      .black, // Change this to your preferred color
                                  width:
                                      1, // Change this to your preferred width
                                ),
                                borderRadius: BorderRadius.circular(
                                  12,
                                ), // Change this to your preferred border radius
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    1), // Change this to your preferred padding
                                child: BlocBuilder<TodoCubit, TodoStates>(
                                    builder: (context, state) {
                                  return Text(
                                    todomodel.isDone
                                        ? 'Done'
                                        : todomodel.isArchived
                                            ? 'Archived'
                                            : 'New',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
