import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:grocery/domain/constants/names/product_categories.dart';

import '/domain/Constants/Images/home_images.dart';
import '/presentation/category-detail/category_detail.dart';
import '/presentation/home/widgets/api_error_widget.dart';
import '/data/models/user.dart';
import '/data/models/products.dart';
import '/widgets/no_internet.dart';
import '../../Home/bloc/home_bloc.dart';
import '../../item-detail/item_detail.dart';

class Home extends StatefulWidget {
  static const home = 'home';
  final User user;
  const Home({super.key, required this.user});
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
    return BlocListener<HomeBloc, HomeState>(
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
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        );
      }),
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
                AppLocalizations.of(context)!.categories,
                style: TextStyle(
                  fontSize: deviceSize.width * 0.045,
                  color: Theme.of(context).textTheme.titleLarge!.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: deviceSize.height * 0.01),
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
                          color: Theme.of(context).shadowColor,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x42000000),
                              offset: Offset(2, 2),
                              blurRadius: 0,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        width: deviceSize.width * 0.25,
                        height: deviceSize.height * 0.1,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CategoryDetailPage(
                                  productsList: products
                                      .where((product) =>
                                          product.category ==
                                          ProductCategory.categoryName[index])
                                      .toList(),
                                ),
                              ),
                            );
                          },
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
                      ),
                      SizedBox(height: deviceSize.height * 0.02),
                      Text(
                        ProductCategory.categoryName[index].toUpperCase()[0] +
                            ProductCategory.categoryName[index].substring(1),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.titleLarge!.color,
                        ),
                      ),
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
            AppLocalizations.of(context)!.all_products,
            style: TextStyle(
              fontSize: deviceSize.width * 0.045,
              color: Theme.of(context).textTheme.titleLarge!.color,
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
                childAspectRatio: 3 / 5,
              ),
              itemBuilder: (context, index) {
                var product = productsList[index];
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).shadowColor,
                              offset: const Offset(1, 4),
                              blurRadius: 0.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () async {
                                context.read<HomeBloc>().add(
                                      AddToFavorite(products: product),
                                    );
                                BlocProvider.of<HomeBloc>(context).add(
                                  FetchProductsEvent(),
                                );
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
                                  // ignore: use_build_context_synchronously
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(CartInitial());
                                } else {
                                  // ignore: use_build_context_synchronously
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
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              product.title!.substring(0, 5),
                              style: TextStyle(
                                fontSize: deviceSize.width * 0.036,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    product.price!.toString(),
                                    style: TextStyle(
                                      fontSize: deviceSize.width * 0.036,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .color,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: GestureDetector(
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
                                          ? AppLocalizations.of(context)!
                                              .added_to_cart
                                          : AppLocalizations.of(context)!
                                              .add_to_cart,
                                      style: TextStyle(
                                        fontSize: deviceSize.width * 0.03,
                                        fontWeight: FontWeight.bold,
                                        color: product.isAddedToCart
                                            ? const Color(0xFFB1B1B1)
                                            : const Color(0xFFFF0000),
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
}
