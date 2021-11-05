class ApiModel {
  int id = 0;
  String title = '';
  String body = '';
  bool selected = false;

  ApiModel(this.id, this.title, this.body);

  ApiModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      body = json['body'],
      selected = false;
}