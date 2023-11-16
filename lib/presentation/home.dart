import 'package:flutter/material.dart';

import '../data/Models/home_model.dart';
import '../domain/Constants/Images/home_images.dart';
import '../domain/Constants/Images/home_images2.dart';
import '../domain/Constants/names/home_fruit_names.dart';

class Home extends StatefulWidget {
  static const home = 'home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<HomeModel> fruitModel = List.generate(
    HomeImages2.images.length,
    (index) => HomeModel(
      image: HomeImages2.images[index],
      name: HomeFruitNames.fruitNames[index],
      amout: '\$${(index * 1.78).toString()}',
      addToCart: 'Add to cart',
    ),
  );

  void toggleFavorite(int index) {
    setState(() {
      fruitModel[index].isFavorite = !fruitModel[index].isFavorite;
      print(fruitModel[index].isFavorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: deviceSize.height * 0.1,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateTime.now().hour < 12 ? 'Good Morning' : 'Good Afternoon',
              style: TextStyle(
                fontSize: deviceSize.width * 0.04,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Rafatul Islam',
              style: TextStyle(
                fontSize: deviceSize.width * 0.045,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: const Color(0xFF384144),
              size: deviceSize.height * 0.03,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: deviceSize.width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.045,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
            SizedBox(
              height: deviceSize.height * 0.13,
              child: ListView.builder(
                itemBuilder: (context, index) => Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(
                          0xFFFBFBFB,
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
                      width: deviceSize.width * 0.25,
                      height: deviceSize.height * 0.1,
                      child: Image.asset(HomeImages.images[index]),
                    ),
                    SizedBox(width: deviceSize.width * 0.02)
                  ],
                ),
                scrollDirection: Axis.horizontal,
                itemCount: HomeImages.images.length,
              ),
            ),
            SizedBox(height: deviceSize.height * 0.02),
            Text(
              'Latest Products',
              style: TextStyle(
                fontSize: deviceSize.width * 0.045,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: deviceSize.height * 0.02),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: deviceSize.width * 0.08),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2 / 3,
                  ),
                  itemBuilder: (context, index) => Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  toggleFavorite(index);
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: fruitModel[index].isFavorite
                                      ? const Color(0xFFFF2E6C)
                                      : const Color(0xFFB1B1B1),
                                ),
                              ),
                              Image.asset(
                                fruitModel[index].image,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                HomeFruitNames.fruitNames[index],
                                style: TextStyle(
                                  fontSize: deviceSize.width * 0.036,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    fruitModel[index].amout,
                                    style: TextStyle(
                                      fontSize: deviceSize.width * 0.036,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    fruitModel[index].addToCart,
                                    style: TextStyle(
                                      fontSize: deviceSize.width * 0.036,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFFF0000),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  itemCount: fruitModel.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
