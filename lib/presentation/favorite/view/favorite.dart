import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/data/models/products.dart';

import '../../../presentation/Home/bloc/home_bloc.dart';
import '../../item_detail.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);
  static const favorite = 'favorite';
  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());
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
            'Favorite\'s',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) async {
          if (state is AddedToFavoriteState) {
            BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());
          } else if (state is AddedToCartState) {
            BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());
          } else {}
        },
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is FetchProductsState) {
            List<Products> favProducts =
                state.products.where((product) => product.isFavorite).toList();

            return favProducts.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
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
                              GestureDetector(
                                onTap: () async {
                                  var pageResponse = await Navigator.pushNamed(
                                    context,
                                    ItemDetail.itemDetail,
                                    arguments: favProducts[index],
                                  );
                                  if (pageResponse is bool) {
                                    BlocProvider.of<HomeBloc>(context)
                                        .add(FetchProductsEvent());
                                  } else {
                                    BlocProvider.of<HomeBloc>(context)
                                        .add(FetchProductsEvent());
                                  }
                                },
                                child: Container(
                                  width: deviceSize.width * 0.2,
                                  height: deviceSize.height * 0.15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        favProducts[index].image!,
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: deviceSize.width * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            favProducts[index]
                                                .title!
                                                .substring(0, 10),
                                            style: TextStyle(
                                              fontSize: deviceSize.width * 0.05,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () async {
                                              BlocProvider.of<HomeBloc>(context)
                                                  .add(
                                                AddToFavorite(
                                                  products: favProducts[index],
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.favorite,
                                              color: Color(0xFFFF2E6C),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          favProducts[index].price.toString(),
                                          style: TextStyle(
                                            fontSize: deviceSize.width * 0.05,
                                            color: const Color(0xFFE67F1E),
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            favProducts[index].isAddedToCart
                                                ? null
                                                : context.read<HomeBloc>().add(
                                                      AddToCartEvent(
                                                        products:
                                                            favProducts[index],
                                                      ),
                                                    );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: favProducts[index]
                                                      .isAddedToCart
                                                  ? const Color(0xFFEFEFEF)
                                                  : const Color(0xFFFEC54B),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    favProducts[index]
                                                            .isAddedToCart
                                                        ? 'Added to cart'
                                                        : 'Add to cart',
                                                    style: TextStyle(
                                                      fontSize:
                                                          deviceSize.width *
                                                              0.03,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                      );
                    },
                    itemCount: favProducts.length,
                  )
                : const Center(
                    child: Text('There is no favorite product'),
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
