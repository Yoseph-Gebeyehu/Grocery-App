import 'package:flutter/material.dart';
import 'package:grocery/data/Models/category_model.dart';
import 'package:grocery/domain/Constants/Images/category_images.dart';

import '../../domain/Constants/names/category_fruit_names.dart';

class Category extends StatelessWidget {
  static const category = 'category';
  List<CategoryModel> categories = List.generate(
    CategoryImages.images.length,
    (index) => CategoryModel(
      image: CategoryImages.images[index],
      name: CategoryFruitNames.fruitName[index],
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: deviceSize.height * 0.08,
        backgroundColor: const Color(0xFFFFFFFF),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: deviceSize.width * 0.05,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            childAspectRatio: 6 / 5,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
              left: deviceSize.width * 0.05,
              right: deviceSize.width * 0.05,
              top: deviceSize.height * 0.03,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFFBFBFB),
                border: Border.all(
                  color: index == 0
                      ? const Color(0xFFFF2E6C)
                      : const Color(0x00000000),
                  width: 1.0,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x42000000),
                    offset: Offset(9, 0),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: deviceSize.height * 0.01),
                  Image.asset(
                    categories[index].image,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: deviceSize.height * 0.009),
                  Text(
                    categories[index].name,
                    style: const TextStyle(
                      color: Color(0xFFE67F1E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          itemCount: categories.length,
        ),
      ),
    );
  }
}