class Movie {
  String id;
  int rank;
  String title;
  String image;
  String weekend;
  String gross;
  int weeks;

  Movie(this.id, this.rank, this.title, this.image, this.weekend, this.gross, this.weeks);

  Movie.fromJson(Map json)
    : id = json['id'],
      rank = int.parse(json['rank']),
      title = json['title'],
      image = json['image'],
      weekend = json['weekend'],
      gross = json['gross'],
      weeks = int.parse(json['weeks']);
}