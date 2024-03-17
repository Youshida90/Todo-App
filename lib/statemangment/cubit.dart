import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/Screens/archivedscreen.dart';
import 'package:todo_app/Screens/donescreen.dart';
import 'package:todo_app/Screens/newtaskscreen.dart';
import 'package:todo_app/category/category.dart';
import 'package:todo_app/modules/todomodel.dart';
import 'package:todo_app/statemangment/todostates.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(TodoInitialState());
  static TodoCubit get(context) => BlocProvider.of(context);
  //---------------------------------HomeScreenStates------------------------------
  //? The Navbar Logic
  int currentIndex = 0;

  List<String> pagestitles = [
    'Home Screen',
    'Done Screen',
    'Archive Screen',
  ];

  List<Widget> pages = [
    const NewTaskScreen(),
    const DoneScreen(),
    const ArchivedScreen(),
  ];

  String getTitle() {
    if (currentIndex == 0) {
      return 'Tasks';
    } else if (currentIndex == 1) {
      return 'finished tasks';
    } else {
      return 'Archive Screen';
    }
  }

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(TodoChangeBottomNavState());
  }

  Widget getCurrentPage() {
    return pages[currentIndex];
  }

  //---------------------------------NewTaskStates---------------------------------

  //? The Controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
//-----------------------------------------------------------------------------------
  //@ The Reset Controller Logic
  void resetcancelController() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    categoryselected = null;
    selectedcolor = 0xFFFF0000;
    emit(TodoCancelResetControllerState());
  }

  void resetAddController() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    categoryselected = null;
    selectedcolor = 0xFFFF0000;
    emit(TodoAddResetControllerState());
  }

//-----------------------------------------------------------------------------------
  //! Add New Task Logic
  List<TodoModel> addall = [];
  List<int> key = [];
  getBox() async {
    var box = await Hive.openBox("TodoBox");
    key = [];
    key = box.keys.cast<int>().toList();
    addall = [];
    for (var keys in key) {
      addall.add(box.get(keys)!);
    }
    box.close();
    emit(GetBoxState());
  }

  void addTodoTask(TodoModel model) async {
    await Hive.openBox("TodoBox").then((value) => value.add(model)).then(
          (value) => getBox(),
        );
    emit(AddTodoTaskState());
  }

//-----------------------------------------------------------------------------------
//# The Date and Time Logic
  DateTime? date;
  DateTime? time;
  bool iosStyle = true;
  onTimeChanged(DateTime newTime) {
    time = newTime;
    emit(PickedTimeState());
  }
//-------------------------------------------------------------------------------------

//$ The Color Logic
  int selectedcolor = 0xFFFF0000;
  List<int> colors = [
    0xFFFF0000,
    0xFF008000,
    0xFF800080,
    0xFF0000FF,
    0xFFFFFF00,
    0xFFFFC0CB,
  ];
  void changeColor(int colors) {
    selectedcolor = colors;
    emit(TodoChangeColorState());
  }

  void selectColor(int colors) {
    selectedcolor = colors;
    emit(TodoSelectColorState());
  }

//-------------------------------------------------------------------------------------
  //% The Category Logic
  Category1? categoryselected;

  void selectCategory(Category1? category) {
    categoryselected = category;
    emit(TodoSelectCategoryState());
  }

//-------------------------------------------------------------------------------------
  //* Update the Task Logic
  updateTodo(TodoModel todomodel) async {
    await Hive.openBox("TodoBox").then((value) {
      final Map todoMap = value.toMap();
      dynamic desiredkey;
      todoMap.forEach((key, value) {
        if (value.title == todomodel.title) {
          desiredkey = key;
        } 
      });
      return value.put(desiredkey, todomodel);
    }).then((value) => getBox());
  }
  deleteTodo(TodoModel todoModel) async {
    await Hive.openBox("TodoBox").then((value) {
      final Map todoMap = value.toMap();
      dynamic desiredKey;
      todoMap.forEach((key, value) {
        if (value.title == todoModel.title) {
          desiredKey = key;
        }
      });
      return value.delete(desiredKey);
    }).then(
      (value) => getBox(),
    );
  }
}
