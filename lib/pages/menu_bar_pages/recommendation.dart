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

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  //GET MODEL FROM DATABASE
  void _getCategories() {
    setState(() {
      categoriesRes = CategoryModelRes.getCategories();
      categoriesCafe = CategoryModelCafe.getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            buildHeading('Restaurants'),
            const SizedBox(height: 15),
            buildCategories(categoriesRes, 'res'),
            const SizedBox(height: 40),
            buildHeading('Cafe'),
            const SizedBox(height: 15),
            buildCategories(categoriesCafe, 'cafe'),

          ],
        ),
      ),
    );
  }

  Container buildCategories(dynamic categories, String type) {
    return Container(
      height: 250,
      child: ListView.separated(
        itemCount: categories.length,
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
                color: categories[index].boxColor.withOpacity(0.2),
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
                        type == 'res'
                            ? categories[index].resPicture
                            : categories[index].cafePicture,
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
                          type == 'res'
                              ? categories[index].resName
                              : categories[index].cafeName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          type == 'res'
                              ? categories[index].resLocation
                              : categories[index].cafeLocation,
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

  Padding buildHeading(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Text(
        title,
        style: const TextStyle(
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
    );
  }
}
