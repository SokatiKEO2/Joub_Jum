import 'package:joub_jum/models/category_model.dart';
import 'dart:ui';

List<Map<String, dynamic>> Cafe = [
  {
    'name': 'STOR-Y',
    'picture': 'assets/images/stor-y.png',
    'location': 'B19&20, Street, Phnom Penh 12200',
    'boxColor': Color(0xffc8c8c8)
  },
  {
    'name': 'Tube coffee',
    'picture': 'assets/images/Tube.png',
    'location': 'HWC6+C98, Str. Russian Federation, 12301',
    'boxColor': Color(0xffc8c8c8)
  },
  {
    'name': 'KOI Thé',
    'picture': 'assets/images/KOI.png',
    'location': 'Sangkat Tonle Bassac, Khan Chamkarmon 158 Preah Norodom Blvd',
    'boxColor': Color(0xffc8c8c8)
  },
  {
    'name': 'Noir Coffee',
    'picture': 'assets/images/Noir.png',
    'location': 'St.108 Corner St.67 Phnom Penh, 12202',
    'boxColor': Color(0xffc8c8c8)
  },
];

List<CategoryModel> Cafes = CategoryModel.createCategories(Cafe);


List<Map<String, dynamic>> Res = [
  {
    'name': 'trid',
    'picture': 'assets/images/trid.png',
    'location': 'South Korea, Seoul, Gangnam District, Seolleung-ro 162-gil, 16 2층',
    'boxColor': Color(0xffc8c8c8)
  },
  {
    'name': 'Mosu',
    'picture': 'assets/images/mosu.png',
    'location': '4 Hoenamu-ro 41-gil, Yongsan District, Seoul, South Korea',
    'boxColor': Color(0xffc8c8c8)
  },
  {
    'name': 'Vie Tolado Pasta',
    'picture': 'assets/images/Vie tolado pasta.png',
    'location': '7-2 Wonhyo-ro 83-gil, Seoul, South Korea',
    'boxColor': Color(0xffc8c8c8)
  },
  {
    'name': 'CHOI Dot',
    'picture': 'assets/images/CHOI dot.png',
    'location': 'South Korea, Seoul, Gangnam District, Dosan-daero, 457 앙스돔빌딩 3층',
    'boxColor': Color(0xffc8c8c8)
  },
];

List<CategoryModel> Restaurants = CategoryModel.createCategories(Res);
