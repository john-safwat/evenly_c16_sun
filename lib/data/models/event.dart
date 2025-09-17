import 'package:evently_c16_sun/data/models/category.dart';

class Event {
  String? id;
  String? title;
  String? description;
  int? date;
  int? time;
  Category? category;

  Event({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
    this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "time": time,
      "category": category?.id,
    };
  }

  Event.fromFirestore(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    date = json["date"];
    time = json["time"];
    category = Category.categories.firstWhere((e) => e.id == json["category"]);
  }
}
