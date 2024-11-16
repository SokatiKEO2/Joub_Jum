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
  createCatBox('trid', 'https://axwwgrkdco.cloudimg.io/v7/__gmpics3__/86b6a364fcab4bdbb4d664a003b67eb9.jpeg', 'South Korea, Seoul, Gangnam District, Seolleung-ro 162-gil, 16 2층', 'ChIJh_Hy_YOlfDURPBVzNYFT0qk'),
  createCatBox('Mosu', 'https://seoulshopper.com/cdn/shop/articles/mosu-seoul-michelin-3star-korean-restaurant-itaewon_12.jpg?v=1693210612', '4 Hoenamu-ro 41-gil, Yongsan District, Seoul, South Korea', 'ChIJJeNdcbOjfDURCzyDecCVK7o'),
  createCatBox('Vie Tolado Pasta', 'https://media.triple.guide/triple-cms/c_limit,f_auto,h_1024,w_1024/dcae9993-6135-4dd9-bf38-24bea55e9129.jpeg', '7-2 Wonhyo-ro 83-gil, Seoul, South Korea', 'ChIJTVaRADuZfDURPYS8SCb08AA'),
  createCatBox('CHOI Dot', 'https://www.theworlds50best.com/discovery/filestore/jpg/Jungsik-Seoul-Korea-03.jpg', 'South Korea, Seoul, Gangnam District, Dosan-daero, 457 앙스돔빌딩 3층', 'ChIJYz_NPnqkfDURqEJ3EeoGY5Y'),
  createCatBox('Sombok', 'https://sombok.asia/wp-content/uploads/2021/04/booths-sombok-restaurant-phnom-penh.webp', 'No. 1, Street 154, Preah Sisowath Quay Phnom Penh, 12200', 'ChIJ05LCRgxRCTER-PYadT4eKCA'),
  createCatBox('Malis', 'https://malis.thalias.com.kh/wp-content/uploads/2024/07/DSC_7438-scaled.jpg', 'No. 136, Norodom Blvd, Phnom Penh', 'ChIJJaAn2y9RCTERzQk2y8vSnbo'),
  createCatBox('SaKaNa Lab', 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/10/f6/42/ca/facade.jpg?w=1200&h=-1&s=1', 'Phnom Penh, #039, St.51, Boeng Keng Kang 1 12302', 'ChIJX9dwBzBRCTERMeWbW2ECl00'),
  createCatBox('TOPAZ', 'https://www.theyumlist.net/wp-content/uploads/2016/09/Topaz-Restaurant.jpg', 'House, number 162 Norodom Blvd, Phnom Penh 12302', 'ChIJaZnwYyhRCTER2EGNULFPu0U'),
];

List<CategoryModel> Restaurants = CategoryModel.createCategories(Res);


// Cafe section (working correctly)
List<Map<String, dynamic>> Cafe = [
  createCatBox('STOR-Y', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuBNeiuXm5WFKVzoPnAs30dqSD3Tq9Gw8YPQ&s', 'B19&20, Street, Phnom Penh 12200', 'ChIJ12ASHnVRCTERkhoxMiFXUx4'),
  createCatBox('Tube coffee', 'https://images.deliveryhero.io/image/menu-import-gateway-prd/regions/AS/chains/MONAKOM_KH_ProdChain/1f8e3557437460eb683f17ebd91065d0.jpg?width=%s', 'Str. Russian Federation, HWC6+C98, Phnom Penh 12301', 'ChIJdcbo5WtRCTERI2v9x1bf1L4'),
  createCatBox('KOI Thé', 'https://onecard.com.my/Files/FoodReview/LG329_chhni33f.jpg', 'Sangkat Tonle Bassac, Khan Chamkarmon 158 Preah Norodom Blvd', 'ChIJhe8jSC9RCTERo2en8666ZHI'),
  createCatBox('Noir Coffee', 'https://images.deliveryhero.io/image/fd-kh/Products/45969.jpg?width=%s', 'St.108 Corner St.67 Phnom Penh', 'ChIJ5U1oW8FRCTERU88clXXmymc'),
  createCatBox('H2O COFFEE', 'https://lh3.googleusercontent.com/p/AF1QipO5J_g6at60zGRVe1BIqBRjT1TlrlR2k8xE0Ci1=s1360-w1360-h1020', 'Dekcho Damdin St. (154), Phnom Penh', 'ChIJYTPcu7JRCTERDrzWJukzJZw'),
  createCatBox('Lagràce Cafe', 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/f1/ce/56/caption.jpg?w=1100&h=-1&s=1', 'MEKONG ARTS 33, Street 178, 12206 Preah Ang Makhak Vann, Phnom Penh', 'ChIJqzvObfBRCTER4_mmPLptFeU'),
  createCatBox('Enso Cafe', 'https://lh3.googleusercontent.com/p/AF1QipMzx3baLWp31l-mRYlPgdKxTdmimws5IMxdrobH=s1360-w1360-h1020', '50B Oknha Chhun St. (240), Phnom Penh 12207', 'ChIJn5sZTTdRCTER7Tka0eVrtRU'),
  createCatBox('selapak coffee', 'https://stat.ameba.jp/user_images/20240516/17/mocosweetrip/e5/41/j/o1080081015439508374.jpg', 'Toul Tom Poung 1, Number 192 St 155, Phnom Penh', 'ChIJ40dk0VhRCTERZNV8muPLLHo'),
];

List<CategoryModel> Cafes = CategoryModel.createCategories(Cafe);

List<Map<String, dynamic>> Pubs = [
  createCatBox('Hemisphere Sky', 'https://media-cdn.tripadvisor.com/media/photo-s/25/15/c3/b3/hemisphere-rooftop.jpg', '47 Corner ST 01 and ST 94 Village 9, Phnom Penh', 'ChIJsw1FNd9RCTERehFDVH0opkw'),
  createCatBox('HighGround Sky', 'https://www.highgroundskybar.com/wp-content/uploads/2021/04/DSC03937-scaled.jpg', 'Amass Tower, Street. 63, Phnom Penh', 'ChIJx5jLQDJRCTEROYlgdQsbe1k'),
  createCatBox('LéMoon Rooftop', 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/10/e7/11/1e/sunset-on-the-rooftop.jpg?w=1200&h=-1&s=1', '154 Dekcho Damdin St. (154), Phnom Penh', 'ChIJV1LmH0lRCTERmUPBMu1WFyQ'),
  createCatBox('Sora Skybar', 'https://images.rosewoodhotels.com/is/image/rwhg/rwppn-sora-indoor-1:WIDE-LARGE-16-9', 'Vattanac Capital Mall, ផ្លូវឡើងជំហៀង, 66 Level 37, Phnom Penh', 'ChIJzadboUNRCTERDhj1kx5tY2Q'),
  createCatBox('Ambience', 'https://lh3.googleusercontent.com/p/AF1QipPVwziHaKjSX7ZQrW_HqkiwfKarFCb2VIzXrFCB=s1360-w1360-h1020', 'Street 308 Bassac Lane, Phnom Penh 12301, Cambodia', 'ChIJT17FJIlRCTERKJ2gjPwJf6A'),
  createCatBox('AURA', 'https://lh3.googleusercontent.com/p/AF1QipOAqA2cz0pLxlfxROW16Xa3PS7p8ZdIp3eMAj7Q=s1360-w1360-h1020', '11B street 29, & Street 308, Phnom Penh 12301, Cambodia', 'ChIJOTvBzi9RCTERCjNclIeDq-A'),
  createCatBox('Back Street', 'https://lh3.googleusercontent.com/p/AF1QipM75ys8_zpLDkcxu2eNNjGo2r5kam3M96EbY8TL=s1360-w1360-h1020', '14b Street 308, Phnom Penh, Cambodia', 'ChIJB-N2jIhRCTERQsSqqG6i0eE'),
  createCatBox('Hub', 'https://lh3.googleusercontent.com/p/AF1QipP26nNrPGO2bMsJrV3ZLskRzLCzypeXTW5Ccj66=s1360-w1360-h1020', '20 Street 21, Phnom Penh, Cambodia', 'ChIJ3VnQszZRCTER3Wc7W4e2DCw'),
];

List<CategoryModel> Bars_Pubs = CategoryModel.createCategories(Pubs);