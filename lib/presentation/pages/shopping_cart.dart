import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);
  static const shoppingCart = 'shopping-cart';
  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<String> imagesList = [
    'assets/banana_detail.png',
    'assets/bronci_detail.png',
    'assets/mushroom_details.png',
  ];
  List<String> category = [
    'FRUITS',
    'VEGETABLES',
    'MUSHROOM',
  ];
  List<String> fruitName = [
    'Banana',
    'Brocolli',
    'Oyster Mushroom',
  ];
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: deviceSize.height * 0.08,
        backgroundColor: const Color(0xFFFFFFFF),
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: deviceSize.width * 0.1),
          child: const Text(
            'Item details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 10,
              child: ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceSize.width * 0.08,
                    vertical: deviceSize.height * 0.015,
                  ),
                  child: SizedBox(
                    height: deviceSize.height * 0.15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          child: Image.asset(
                            imagesList[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: deviceSize.width * 0.05,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      category[index],
                                      style: TextStyle(
                                        fontSize: deviceSize.width * 0.03,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      fruitName[index],
                                      style: TextStyle(
                                        fontSize: deviceSize.width * 0.05,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\$${((index + 0.1) * 19.57).toString()}',
                                    style: TextStyle(
                                      fontSize: deviceSize.width * 0.05,
                                      color: const Color(0xFFE67F1E),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: deviceSize.height * 0.04,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFEFEF),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.remove,
                                              color: Color(0xFFB1B1B1),
                                            ),
                                          ),
                                          Text(
                                            index.toString(),
                                            style: TextStyle(
                                              fontSize: deviceSize.width * 0.05,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.add,
                                              color: Color(0xFFB1B1B1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                itemCount: imagesList.length,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceSize.width * 0.08,
                  vertical: deviceSize.height * 0.015,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'total \$6',
                        style: TextStyle(
                          fontSize: deviceSize.width * 0.05,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.009),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFFEC54B)),
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50),
                          ),
                        ),
                        child: Text(
                          'PLACE ORDER',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: deviceSize.width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
