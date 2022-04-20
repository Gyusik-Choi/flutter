class Todo {
  int? id;
  String? description;
  bool isDone = false;

  Todo({this.id, this.description, this.isDone = false});

  // https://docs.flutter.dev/development/data-and-backend/json
  // db에서 가져온 값을 Todo 객체로 변환
  Todo.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      description = json['description'],
      isDone = json['isDone'] == 0 ? false : true;

  // https://power-of-optimism.tistory.com/85
  // db에 넣기 위해 Map 객체로 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'is_done': isDone == false ? 0 : 1
    };
  }
}