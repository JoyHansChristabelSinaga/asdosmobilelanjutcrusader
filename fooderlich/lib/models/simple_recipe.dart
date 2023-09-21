class SimpleRecipe {
  String? id;
  String? dishImage;
  String? title;
  String? duration;
  String? source;
  List<String>? information;

  SimpleRecipe(
    this.id,
    this.dishImage,
    this.title,
    this.duration,
    this.source,
    this.information,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['id'] = id;
    map['dishImage'] = dishImage;
    map['title'] = title;
    map['duration'] = duration;
    map['source'] = source;
    map['information'] = information.toString();

    return map;
  }

  SimpleRecipe.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    dishImage = map['dishImage'];
    title = map['title'];
    duration = map['duration'];
    source = map['source'];
    information = map['information']?.split(','); // string diubah menjadi list
  }

  SimpleRecipe.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    dishImage = json['dishImage'];
    title = json['title'];
    duration = json['duration'];
    source = json['source'];
    information = json['information'].cast<String>();
  }
}
