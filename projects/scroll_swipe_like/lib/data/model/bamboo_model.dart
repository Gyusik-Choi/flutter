class BambooModel {
  int id = 0;
  String title = '';
  String body = '';
  bool selected = false;

  BambooModel(this.id, this.title, this.body);

  BambooModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      body = json['body'],
      selected = false;
}