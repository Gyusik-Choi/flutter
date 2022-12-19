class Todo {
  int? id;
  String description;
  bool isDone;

  Todo({this.id, required this.description, this.isDone = false});

  Todo.fromMap(Map<String, dynamic> itemFromDB)
    : id = itemFromDB['id'],
      description = itemFromDB['description'],
      isDone = itemFromDB['is_done'] == 0 ? false : true;
      // isDone = itemFromDB['is_done'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'is_done': isDone == false ? 0 : 1
    };
  }
}