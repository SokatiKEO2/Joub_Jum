import 'dart:ui';

class CategoryModelCafe {
  String cafeName;
  String cafePicture;
  String cafeLocation;
  Color boxColor;

  CategoryModelCafe({
    required this.cafeName,
    required this.cafePicture,
    required this.cafeLocation,
    required this.boxColor,
  });

  static List<CategoryModelCafe> getCategories() {
    List<CategoryModelCafe> categories = [];

    categories.add(CategoryModelCafe(
        cafeName: 'STOR-Y',
        cafePicture: 'assets/icons/STOR-Y.svg',
        cafeLocation: 'B19&20, Street, Phnom Penh 12200',
        boxColor: Color(0xffc8c8c8)
    )
    );

    categories.add(CategoryModelCafe(
        cafeName: 'Tube coffee',
        cafePicture: 'assets/icons/Tube.svg',
        cafeLocation: 'HWC6+C98, Str. Russian Federation, 12301',
        boxColor: Color(0xffc8c8c8)
    )
    );

    categories.add(CategoryModelCafe(
        cafeName: 'KOI Thé',
        cafePicture: 'assets/icons/KOI.svg',
        cafeLocation: 'Sangkat Tonle Bassac , Khan Chamkarmon 158 Preah Norodom Blvd',
        boxColor: Color(0xffc8c8c8)
    )
    );

    categories.add(CategoryModelCafe(
        cafeName: 'Noir Coffee',
        cafePicture: 'assets/icons/Noir.svg',
        cafeLocation: 'St.108 Corner St.67 Phnom Penh, 12202',
        boxColor: Color(0xffc8c8c8)
    )
    );

    return categories;
  }
}