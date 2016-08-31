library models;

class Hunt {
  String name, url, author;
  
  int point;
  
  DateTime date;

  Hunt(this.name, this.url, {this.point: 0});

  Hunt.fromJson(Map data) {
    name    = data["name"];
    url = data["url"];
    point = data["point"];
  }
  
  Map toJson() => {"name": name, "url": url, "point": point};
  
}