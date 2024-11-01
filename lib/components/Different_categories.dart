import 'package:joub_jum/models/category_model.dart';

Map<String, dynamic> createCatBox(String name, String image, String address, String placeId) {
  return {
    'name': name,
    'picture': image,
    'location': address,
    'placeId': placeId
  };
}
List<Map<String, dynamic>> Res = [
  createCatBox('trid', 'assets/images/trid.png', 'South Korea, Seoul, Gangnam District, Seolleung-ro 162-gil, 16 2층', 'ChIJh_Hy_YOlfDURPBVzNYFT0qk'),
  createCatBox('Mosu', 'assets/images/mosu.png', '4 Hoenamu-ro 41-gil, Yongsan District, Seoul, South Korea', 'ChIJJeNdcbOjfDURCzyDecCVK7o'),
  createCatBox('Vie Tolado Pasta', 'assets/images/Vie tolado pasta.png', '7-2 Wonhyo-ro 83-gil, Seoul, South Korea', 'ChIJTVaRADuZfDURPYS8SCb08AA'),
  createCatBox('CHOI Dot', 'assets/images/CHOI dot.png', 'South Korea, Seoul, Gangnam District, Dosan-daero, 457 앙스돔빌딩 3층', 'ChIJYz_NPnqkfDURqEJ3EeoGY5Y'),
];

List<CategoryModel> Restaurants = CategoryModel.createCategories(Res);


// Cafe section (working correctly)
List<Map<String, dynamic>> Cafe = [
  createCatBox('STOR-Y', 'assets/images/stor-y.png', 'B19&20, Street, Phnom Penh 12200', 'ChIJ12ASHnVRCTERkhoxMiFXUx4'),
  createCatBox('Tube coffee', 'assets/images/Tube.png', 'Str. Russian Federation, HWC6+C98, Phnom Penh 12301', 'ChIJdcbo5WtRCTERI2v9x1bf1L4'),
  createCatBox('KOI Thé', 'assets/images/KOI.png', 'Sangkat Tonle Bassac, Khan Chamkarmon 158 Preah Norodom Blvd', 'ChIJhe8jSC9RCTERo2en8666ZHI'),
  createCatBox('Noir Coffee', 'assets/images/Noir.png', 'St.108 Corner St.67 Phnom Penh', 'ChIJ5U1oW8FRCTERU88clXXmymc'),
];

List<CategoryModel> Cafes = CategoryModel.createCategories(Cafe);
