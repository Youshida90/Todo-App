abstract class TodoStates {}

class TodoInitialState extends TodoStates {}

//---------------------------------HomeScreenStates------------------------------
//? The Navbar Logic
class TodoChangeBottomNavState extends TodoStates {}

//---------------------------------NewTaskStates---------------------------------
//? The Add New Task State
class AddTodoTaskState extends TodoStates {}

//! The Pick Time State
class PickedTimeState extends TodoStates {}

//@ The Change Color State
class TodoChangeColorState extends TodoStates {}

//# The Select Color State
class TodoSelectColorState extends TodoStates {}

//$ The Cancel Rest State
class TodoCancelResetControllerState extends TodoStates {}

//& The Add Reset State
class TodoAddResetControllerState extends TodoStates {}

//* The Select Category State
class TodoSelectCategoryState extends TodoStates {}

//? The Save Task State
class GetBoxState extends TodoStates {}
