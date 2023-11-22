import 'package:flutter/material.dart';

import '../../data/Models/category_model.dart';
import '../../data/Models/home_model.dart';
import '../../domain/Constants/Images/category_images.dart';
import '../../domain/Constants/Images/home_images2.dart';
import '../../domain/Constants/names/category_fruit_names.dart';
import '../../domain/Constants/names/home_fruit_names.dart';

class CategoryPage extends StatefulWidget {
  static const category = 'category';

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  initState() {
    super.initState();
  }

  List<Category> categoryList = List.generate(
    CategoryImages.images.length,
    (index) => Category(
      image: CategoryImages.images[index],
      name: CategoryNames.fruitName[index],
    ),
  );

  List<Fruit> fruitList = List.generate(
    HomeImages2.images.length,
    (index) => Fruit(
      image: HomeImages2.images[index],
      name: HomeFruitNames.fruitNames[index],
      amout: index * 1.78,
      category: CategoryNames.fruitName[index],
    ),
  );
  List<Fruit> fruitTypeList() {
    return fruitList.where((fruit) => fruit.category == 'Fruits').toList();
  }

  List<Fruit> vegetableTypeList() {
    return fruitList.where((fruit) => fruit.category == 'Vegetable').toList();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: deviceSize.height * 0.08,
        backgroundColor: const Color(0xFFFFFFFF),
        centerTitle: true,
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: deviceSize.width * 0.05,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFFBFBFB),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: deviceSize.height * 0.01),
              SizedBox(height: deviceSize.height * 0.009),
              Text(
                categoryList[0].name,
                style: TextStyle(
                  color: const Color(0xFFE67F1E),
                  fontWeight: FontWeight.bold,
                  fontSize: deviceSize.width * 0.05,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(fruitTypeList()[index].name),
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage(fruitTypeList()[index].image),
                      ),
                    );
                  },
                  itemCount: fruitTypeList().length,
                ),
              ),
              SizedBox(height: deviceSize.height * 0.009),
              Text(
                categoryList[1].name,
                style: TextStyle(
                  color: const Color(0xFFE67F1E),
                  fontWeight: FontWeight.bold,
                  fontSize: deviceSize.width * 0.05,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(vegetableTypeList()[index].name),
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage(vegetableTypeList()[index].image),
                      ),
                    );
                  },
                  itemCount: vegetableTypeList().length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
