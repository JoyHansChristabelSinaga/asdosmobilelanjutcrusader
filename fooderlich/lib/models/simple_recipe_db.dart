class SimpleRecipeDb {
  String? id;
  String? dishImage;
  String? title;
  String? duration;
  String? source;
  List<String>? information;

  SimpleRecipeDb({
    required this.id,
    required this.dishImage,
    required this.title,
    required this.duration,
    required this.source,
    required this.information,
  });

  // factory SimpleRecipe.fromJson(Map<String, dynamic> json) {
  //   return SimpleRecipe(
  //     id: json['id'] as String,
  //     dishImage: json['dishImage'] as String,
  //     title: json['title'] as String,
  //     duration: json['duration'] as String,
  //     source: json['source'] as String,
  //     information: json['information'].cast<String>() as List<String>,
  //   );
  // }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
      map['dishImage'] = dishImage;
      map['title'] = title;
      map['duration'] = duration;
      map['source'] = source;
      map['information'] = information;
    }
    return map;
  }

  SimpleRecipeDb.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    dishImage = map['dishImage'];
    title = map['title'];
    duration = map['duration'];
    source = map['source'];
    information = map['information'];
  }
}
