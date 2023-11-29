import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/no_internet.dart';
import '../../../data/models/products.dart';
import '../../../presentation/shopping-cart/widget/check_out_widget.dart';
import '../../Home/bloc/home_bloc.dart';

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
    BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());
    total();
    forSpecificCouts();
  }

  List<Products> cartProducts = [];

  double all = 0;
  List<int> counts = [];
  List<int> specificCount = [];
  double total() {
    all = 0;
    for (int i = 0; i < cartProducts.length; i++) {
      all += specificCount[i] * cartProducts[i].price!;
    }
    return all;
  }

  forSpecificCouts() {
    specificCount = List.generate(cartProducts.length, (index) => 1);
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
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                print('state $state');
                if (state is AddedToCartState) {
                  BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());
                } else {
                  BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());
                  forSpecificCouts();
                  total();
                }
              },
              child: Expanded(
                flex: 11,
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is FetchProductsState) {
                      cartProducts = state.products
                          .where((product) => product.isAddedToCart)
                          .toList();
                      // forSpecificCouts();
                      // total();
                      counts = List.generate(cartProducts.length, (index) => 1);
                      return cartProducts.isEmpty
                          ? const Center(
                              child: Text('Product is not added to cart yet!'),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                final cart = cartProducts[index];
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              width: deviceSize.width * 0.2,
                                              height: deviceSize.height * 0.15,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    cart.image!,
                                                  ),
                                                  fit: BoxFit.contain,
                                                ),
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
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    child: Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              cart.category!,
                                                              style: TextStyle(
                                                                fontSize: deviceSize
                                                                        .width *
                                                                    0.03,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Text(
                                                              cart.title!
                                                                  .substring(
                                                                      0, 10),
                                                              style: TextStyle(
                                                                fontSize: deviceSize
                                                                        .width *
                                                                    0.05,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        IconButton(
                                                          onPressed: () async {
                                                            BlocProvider.of<
                                                                        HomeBloc>(
                                                                    context)
                                                                .add(
                                                              AddToCartEvent(
                                                                products: cart,
                                                              ),
                                                            );
                                                            BlocProvider.of<
                                                                        HomeBloc>(
                                                                    context)
                                                                .add(
                                                                    FetchProductsEvent());
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
                                                        (cart.price! *
                                                                specificCount[
                                                                    index])
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize:
                                                              deviceSize.width *
                                                                  0.05,
                                                          color: const Color(
                                                              0xFFE67F1E),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Container(
                                                        height:
                                                            deviceSize.height *
                                                                0.04,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xFFEFEFEF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              IconButton(
                                                                onPressed: () {
                                                                  if (specificCount[
                                                                          index] >
                                                                      1) {
                                                                    setState(
                                                                        () {
                                                                      specificCount[
                                                                          index] -= 1;
                                                                    });
                                                                  }
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.remove,
                                                                  color: Color(
                                                                      0xFFB1B1B1),
                                                                ),
                                                              ),
                                                              Text(
                                                                specificCount[
                                                                        index]
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      deviceSize
                                                                              .width *
                                                                          0.05,
                                                                ),
                                                              ),
                                                              IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    specificCount[
                                                                        index] += 1;
                                                                  });
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  color: Color(
                                                                      0xFFB1B1B1),
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
                              itemCount: cartProducts.length,
                            );
                    } else if (state is NetworkErrorState) {
                      return const NoConnectionPage();
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceSize.width * 0.08,
                  vertical: deviceSize.height * 0.015,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        total().toString(),
                        style: TextStyle(
                          fontSize: deviceSize.width * 0.05,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.009),
                      ElevatedButton(
                        onPressed: () {
                          _showCustomerInfoSheet(context);
                        },
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

  void _showCustomerInfoSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CheckOutWidget(
          amount: total().toString(),
        );
      },
    );
  }
}
