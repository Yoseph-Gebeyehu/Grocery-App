import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const home = 'home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // const Home({Key? key}) : super(key: key);
  List<String> images1 = [
    'assets/banana.png',
    'assets/ice-cream.png',
    'assets/milk.png',
    'assets/banana.png',
    'assets/ice-cream.png',
    'assets/milk.png',
    'assets/banana.png',
    'assets/ice-cream.png',
    'assets/milk.png',
    'assets/banana.png',
  ];

  List<String> images2 = [
    'assets/oranage.png',
    'assets/garlic.png',
    'assets/broccoli.png',
    'assets/onion.png',
    'assets/banana2.png',
    'assets/cabbage.png',
    'assets/tomato.png',
    'assets/potato.png',
  ];

  List<String> fruitNames = [
    'Orange',
    'Garlic',
    'Broccoli',
    'Onion',
    'Banana',
    'Cabbabe',
    'Tomato',
    'Potato',
  ];

  List isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

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
              'Good Morning',
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
                      child: Image.asset(images1[index]),
                    ),
                    SizedBox(width: deviceSize.width * 0.02)
                  ],
                ),
                scrollDirection: Axis.horizontal,
                itemCount: images1.length,
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
                                  setState(() {
                                    isSelected[index] = !isSelected[index];
                                    print(isSelected[index]);
                                  });
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  // color: Color(0xFFB1B1B1),
                                  color: isSelected[index]
                                      ? const Color(0xFFFF2E6C)
                                      : const Color(0xFFB1B1B1),
                                ),
                              ),
                              Image.asset(
                                images2[index],
                                fit: BoxFit.cover,
                              ),
                              Text(
                                fruitNames[index],
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
                                    '\$6.7',
                                    style: TextStyle(
                                      fontSize: deviceSize.width * 0.036,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Add to cart',
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
                  itemCount: images2.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
