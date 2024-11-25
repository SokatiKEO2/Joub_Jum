import 'package:flutter/material.dart';
import 'package:joub_jum/components/different_categories.dart';
import 'package:joub_jum/components/category_tile.dart';
import 'package:joub_jum/consts.dart';
import 'package:joub_jum/models/fetch_place_data.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {

  void goToPlace(category) {
    var result = fetchPlace(category.placeId);
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeading('Restaurants'),
              const SizedBox(height: 15),
              _buildCategoryList(Restaurants),
              const SizedBox(height: 40),
              _buildSectionHeading('Cafes'),
              const SizedBox(height: 15),
              _buildCategoryList(Cafes),
              const SizedBox(height: 40),
              _buildSectionHeading('Bars & Pubs'),
              const SizedBox(height: 15),
              _buildCategoryList(Bars_Pubs),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Recommendations',
        style: TextStyle(fontSize: 25, fontFamily: mainFont),
      ),
      backgroundColor: appBarColor,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Padding _buildSectionHeading(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 30, fontFamily: mainFont),
      ),
    );
  }

  Widget _buildCategoryList(List categoryList) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        itemCount: categoryList.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        separatorBuilder: (context, index) => const SizedBox(width: 18),
        itemBuilder: (context, index) {
          return CategoryTile(
            category: categoryList[index],
            onTap: () {
              goToPlace(categoryList[index]);
            },
          );
        },
      ),
    );
  }
}
