// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/statemangment/cubit.dart';
import 'package:todo_app/statemangment/todostates.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late PageController pageController = PageController();
    return BlocBuilder<TodoCubit, TodoStates>(
      builder: (context, state) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          //this color must be equal to the WaterDropNavBar backgroundColor
          systemNavigationBarColor: Colors.white60,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          appBar: AppBar(
            //@ The title logic
            title: Center(child: Text(TodoCubit.get(context).getTitle())),
            titleTextStyle: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
            //^ The actions logic
            backgroundColor: Colors.deepPurple,
          ),

          //? Logic for the bottom navigation bar
          bottomNavigationBar: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 4),
                    blurRadius: 8.0)
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: WaterDropNavBar(
                backgroundColor: Colors.white,
                onItemSelected: (int index) {
                  TodoCubit.get(context).changeBottomNav(index);
                  pageController.animateToPage(
                    TodoCubit.get(context).currentIndex,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutQuad,
                  );
                },
                selectedIndex: TodoCubit.get(context).currentIndex,
                barItems: <BarItem>[
                
                  BarItem(
                    filledIcon: Icons.home,
                    outlinedIcon: Icons.home_outlined,
                  ),
                  BarItem(
                      filledIcon: Icons.done,
                      outlinedIcon: Icons.done_all_outlined),
                  BarItem(
                    filledIcon: Icons.archive,
                    outlinedIcon: Icons.archive_outlined,
                  ),
                ],
              ),
            ),
          ),
          body: BlocBuilder<TodoCubit, TodoStates>(
            builder: (context, state) => PageView(
              controller: pageController,
              children: [
                TodoCubit.get(context).getCurrentPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* 
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<int>(
                          value: TodoCubit.get(context).selectedYear,
                          items: List.generate(11, (index) {
                            int year = DateTime.now().year - 10 + index;
                            return DropdownMenuItem<int>(
                              value: year,
                              child: Text('$year'),
                            );
                          }),
                          onChanged: (int? newValue) {
                            //? setstate
                            TodoCubit.get(context).changeYear(newValue!);
                          },
                        ),
                        DropdownButton<String>(
                          value: DateFormat('MMM').format(DateTime(
                              TodoCubit.get(context).selectedYear,
                              TodoCubit.get(context).selectedMonth)),
                          items: List.generate(12, (index) {
                            return DropdownMenuItem<String>(
                              value: DateFormat('MMM').format(DateTime(
                                  TodoCubit.get(context).selectedYear,
                                  index + 1)),
                              child: Text(DateFormat('MMM').format(DateTime(
                                  TodoCubit.get(context).selectedYear,
                                  index + 1))),
                            );
                          }),
                          onChanged: (String? newValue) {
                            //? setstate
                            TodoCubit.get(context).changeMonth(newValue!);
                          },
                        ),
                      ],
                    ),
                  ),
                  EasyInfiniteDateTimeLine(
                    firstDate: DateTime(TodoCubit.get(context).selectedYear,
                        TodoCubit.get(context).selectedMonth),
                    focusDate: DateTime(TodoCubit.get(context).selectedYear,
                        TodoCubit.get(context).selectedMonth),
                    lastDate: DateTime(TodoCubit.get(context).selectedYear,
                            TodoCubit.get(context).selectedMonth + 1)
                        .subtract(const Duration(days: 1)),
                    onDateChange: (selectedDate) {
                      //`selectedDate` the new date selected.
                    },
                    activeColor: const Color(0xff85A389),
                    dayProps: const EasyDayProps(
                      todayHighlightStyle: TodayHighlightStyle.withBackground,
                      todayHighlightColor: Color(0xffE1ECC8),
                    ),
                  ),
                                    // Image.asset(
                  //   "lib/images/Task-cuate.png",
                  //   width: 400,
                  //   height: 400,
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // const Text(
                  //   "What do you want to do today?",
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // const Text(
                  //   "Tap + to add your tasks",
                  //   style:
                  //       TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  // ),
*/

/* 
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components/categorydropdown.dart';
import 'package:todo_app/modules/cubit.dart';
import 'package:todo_app/modules/tasks_data.dart';
import 'package:todo_app/modules/todostate.dart';
import 'package:todo_app/screens/calendarscreen.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var tasks = TodoCubit.get(context).allTasks;
    return BlocBuilder<TodoCubit, TodoStates>(
      builder: (context, state) => Scaffold(
          //? to remove the image when adding a task
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return BlocBuilder<TodoCubit, TodoStates>(
                    builder: (context, state) => Padding(
                      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                      child: Form(
                        key: TodoCubit.get(context).formKey,
                        child: Column(
                          children: [
                            //---------------------------------------------------------------------------------------------------------------------------------------------------
                            //? Title field
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                labelText: 'Task Title',
                                hintText: 'Enter your task title',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your task title';
                                }
                                return null;
                              },
                              maxLength: 10,
                              controller:
                                  TodoCubit.get(context).titleController,
                            ),
                            //---------------------------------------------------------------------------------------------------------------------------------------------------------------
                            //? Discreption field
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                labelText: 'Task discreption',
                                hintText: 'Enter your task discreption',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your task discreption';
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
                              height: 16,
                            ),
                            Row(
                              children: [
                                //! Time field
                                SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      labelText: 'Time',
                                      hintText: 'Add a time',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please add a time';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      FocusScope.of(context).requestFocus(
                                          FocusNode()); // to prevent the keyboard from showing
                                      Navigator.of(context)
                                          .push(
                                        showPicker(
                                          context: context,
                                          value: TodoCubit.get(context).time,
                                          sunrise: const TimeOfDay(
                                              hour: 6, minute: 0), // optional
                                          sunset: const TimeOfDay(
                                              hour: 18, minute: 0), // optional
                                          duskSpanInMinutes: 120, // optional
                                          onChange: TodoCubit.get(context)
                                              .onTimeChanged,
                                          iosStylePicker:
                                              TodoCubit.get(context).iosStyle,
                                        ),
                                      )
                                          .then((value) {
                                        TodoCubit.get(context)
                                                .timeController
                                                .text =
                                            (value as TimeOfDay)
                                                .format(context);
                                      });
                                    },
                                    controller:
                                        TodoCubit.get(context).timeController,
                                  ),
                                ),
                                //---------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                //? Date Field
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
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
                                ElevatedButton(
                                  onPressed: () async {
                                    if (TodoCubit.get(context).date != null) {
                                      await AwesomeNotifications()
                                          .createNotification(
                                        content: NotificationContent(
                                            id: 1,
                                            channelKey: 'Todo_App_Channel',
                                            title: TodoCubit.get(context)
                                                .titleController
                                                .text,
                                            body: TodoCubit.get(context)
                                                .descriptionController
                                                .text,
                                            displayOnForeground: true,
                                            displayOnBackground: true,
                                            showWhen: true,
                                            payload: {
                                              'uuid': 'user-profile-uuid'
                                            }),
                                        schedule: NotificationCalendar(
                                          hour:
                                              TodoCubit.get(context).time.hour,
                                          minute: TodoCubit.get(context)
                                              .time
                                              .minute,
                                          second: 0,
                                          day: TodoCubit.get(context)
                                              .date!
                                              .day, // add this
                                          month: TodoCubit.get(context)
                                              .date!
                                              .month, // add this
                                          year: TodoCubit.get(context)
                                              .date!
                                              .year, // add this
                                          repeats: true,
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text("Set a Reminder"),
                                ),
                              ],
                            ),
                            //---------------------------------------------------------------------------------------------------------------------------------------------------------------------
                            //? Colors ListView
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              'Colors',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: BlocBuilder<TodoCubit, TodoStates>(
                                  builder: (context, state) {
                                return ListView.builder(
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
                                              TodoCubit.get(context)
                                                  .colors[index]);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          width: 80,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: TodoCubit.get(context)
                                                .colors[index],
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                              height: 16,
                            ),
                            CategoryPage(onCategorySelected: (category) {
                              TodoCubit.get(context).selectCategory(category);
                            }),
                            //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                            //? Add Task Button
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    TodoCubit.get(context).resetController();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (TodoCubit.get(context)
                                            .formKey
                                            .currentState!
                                            .validate() &&
                                        TodoCubit.get(context)
                                                .categoryselected !=
                                            null) {
                                      TodoCubit.get(context).addTask(Taskdata(
                                        title: TodoCubit.get(context)
                                            .titleController
                                            .text,
                                        description: TodoCubit.get(context)
                                            .descriptionController
                                            .text,
                                        date: TodoCubit.get(context).date!,
                                        time: TodoCubit.get(context).time,
                                        category: TodoCubit.get(context)
                                            .categoryselected!,
                                        color: TodoCubit.get(context)
                                            .selectedcolor,
                                      ));
                                    } else if (TodoCubit.get(context)
                                            .categoryselected ==
                                        null) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text(
                                              "Please select a category"),
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
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Add Task'),
                                ),
                              ],
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
          body: BlocBuilder<TodoCubit, TodoStates>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Todolist(
                          title: tasks[index].title,
                          description: tasks[index].title,
                          date: tasks[index].date,
                          time: tasks[index].time,
                          color: tasks[index].color,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}

*/
