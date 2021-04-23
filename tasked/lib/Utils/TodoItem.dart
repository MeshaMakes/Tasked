import 'package:flutter/material.dart';
import '../Utils/Colors.dart' as colors;

class TodoItem extends StatefulWidget {
  final List<String> todos;
  final bool isCompleted;
  final int i;

  final void Function(int i) completeTodo;
  final void Function(int i) deleteTodo;

  TodoItem({Key key, @required this.todos, @required this.isCompleted, @required this.i, @required this.completeTodo, @required this.deleteTodo}) : super(key: key);
  @override
  _TodoItemController createState() => _TodoItemController();
}

class _TodoItemController extends State<TodoItem> {
  @override
  Widget build(BuildContext context) => _TodoItemView(this);
}

class _TodoItemView extends StatelessWidget {
    final _TodoItemController state;
  _TodoItemView(this.state) : super();

@override
  Widget build(BuildContext context) {
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
                state.widget.todos[state.widget.i],
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
                state.widget.completeTodo(state.widget.i);
              },
            ),
            InkWell(
              radius: 0.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipOval(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(Icons.close, size: 20.0, color: colors.primary,),
                  ),
                ),
              ),
              onTap: () {
                state.widget.deleteTodo(state.widget.i);
              },
            ),
          ],
        ),
      ),
    );
  }
}