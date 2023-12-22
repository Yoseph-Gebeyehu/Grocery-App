import 'package:flutter/material.dart';

import '/data/models/products.dart';
import '../item-detail/item_detail.dart';

class CategoryDetailPage extends StatelessWidget {
  final List<Products> productsList;
  const CategoryDetailPage({super.key, required this.productsList});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(productsList[0].category!.toUpperCase()[0] +
            productsList[0].category!.substring(1)),
        toolbarHeight: deviceSize.height * 0.1,
        elevation: 10,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final products = productsList[index];
          return Column(
            children: [
              SizedBox(height: deviceSize.height * 0.01),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ItemDetail.itemDetail,
                    arguments: products,
                  );
                },
                child: ListTile(
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
                ),
              ),
              divider(deviceSize),
            ],
          );
        },
        itemCount: productsList.length,
      ),
    );
  }

  Widget divider(Size deviceSize) {
    return Divider(
      thickness: 1,
      indent: deviceSize.width * 0.05,
      endIndent: deviceSize.width * 0.05,
    );
  }
}
