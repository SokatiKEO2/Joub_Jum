import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joub_jum/models/category_model_cafes.dart';
import 'package:joub_jum/models/category_model_restaurants.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {

  List<CategoryModelRes> categoriesRes = [];
  List<CategoryModelCafe> categoriesCafe = [];

  void _getCategoriesRes() {
    categoriesRes = CategoryModelRes.getCategories();
  }

  void _getCategoriesCafe() {
    categoriesCafe = CategoryModelCafe.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    _getCategoriesRes();
    _getCategoriesCafe();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            buildResHeading(),
            const SizedBox(height: 15),
            buildResCategories(),
            const SizedBox(height: 40),
            buildCafeHeading(),
            const SizedBox(height: 15),
            buildCafeCategories(),
          ],
        ),
      ),
    );
  }

  Container buildCafeCategories() {
    return Container(
            height: 250,
            child: ListView.separated(
              itemCount: categoriesCafe.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              separatorBuilder: (context, index) => const SizedBox(width: 18),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Call a function or perform some action on tap
                  },
                  child: Container(
                    width: 185,
                    decoration: BoxDecoration(
                      color: categoriesCafe[index].boxColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 170,
                          height: 120,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SvgPicture.asset(
                              categoriesCafe[index].cafePicture,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                categoriesCafe[index].cafeName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                categoriesCafe[index].cafeLocation,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  Padding buildCafeHeading() {
    return const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              'Cafe',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
  }

  Container buildResCategories() {
    return Container(
            height: 250,
            child: ListView.separated(
              itemCount: categoriesRes.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              separatorBuilder: (context, index) => const SizedBox(width: 18),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Call a function or perform some action on tap
                  },
                  child: Container(
                    width: 185,
                    decoration: BoxDecoration(
                      color: categoriesRes[index].boxColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 170,
                          height: 120,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SvgPicture.asset(
                              categoriesRes[index].resPicture,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                categoriesRes[index].resName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                categoriesRes[index].resLocation,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  Padding buildResHeading() {
    return const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              'Restaurants',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        'Recommendations',
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFFcaffbf),
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          // Handle back button or drawer opening
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xB0FFC6FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/3bars_icon.svg',
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
