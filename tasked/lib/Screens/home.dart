import 'package:flutter/material.dart';
import 'package:tasked/Utils/storageManager.dart';
import 'package:tasked/Utils/todoModel.dart';
import '../Utils/Colors.dart' as colors;
import 'dart:html' as html;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeController createState() => _HomeController();
}

class _HomeController extends State<Home> {
  @override
  Widget build(BuildContext context) => _HomeView(this);
  //ACTUAL CODE
  Size _size;

  TextEditingController _todoController;
  List<Todo> _todos = [];

  String key = "${DateTime.now().toString()}/user";

  void loadCache() {

    // Map<String, dynamic> tempMap = Map();
    //
    // if(html.window.localStorage.containsKey(key)) {
    //   print(html.window.localStorage[key].toString());
    //   tempMap = json.decode(html.window.localStorage[key].toString());
    //
    //   if(tempMap.containsKey("todos")) {
    //     setState(() {
    //       _todos = tempMap["todos"];
    //     });
    //   }
    // }

    StorageManager.readData(key).then((value) {
      if(value != null) {
        setState(() {
          //_todos = value;
          print("Loaded");
        });
      }
    });

    // html.window.localStorage['key'] = key;
    // if(key != null && !html.window.localStorage['key'].contains(key)) {
    //   html.window.localStorage.putIfAbsent(key, () => key);
    //   json.decode(html.window.localStorage[key].toString());
    //
    // }

    // setState(() {
    //   _todos = StorageManager.readData(key) as List<String>;
    //   print("Loaded");
    // });
  }

  void setTodo(String str) {
    if(str != null && str.isNotEmpty) {
      setState(() {
        //_todos.add(str);
        Todo(
          title: str,
          completed: false,
        );
        _todoController.clear();

        StorageManager.saveData(key, _todos);

        // Map<String, dynamic> tempMap = Map();
        // tempMap.putIfAbsent(key, () => {});
        // if(!html.window.localStorage.containsKey(key)) {
        //   html.window.localStorage.putIfAbsent(key, () => "");
        // } else {
        //   tempMap[key] = json.decode(html.window.localStorage[key]);
        // }
        // tempMap[key].update("todos", (value) => _todos, ifAbsent: () => _todos);
        // html.window.localStorage.update(key, (value) => json.encode(tempMap[key]));

      });
    }
  }

  void deleteTodo(int i) {
    setState(() {
      _todos.removeAt(i);
    });
  }

  @override
  void initState() {
    _todoController = TextEditingController();
    super.initState();
    // if(html.document.cookie.indexOf('mycookie')==-1) {
    //   html.document.cookie = 'mycookie=1';
    // } else {
    //   html.window.alert('you refereshed');
    //   loadCache();
    // }
    loadCache();
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
                              child: _todoItem(i),
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

  Widget _todoItem(int i) {
    return Card(
      color: colors.bg,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colors.darkGrey, width: 2.0),
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "state._todos[i]",
                style: TextStyle(
                  color: colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            InkWell(
              radius: 0.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipOval(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(Icons.done, size: 20.0, color: colors.green,),
                  ),
                ),
              ),
              onTap: () {
                state.deleteTodo(i);
              },
            ),
          ],
        ),
      ),
    );
  }
}