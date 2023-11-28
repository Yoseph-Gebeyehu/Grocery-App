import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Home/bloc/home_bloc.dart';
import '../../../domain/Constants/Images/home_images.dart';
import '../../item-detail/item_detail.dart';

class Home extends StatefulWidget {
  static const home = 'home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());
  }

  @override
  void dispose() {
    HomeBloc().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                'John Zabede',
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
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) async {
            if (state is AddedToFavoriteState) {
              BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());
            } else if (state is AddedToCartState) {
              BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Padding(
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
                      child: state is FetchProductsState
                          ? Padding(
                              padding: EdgeInsets.only(
                                  right: deviceSize.width * 0.08),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 2 / 3,
                                ),
                                itemBuilder: (context, index) {
                                  var product = state.products[index];
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                onPressed: () async {
                                                  context.read<HomeBloc>().add(
                                                        AddToFavorite(
                                                          products: product,
                                                        ),
                                                      );
                                                  BlocProvider.of<HomeBloc>(
                                                          context)
                                                      .add(
                                                          FetchProductsEvent());
                                                },
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: product.isFavorite
                                                      ? const Color(0xFFFF2E6C)
                                                      : const Color(0xFFB1B1B1),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  var pageResponse =
                                                      await Navigator.pushNamed(
                                                    context,
                                                    ItemDetail.itemDetail,
                                                    arguments: product,
                                                  );
                                                  if (pageResponse is bool) {
                                                    BlocProvider.of<HomeBloc>(
                                                            context)
                                                        .add(CartInitial());
                                                  } else {
                                                    BlocProvider.of<HomeBloc>(
                                                            context)
                                                        .add(CartInitial());
                                                  }
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height:
                                                      deviceSize.height * 0.15,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        product.image!,
                                                      ),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                product.title!.substring(0, 5),
                                                style: TextStyle(
                                                  fontSize:
                                                      deviceSize.width * 0.036,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    product.price!.toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          deviceSize.width *
                                                              0.036,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      product.isAddedToCart
                                                          ? null
                                                          : context
                                                              .read<HomeBloc>()
                                                              .add(
                                                                AddToCartEvent(
                                                                  products:
                                                                      product,
                                                                ),
                                                              );
                                                    },
                                                    child: Text(
                                                      product.isAddedToCart
                                                          ? 'Added to cart'
                                                          : 'Add to cart',
                                                      style: TextStyle(
                                                        fontSize:
                                                            deviceSize.width *
                                                                0.03,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: product
                                                                .isAddedToCart
                                                            ? const Color(
                                                                0xFFB1B1B1,
                                                              )
                                                            : const Color(
                                                                0xFFFF0000,
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                itemCount: state.products.length,
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
