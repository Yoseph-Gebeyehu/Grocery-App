import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/Models/home_model.dart';

class ItemDetail extends StatefulWidget {
  final Fruit fruit;
  static const itemDetail = 'item-detail';

   ItemDetail({required this.fruit});

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  initState() {
    super.initState();
  }

  bool isAddedToCart = false;

  Future<void> addToCart(Fruit fruit) async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !fruit.isAddedToCart;
    setState(() {
      fruit.isAddedToCart = newValue;
      isAddedToCart = true;
    });
    await prefs.setBool(fruit.image, newValue);
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: deviceSize.height * 0.4,
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.all(60),
                  child: Image.asset(
                    widget.fruit.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: deviceSize.height * 0.05,
                  left: deviceSize.width * 0.02,
                  child: IconButton(
                    iconSize: deviceSize.width * 0.1,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      return Navigator.of(context).pop(isAddedToCart);
                    },
                  ),
                ),
                Positioned(
                  top: deviceSize.height * 0.35,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: deviceSize.width * 0.1,
                        right: deviceSize.width * 0.1,
                        top: deviceSize.height * 0.03,
                      ),
                      width: deviceSize.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.fruit.name,
                                style: TextStyle(
                                  fontSize: deviceSize.width * 0.06,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  backgroundColor: widget.fruit.isAddedToCart
                                      ? MaterialStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              255, 215, 209, 209))
                                      : MaterialStateProperty.all<Color>(
                                          const Color(0xFFFEC54B)),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    const EdgeInsets.all(15),
                                  ),
                                ),
                                onPressed: () {
                                  widget.fruit.isAddedToCart
                                      ? null
                                      : addToCart(widget.fruit);
                                },
                                child: Text(
                                  widget.fruit.isAddedToCart
                                      ? 'Added to cart'
                                      : 'Add to cart',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: deviceSize.width * 0.03,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                widget.fruit.amout.toString(),
                                style: TextStyle(
                                  fontSize: deviceSize.width * 0.05,
                                  color: const Color(0xFFFEC54B),
                                ),
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Color(0xFFFEC54B),
                                      ),
                                    ),
                                    Text(
                                      '3',
                                      style: TextStyle(
                                        fontSize: deviceSize.width * 0.05,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.add,
                                        color: Color(0xFFFEC54B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: deviceSize.height * 0.01),
                          Text(
                            'Description',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: deviceSize.width * 0.05,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: deviceSize.height * 0.015,
                            ),
                            height: deviceSize.height * 0.002,
                            width: double.infinity,
                            child: ClipRect(
                              child: Stack(
                                children: const [
                                  LinearProgressIndicator(
                                    value: 0.35,
                                    backgroundColor: Color(0xFFDDDDDD),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            style: TextStyle(
                              fontSize: deviceSize.width * 0.04,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
