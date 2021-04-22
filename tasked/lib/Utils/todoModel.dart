class Todo {
  String title;
  bool completed;

  Todo({this.title, this.completed});

  Todo.fromMap(Map data) {
    this.title = data['title'];
    this.completed = data["completed"];
  }

  Map toMap() {
    return {
      'title' : this.title,
      'completed' : this.completed,
    };
  }
}