class Task {
  String? name;
  bool isDone;
  Task({this.name, required this.isDone});

  void getDone() {
    isDone = !isDone;
  }
}
