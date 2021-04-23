import 'package:flutter/material.dart';
import 'package:sad_lib/DialogClass.dart';
import 'package:tasked/Utils/TodoItem.dart';
import '../Utils/Colors.dart' as colors;
import 'dart:html';

class Home extends StatefulWidget {
  @override
  _HomeController createState() => _HomeController();
}

class _HomeController extends State<Home> {
  @override
  Widget build(BuildContext context) => _HomeView(this);
  //ACTUAL CODE
  Size _size;
  bool _isCompleted;
  DialogClass _dialog;

  List<String> _todos = [];
  TextEditingController _todoController;

  void setTodo(String str) {
    if(str != null && str.isNotEmpty) {
      setState(() {
        _todos.add(str);
        _todoController.clear();
      });
    }
  }

  void completeTodo(int i) {
    setState(() {
      _isCompleted = !_isCompleted;
    });
    _dialog.assureDialog(context, message: "Are you sure you want to mark '${_todos[i].toString()}' as done?", dismissible: false, positive: "Yes",).then((flag) {
      if(flag) {
        setState(() {
          _todos.removeAt(i);
        });
      } else {
        Navigator.of(context).pop(false);
      }
    });
  }

  void deleteTodo(int i) {
    _dialog.assureDialog(context, message: "Are you sure you want to delete '${_todos[i].toString()}'?", dismissible: false, positive: "Yes", negative: "No").then((flag) {
      if(flag) {
        setState(() {
          _todos.removeAt(i);
        });
      } else {
        Navigator.of(context).pop(false);
      }
    });
  }

  @override
  void initState() {
    _todoController = TextEditingController();
    _isCompleted = false;
    _dialog = DialogClass(background: colors.bg, buttonColor: colors.primary, buttonTextColor: colors.white, textColor: colors.white);
    super.initState();
    if(window.document.cookie.indexOf('mycookie') == -1) {
      window.document.cookie = 'mycookie=1';
    } else {
      window.alert("Please note: Todos do not save when page is reloaded.");
    }
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }
}

class _HomeView extends StatelessWidget {
    final _HomeController state;
  _HomeView(this.state) : super();

@override
  Widget build(BuildContext context) {
    state._size = MediaQuery.of(context).size;
    return Material(
      color: colors.darkGrey,
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 50.0),
                child: Text(
                  "Tasked",
                  style: TextStyle(
                    color: colors.primary,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0
                  ),
                ),
              ),
            ),
            Container(
              width: state._size.width > 1200 ? state._size.width / 2 : state._size.width > 900 ? state._size.width / 1.5 : state._size.width / 1.3,
              height: state._size.height / 1.5,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
              decoration: BoxDecoration(
                color: colors.bg.withOpacity(0.50),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: colors.lightGrey.withOpacity(0.20), width: 2.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: state._todoController,
                    autocorrect: true,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.words,
                    scrollPhysics: BouncingScrollPhysics(),
                    textAlignVertical: TextAlignVertical.center,
                    toolbarOptions: ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
                    keyboardType: TextInputType.multiline,
                    maxLength: null,
                    maxLines: null,
                    minLines: null,
                    style: TextStyle(
                      color: colors.lightGrey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    cursorColor: colors.lightGrey,
                    decoration: InputDecoration(
                        filled: false,
                        hintText: "New Todo",
                        hintStyle: TextStyle(
                          color: colors.lightGrey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                        counterText: "",
                        suffix: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: colors.primary,
                          ),
                          onPressed: () {
                            state.setTodo(state._todoController.text);
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(
                              color: colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: colors.primary.withOpacity(0.70))),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: colors.lightGrey)),
                        contentPadding: EdgeInsets.all(10.0)
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          for(int i = 0; i < state._todos.length; i++)
                            TweenAnimationBuilder(
                              tween: Tween<double>(begin: 300, end: 0),
                              duration: Duration(milliseconds: (250)),
                              builder: (context, value, child) {
                                return Padding(
                                  padding: EdgeInsets.only(left: value),
                                  child: child,
                                );
                              },
                              child: TodoItem(
                                todos: state._todos,
                                isCompleted: state._isCompleted,
                                i: i,
                                completeTodo: state.completeTodo,
                                deleteTodo: state.deleteTodo,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "v1.0",
                  style: TextStyle(
                    color: colors.lightGrey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  
}