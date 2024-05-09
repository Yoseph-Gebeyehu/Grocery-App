import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/presentation/auth/widgets/custom_button.dart';
import '/presentation/shopping-cart/widget/check_out_widget.dart';
import '../../Home/bloc/home_bloc.dart';
import '../../../widgets/no_internet.dart';
import '../../../widgets/snack_bar.dart';
import '../../../data/models/products.dart';

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
  }

  List<Products> cartProducts = [];

  double all = 0;
  List<int> specificCount = [];
  double total() {
    all = 0;
    for (int i = 0; i < cartProducts.length; i++) {
      all += specificCount[i] * cartProducts[i].price!;
    }
    return all;
  }

  counts() {
    if (specificCount.isEmpty) {
      specificCount = List.generate(cartProducts.length, (index) => 1);
    } else {
      specificCount =
          List.generate(cartProducts.length, (index) => specificCount[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is AddedToCartState) {
                  BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());

                  total();
                } else {
                  total();
                }
              },
              child: Expanded(
                flex: 15,
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is FetchProductsState) {
                      cartProducts = state.products
                          .where((product) => product.isAddedToCart)
                          .toList();
                      counts();
                      return cartProducts.isEmpty
                          ? Center(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .product_is_not_added_to_cart_yet,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .color,
                                ),
                              ),
                            )
                          : shoppingCart(deviceSize);
                    } else if (state is AddedToCartState) {
                      return cartProducts.isEmpty
                          ? Center(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .product_is_not_added_to_cart_yet,
                              ),
                            )
                          : shoppingCart(deviceSize);
                    } else if (state is NetworkErrorState) {
                      return const NoConnectionPage();
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  },
                ),
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Visibility(
                  visible: cartProducts.isNotEmpty,
                  child: Expanded(
                    flex: 2,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: deviceSize.width * 0.08,
                          vertical: deviceSize.height * 0.015,
                        ),
                        child: CustomButton(
                          function: () {
                            _showCustomerInfoSheet(context);
                          },
                          text: AppLocalizations.of(context)!.place_order,
                        )),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ListView shoppingCart(Size deviceSize) {
    return ListView.builder(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cart.category!,
                                      style: TextStyle(
                                        fontSize: deviceSize.width * 0.03,
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .color,
                                      ),
                                    ),
                                    Text(
                                      cart.title!.substring(0, 10),
                                      style: TextStyle(
                                        fontSize: deviceSize.width * 0.05,
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .color,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      cartProducts.removeAt(index);
                                      specificCount.removeAt(index);
                                    });
                                    total();
                                    counts();
                                    BlocProvider.of<HomeBloc>(context).add(
                                      AddToCartEvent(
                                        products: cart,
                                      ),
                                    );
                                    BlocProvider.of<HomeBloc>(context)
                                        .add(FetchProductsEvent());
                                    SnackBarWidget().showSnack(
                                      context,
                                      AppLocalizations.of(context)!
                                          .item_removed_from_cart,
                                    );
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
                                (cart.price! * specificCount[index])
                                    .toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: deviceSize.width * 0.05,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const Spacer(),
                              Center(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (specificCount[index] > 1) {
                                          setState(() {
                                            specificCount[index] -= 1;
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        color: specificCount[index] == 1
                                            ? const Color(0xFFB1B1B1)
                                            : const Color(0xFFFEC54B),
                                      ),
                                    ),
                                    Text(
                                      specificCount[index].toString(),
                                      style: TextStyle(
                                        fontSize: deviceSize.width * 0.05,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          specificCount[index] += 1;
                                        });
                                      },
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
              color: Theme.of(context).dividerColor,
            ),
          ],
        );
      },
      itemCount: cartProducts.length,
    );
  }

  void _showCustomerInfoSheet(BuildContext context) {
    List title = [];
    List description = [];
    for (int i = 0; i < cartProducts.length; i++) {
      title.add(cartProducts[i].title);
      description.add(cartProducts[i].description);
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CheckOutWidget(
          amount: total().toStringAsFixed(2),
          title: title.toString(),
          description: description.toString(),
        );
      },
    );
  }
}
