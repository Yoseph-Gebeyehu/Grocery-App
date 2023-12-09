import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/models/user.dart';
import '/domain/constants/names/home_fruit_names.dart';
import '/domain/Constants/Images/home_images.dart';
import '/presentation/home/widgets/api_error_widget.dart';
import '/presentation/auth/view/signin.dart';
import '/widgets/no_internet.dart';
import '/data/models/products.dart';
import '../../home/widgets/custom_drawer.dart';
import '../../Home/bloc/home_bloc.dart';
import '../../item-detail/item_detail.dart';

class Home extends StatefulWidget {
  static const home = 'home';
  User user;
  Home({required this.user});
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

  List<Products> products = [];

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: CustomDrawer(user: widget.user),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: deviceSize.height * 0.1,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              widget.user.userName!,
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
              size: deviceSize.height * 0.03,
            ),
          ),
          IconButton(
            onPressed: () {
              _dialog(context);
            },
            icon: Icon(
              Icons.logout,
              size: deviceSize.height * 0.03,
            ),
          ),
        ],
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) async {
          if (state is AddedToFavoriteState) {
            BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());
          } else {
            BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is FetchProductsState) {
            products = state.products;
            return homeWidget(deviceSize, products);
          } else if (state is AddedToCartState) {
            return homeWidget(deviceSize, products);
          } else if (state is AddedToFavoriteState) {
            return homeWidget(deviceSize, products);
          } else if (state is ApiErrorState) {
            return const ApiErrorWidget();
          } else if (state is NetworkErrorState) {
            return const NoConnectionPage();
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFE67F1E),
            ),
          );
        }),
      ),
    );
  }

  Widget homeWidget(Size deviceSize, List<Products> productsList) {
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
            height: deviceSize.height * 0.15,
            child: ListView.builder(
              itemBuilder: (context, index) => Row(
                children: [
                  Column(
                    children: [
                      SizedBox(height: deviceSize.height * 0.005),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
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
                        child: Container(
                          width: double.infinity,
                          height: deviceSize.height * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: AssetImage(
                                HomeImages.images[index],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.02),
                      Text(HomeFruitNames.categoryName[index]),
                    ],
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
              itemBuilder: (context, index) {
                var product = productsList[index];
                return Column(
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
                              onPressed: () async {
                                context.read<HomeBloc>().add(
                                      AddToFavorite(
                                        products: product,
                                      ),
                                    );
                                BlocProvider.of<HomeBloc>(context)
                                    .add(FetchProductsEvent());
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
                                var pageResponse = await Navigator.pushNamed(
                                  context,
                                  ItemDetail.itemDetail,
                                  arguments: product,
                                );
                                if (pageResponse is bool) {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(CartInitial());
                                } else {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(CartInitial());
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: deviceSize.height * 0.15,
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
                                fontSize: deviceSize.width * 0.036,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.price!.toString(),
                                  style: TextStyle(
                                    fontSize: deviceSize.width * 0.036,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    product.isAddedToCart
                                        ? null
                                        : context.read<HomeBloc>().add(
                                              AddToCartEvent(
                                                products: product,
                                              ),
                                            );
                                  },
                                  child: Text(
                                    product.isAddedToCart
                                        ? 'Added to cart'
                                        : 'Add to cart',
                                    style: TextStyle(
                                      fontSize: deviceSize.width * 0.03,
                                      fontWeight: FontWeight.bold,
                                      color: product.isAddedToCart
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
              itemCount: productsList.length,
            ),
          )),
        ],
      ),
    );
  }

  void _dialog(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: deviceSize.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Log out from this account?',
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.05,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: deviceSize.height * 0.005),
                const Divider(),
                SizedBox(height: deviceSize.height * 0.005),
                InkWell(
                  onTap: () async {
                    await Navigator.of(context)
                        .pushReplacementNamed(SigninPage.signIn);
                  },
                  child: Text(
                    'Log out ',
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(height: deviceSize.height * 0.005),
                const Divider(),
                SizedBox(height: deviceSize.height * 0.005),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: deviceSize.height * 0.005),
                const Divider(),
              ],
            ),
          ),
        );
      },
    );
  }
}
