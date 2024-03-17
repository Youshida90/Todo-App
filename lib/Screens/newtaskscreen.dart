import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/category/categorydropdown.dart';
import 'package:todo_app/components/todolist.dart';
import 'package:todo_app/modules/todomodel.dart';
import 'package:todo_app/statemangment/cubit.dart';
import 'package:todo_app/statemangment/todostates.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white60,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return BlocBuilder<TodoCubit, TodoStates>(
                builder: (context, state) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        //? Title field
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "ADD A NEW TASK!",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.work_outline,
                              color: Colors.deepPurple,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            labelText: 'Task Title',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your task title';
                            }
                            return null;
                          },
                          maxLength: 10,
                          controller: TodoCubit.get(context).titleController,
                        ),
                    //---------------------------------------------------------------------------------------------------------------------------------------------------------------
                        //? Discreption field
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.description_outlined,
                              color: Colors.deepPurple,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            labelText: 'Task description',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your task description';
                            }
                            return null;
                          },
                          maxLength: 200,
                          controller:
                              TodoCubit.get(context).descriptionController,
                          minLines: 1,
                          maxLines: null,
                        ),
                    //---------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        const SizedBox(
                          height: 20,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                //? Date Field
                           
                                SizedBox(
                                  width: 380,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.deepPurple,
                                      ),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      labelStyle: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                      labelText: 'Date',
                                      hintText: 'Add a Date',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please add a Date';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      FocusScope.of(context).requestFocus(
                                          FocusNode()); // to prevent the keyboard from showing
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2200),
                                      ).then((value) {
                                        TodoCubit.get(context)
                                                .dateController
                                                .text =
                                            '${value!.day}/${value.month}/${value.year}';
                                        TodoCubit.get(context).date = value;
                                      });
                                    },
                                    controller:
                                        TodoCubit.get(context).dateController,
                                  ),
                                ),
                                //---------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                //@ Reminder
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                    //---------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        //? Colors ListView
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Colors',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: BlocBuilder<TodoCubit, TodoStates>(
                              builder: (context, state) {
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: TodoCubit.get(context)
                                  .colors
                                  .length, // +1 for the ElevatedButton
                              itemBuilder: (context, index) {
                                if (index <
                                    TodoCubit.get(context).colors.length) {
                                  return GestureDetector(
                                    onTap: () {
                                      TodoCubit.get(context).selectColor(
                                          TodoCubit.get(context).colors[index]);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Color(TodoCubit.get(context)
                                            .colors[index]),
                                        shape: BoxShape.circle,
                                      ),
                                      child: TodoCubit.get(context)
                                                  .selectedcolor ==
                                              TodoCubit.get(context)
                                                  .colors[index]
                                          ? const Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  );
                                }
                                return null;
                              },
                            );
                          }),
                        ),
                    //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        //? Category
                        const SizedBox(
                          height: 15,
                        ),
                        CategoryPage(onCategorySelected: (category) {
                          TodoCubit.get(context).selectCategory(category);
                        }),
                    //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        //? Add Task Button
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  TodoCubit.get(context)
                                      .resetcancelController();
                                },
                                child: Container(
                                    height: 70,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "X",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 20),
                                    ))),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (formkey.currentState!.validate() &&
                                      TodoCubit.get(context).categoryselected !=
                                          null) {
                                    TodoCubit.get(context)
                                        .addTodoTask(TodoModel(
                                      title: TodoCubit.get(context)
                                          .titleController
                                          .text,
                                      description: TodoCubit.get(context)
                                          .descriptionController
                                          .text,
                                      date: TodoCubit.get(context).date!,
                                      category: TodoCubit.get(context)
                                          .categoryselected!,
                                      color:
                                          TodoCubit.get(context).selectedcolor,
                                      isDone: false,
                                      isArchived: false,
                                    ));
                                    Navigator.of(context).pop();
                                    TodoCubit.get(context).resetAddController();
                                  } else if (TodoCubit.get(context)
                                          .categoryselected ==
                                      null) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible:
                                          false, // Prevents the dialog from being dismissed
                                      builder: (context) => AlertDialog(
                                        title: Text(
                                          "Please select a category",
                                          style: GoogleFonts.poppins(),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Ok"))
                                        ],
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  width: 265,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple.shade500,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Add Task',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodoCubit, TodoStates>(builder: (context, state) {
        List<TodoModel> todolist = [];
        for (var item in TodoCubit.get(context).addall) {
          if (!item.isArchived && !item.isDone) {
            todolist.add(item);
          }
        }
        return todolist.isEmpty
            ? Column(
                children: [
                  Image.asset(
                    "lib/images/Task-cuate.png",
                    width: 400,
                    height: 400,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "What do you want to do today?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Tap + to add your tasks",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
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
      }),
    );
  }
}
