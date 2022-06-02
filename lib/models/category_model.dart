class CategoryModel {
  String? name;
  String? id;
  String? picture;

  CategoryModel({
    required this.name,
    this.id,
    required this.picture,
  });
  CategoryModel.fromJson(Map<String, dynamic> json) {
    picture = json['picture'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'picture': picture,
      'id': id,
      'name': name,
    };
  }
}
