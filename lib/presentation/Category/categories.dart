import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/domain/constants/names/product_categories.dart';
import 'package:grocery/presentation/category-detail/category_detail.dart';

import '../../domain/Constants/Images/home_images.dart';
import '../Home/bloc/home_bloc.dart';
import '../../widgets/no_internet.dart';

class CategoryPage extends StatefulWidget {
  static const category = 'category';

  const CategoryPage({super.key});

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
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) async {
        BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is FetchProductsState) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: deviceSize.width * 0.0375,
                  crossAxisSpacing: deviceSize.width * 0.0375,
                  childAspectRatio: 1 / 1,
                ),
                itemBuilder: (context, index) {
                  const image = HomeImages.images;
                  final name = ProductCategory.categoryName[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CategoryDetailPage(
                                productsList: state.products
                                    .where(
                                      (product) =>
                                          product.category ==
                                          ProductCategory.categoryName[index],
                                    )
                                    .toList()),
                          ));
                        },
                        child: Container(
                          width: double.infinity,
                          height: deviceSize.height * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                spreadRadius: 2,
                                blurRadius: 1,
                                offset: const Offset(1, 2),
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(
                                image[index],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.02),
                      Text(
                        name.toUpperCase()[0] + name.substring(1),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.titleLarge!.color,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: ProductCategory.categoryName.length,
              ),
            );
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
    );
  }

  Widget divider() {
    Size deviceSize = MediaQuery.of(context).size;

    return Divider(
      thickness: 1,
      indent: deviceSize.width * 0.05,
      endIndent: deviceSize.width * 0.05,
    );
  }
}
