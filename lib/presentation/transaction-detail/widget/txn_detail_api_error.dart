import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TxnDetailApiErrorWidget extends StatelessWidget {
  const TxnDetailApiErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceSize.width * 0.05,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2 / 3,
        ),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
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
                          onPressed: () async {},
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.grey[300],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: deviceSize.height * 0.15,
                          color: Colors.white,
                        ),
                        Container(
                          width: deviceSize.width * 0.2,
                          height: 20,
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: deviceSize.width * 0.1,
                              height: 20,
                              color: Colors.white,
                            ),
                            Container(
                              width: deviceSize.width * 0.2,
                              height: 20,
                              color: Colors.white,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: 6,
      ),
    );
  }
}
