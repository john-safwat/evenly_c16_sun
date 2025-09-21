class Event {
  String? id;
  String? title;
  String? description;
  int? date;
  int? time;

  int? categoryId;

  Event({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
    this.categoryId,
  });

  Map<String, dynamic> toFirebase() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "time": time,
      "categoryId": categoryId,
    };
  }

  Event.fromFirebase(Map<String, dynamic> data) {
    id = data["id"];
    title = data["title"];
    description = data["description"];
    date = data["date"];
    time = data["time"];
    categoryId = data["categoryId"];
  }
}
