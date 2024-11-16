class CategoryModel {
  String name;
  String picture;
  String location;
  String placeId;

  CategoryModel({
    required this.name,
    required this.picture,
    required this.location,
    required this.placeId,
  });

  // Static method to generate category models from passed data
  static List<CategoryModel> createCategories(List<Map<String, dynamic>> categoryData) {
    List<CategoryModel> categories = [];

    for (var data in categoryData) {
      categories.add(CategoryModel(
        name: data['name'],
        picture: data['picture'],
        location: data['location'],
        placeId: data['placeId']
      ));
    }

    return categories;
  }
}
