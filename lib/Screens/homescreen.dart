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