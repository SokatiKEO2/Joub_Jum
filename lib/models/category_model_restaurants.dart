import 'dart:ui';

class CategoryModelRes {
  String resName;
  String resPicture;
  String resLocation;
  Color boxColor;

  CategoryModelRes({
    required this.resName,
    required this.resPicture,
    required this.resLocation,
    required this.boxColor,
  });

  static List<CategoryModelRes> getCategories() {
    List<CategoryModelRes> categories = [];

    categories.add(CategoryModelRes(
        resName: 'trid',
        resPicture: 'assets/icons/trid.svg',
        resLocation: 'South Korea, Seoul, Gangnam District, Seolleung-ro 162-gil, 16 2층',
        boxColor: Color(0xffc8c8c8)
      )
    );

    categories.add(CategoryModelRes(
        resName: 'Mosu',
        resPicture: 'assets/icons/Mosu.svg',
        resLocation: '4 Hoenamu-ro 41-gil, Yongsan District, Seoul, South Korea',
        boxColor: Color(0xffc8c8c8)
    )
    );

    categories.add(CategoryModelRes(
        resName: 'Via Toledo Pasta',
        resPicture: 'assets/icons/Vie Tolado Pasta.svg',
        resLocation: '7-2 Wonhyo-ro 83-gil, Seoul, South Korea',
        boxColor: Color(0xffc8c8c8)
    )
    );

    categories.add(CategoryModelRes(
        resName: 'CHOI Dot',
        resPicture: 'assets/icons/ChoiDot.svg',
        resLocation: 'South Korea, Seoul, Gangnam District, Dosan-daero, 457 앙스돔빌딩 3층',
        boxColor: Color(0xffc8c8c8)
    )
    );

    return categories;
  }
}