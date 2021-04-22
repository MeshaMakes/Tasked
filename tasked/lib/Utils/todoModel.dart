class Todo {
  String title;
  bool completed;

  Todo({this.title, this.completed,});

  Todo.fromMap(Map<String, dynamic> data) {
    this.title = data['title'];
    this.completed = data['completed'];
  }

}