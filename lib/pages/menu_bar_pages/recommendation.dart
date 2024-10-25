import 'package:flutter/material.dart';
import 'package:joub_jum/components/Different_categories.dart';
import 'package:joub_jum/components/category_tile.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
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
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color(0xFFcaffbf),
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
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
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
              // Define the action when this tile is tapped
            },
          );
        },
      ),
    );
  }
}
