import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);
  static const favorite = 'favorite';
  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
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
      body: ListView.builder(
        itemBuilder: (context, index) => Padding(
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
                SizedBox(
                  child: Image.asset(
                    'assets/banana_detail.png',
                    fit: BoxFit.cover,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Banana',
                              style: TextStyle(
                                fontSize: deviceSize.width * 0.05,
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
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
                            '\$${((index + 0.1) * 10).toString()}',
                            style: TextStyle(
                              fontSize: deviceSize.width * 0.05,
                              color: const Color(0xFFE67F1E),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFEFEF),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    'Add to cart',
                                    style: TextStyle(
                                      fontSize: deviceSize.width * 0.035,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
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
        ),
        itemCount: 7,
      ),
    );
  }
}
