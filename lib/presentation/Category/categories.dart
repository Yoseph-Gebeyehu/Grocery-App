import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/products.dart';
import '../../widgets/no_internet.dart';
import '../Home/bloc/home_bloc.dart';

class CategoryPage extends StatefulWidget {
  static const category = 'category';

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  initState() {
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
        centerTitle: true,
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) async {
          BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is FetchProductsState) {
              return Column(
                children: [
                  Expanded(
                    child: products(state.products, 'women\'s clothing'),
                  ),
                  divider(),
                  Expanded(
                    child: products(state.products, 'electronics'),
                  ),
                  divider(),
                  Expanded(
                    child: products(state.products, 'women\'s clothing'),
                  ),
                  divider(),
                  Expanded(
                    child: products(state.products, 'jewelery'),
                  ),
                  divider(),
                ],
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
    );
  }

  Widget products(List<Products> products, String categoryName) {
    Size deviceSize = MediaQuery.of(context).size;

    List<Products> allProducts = products
        .where((products) => products.category == categoryName)
        .toList();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceSize.width * 0.05,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFFBFBFB),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: deviceSize.height * 0.01),
            SizedBox(height: deviceSize.height * 0.009),
            Text(
              allProducts[0].category!.toUpperCase(),
              style: TextStyle(
                color: const Color(0xFFE67F1E),
                fontWeight: FontWeight.bold,
                fontSize: deviceSize.width * 0.05,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final products = allProducts[index];
                  return ListTile(
                    title: Text(products.title!),
                    leading: Container(
                      width: deviceSize.width * 0.2,
                      height: deviceSize.height * 0.15,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            products.image!,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: allProducts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    Size deviceSize = MediaQuery.of(context).size;

    return Divider(
      thickness: 1,
      indent: deviceSize.width * 0.1,
      endIndent: deviceSize.width * 0.1,
    );
  }
}
