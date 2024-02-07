import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/models/products.dart';

class ItemDetail extends StatefulWidget {
  final Products products;
  static const itemDetail = 'item-detail';

  ItemDetail({required this.products});

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  initState() {
    super.initState();
  }

  bool isAddedToCart = false;

  Future<void> addToCart(Products products) async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !products.isAddedToCart;
    setState(() {
      products.isAddedToCart = newValue;
      isAddedToCart = true;
    });
    await prefs.setBool(products.image!, newValue);
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
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.all(60),
                  child: Container(
                    width: deviceSize.width * 0.2,
                    height: deviceSize.height * 0.15,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.products.image!,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: deviceSize.height * 0.05,
                  left: deviceSize.width * 0.02,
                  child: IconButton(
                    iconSize: deviceSize.width * 0.06,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).iconTheme.color,
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
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
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
                                widget.products.title!.substring(0, 10),
                                style: TextStyle(
                                  fontSize: deviceSize.width * 0.06,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .color,
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
                                  backgroundColor: widget.products.isAddedToCart
                                      ? MaterialStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              255, 188, 173, 173),
                                        )
                                      : MaterialStateProperty.all<Color>(
                                          Theme.of(context).primaryColor,
                                        ),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    const EdgeInsets.all(15),
                                  ),
                                ),
                                onPressed: () {
                                  widget.products.isAddedToCart
                                      ? null
                                      : addToCart(widget.products);
                                },
                                child: Text(
                                  widget.products.isAddedToCart
                                      ? AppLocalizations.of(context)!
                                          .added_to_cart
                                      : AppLocalizations.of(context)!
                                          .add_to_cart,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .color,
                                    fontSize: deviceSize.width * 0.03,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${widget.products.price.toString()} ${AppLocalizations.of(context)!.br}',
                                style: TextStyle(
                                  fontSize: deviceSize.width * 0.05,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                            ],
                          ),
                          SizedBox(height: deviceSize.height * 0.01),
                          Text(
                            AppLocalizations.of(context)!.description,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: deviceSize.width * 0.05,
                              color:
                                  Theme.of(context).textTheme.titleLarge!.color,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: deviceSize.height * 0.015,
                            ),
                            height: deviceSize.height * 0.002,
                            width: double.infinity,
                            child: const ClipRect(
                              child: Stack(
                                children: [
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
                            widget.products.description![0].toUpperCase() +
                                widget.products.description!.substring(1),
                            style: TextStyle(
                              fontSize: deviceSize.width * 0.04,
                              color:
                                  Theme.of(context).textTheme.titleLarge!.color,
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
