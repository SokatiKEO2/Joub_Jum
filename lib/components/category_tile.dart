import 'package:flutter/material.dart';
import 'package:joub_jum/models/category_model.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  final CategoryModel category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 185,
        decoration: BoxDecoration(
          color: const Color(0xffc8c8c8).withOpacity(0.2),
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
                child: Image.network(
                  category.picture,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width / 3,
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
                    category.name,
                    style: const TextStyle(
                      fontFamily: 'Raritas',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.location,
                    style: const TextStyle(
                      fontFamily: 'Raritas',
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
  }
}