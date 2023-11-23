import 'package:flutter/material.dart';
import 'package:grocery/domain/constants/images/chapa_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/Models/home_model.dart';
import '../../domain/Constants/Images/home_images2.dart';
import '../../domain/Constants/names/category_fruit_names.dart';
import '../../domain/Constants/names/home_fruit_names.dart';
import '../check-out/customer_info.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);
  static const shoppingCart = 'shopping-cart';
  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  void initState() {
    super.initState();
    loadCartFruits();
    totalAmount();
  }

  List<Fruit> fruitList = List.generate(
    HomeImages2.images.length,
    (index) => Fruit(
      image: HomeImages2.images[index],
      name: HomeFruitNames.fruitNames[index],
      amout: index * 2,
      category: CategoryNames.fruitName[index],
    ),
  );
  List<Fruit> cartFruits = [];
  double total = 0;
  // resetTotalAmount() {
  //   total = 0;
  // }

  totalAmount() {
    total = 0; // Reset the total amount to zero before calculating
    cartFruits.forEach((element) {
      total += element.amout * itemCount[cartFruits.indexOf(element)];
    });
    return total;
  }

  List<int> itemCount = [];
  incrementItemCount(int index) {
    setState(() {
      itemCount[index] += 1;
    });
  }

  decrementItemCount(int index) {
    if (itemCount[index] > 1) {
      setState(() {
        itemCount[index] -= 1;
      });
    }
  }

  Future<void> loadCartFruits() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fruitList.forEach((fruit) {
        fruit.isAddedToCart = prefs.getBool(fruit.image) ?? false;
      });
      for (int i = 0; i < fruitList.length; i++) {
        if (fruitList[i].isAddedToCart == true) {
          cartFruits.add(fruitList[i]);
        }
      }
    });
    itemCount = List.generate(cartFruits.length, (index) => 1);
  }

  Future<void> removeFromCart(Fruit fruit) async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !fruit.isAddedToCart;
    setState(() {
      fruit.isAddedToCart = newValue;
    });
    await prefs.setBool(fruit.image, newValue);
  }

  void _showCustomerInfoSheet(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Container(
              color: Colors.white,
              height: deviceSize.height * 0.3,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: deviceSize.width * 0.05,
                right: deviceSize.width * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Complete action via',
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: Text(
                      'Chapa Financial Technologies',
                      style: TextStyle(fontSize: deviceSize.width * 0.04),
                      textAlign: TextAlign.center,
                    ),
                    trailing: Container(
                      width: deviceSize.width * 0.2,
                      child: Image.asset(
                        ChapaImage.chapa,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  CustomerInformationForm(amount: totalAmount().toString()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
            'Cart',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: cartFruits.isEmpty
          ? const Center(
              child: Text('No cart is added yet'),
            )
          : SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 10,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        var fruits = cartFruits[index];
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: deviceSize.width * 0.08,
                                vertical: deviceSize.height * 0.015,
                              ),
                              child: SizedBox(
                                height: deviceSize.height * 0.15,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      child: Image.asset(
                                        cartFruits[index].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: deviceSize.width * 0.05,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      cartFruits[index]
                                                          .category,
                                                      style: TextStyle(
                                                        fontSize:
                                                            deviceSize.width *
                                                                0.03,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      cartFruits[index].name,
                                                      style: TextStyle(
                                                        fontSize:
                                                            deviceSize.width *
                                                                0.05,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                  onPressed: () async {
                                                    removeFromCart(fruits);
                                                    cartFruits.removeAt(index);
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                (cartFruits[index].amout *
                                                        itemCount[index])
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      deviceSize.width * 0.05,
                                                  color:
                                                      const Color(0xFFE67F1E),
                                                ),
                                              ),
                                              const Spacer(),
                                              Container(
                                                height:
                                                    deviceSize.height * 0.04,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFEFEFEF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          decrementItemCount(
                                                            index,
                                                          );
                                                        },
                                                        icon: const Icon(
                                                          Icons.remove,
                                                          color:
                                                              Color(0xFFB1B1B1),
                                                        ),
                                                      ),
                                                      Text(
                                                        itemCount[index]
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize:
                                                              deviceSize.width *
                                                                  0.05,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          incrementItemCount(
                                                            index,
                                                          );
                                                        },
                                                        icon: const Icon(
                                                          Icons.add,
                                                          color:
                                                              Color(0xFFB1B1B1),
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
                            Divider(
                              thickness: 1,
                              indent: deviceSize.width * 0.1,
                              endIndent: deviceSize.width * 0.1,
                            ),
                          ],
                        );
                      },
                      itemCount: cartFruits.length,
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
                              totalAmount().toString(),
                              style: TextStyle(
                                fontSize: deviceSize.width * 0.05,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: deviceSize.height * 0.009),
                            ElevatedButton(
                              onPressed: () {
                                // String total = totalAmount().toString();
                                // Navigator.pushNamed(
                                //   context,
                                //   CustomerInformationForm.customerInfo,
                                //   arguments: total,
                                // );
                                _showCustomerInfoSheet(context);
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         CustomerInformationForm(
                                //       amount: totalAmount().toString(),
                                //     ),
                                //   ),
                                // );
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
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
