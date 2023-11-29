import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomstring_dart/randomstring_dart.dart';

import '../../../domain/constants/images/chapa_images.dart';
import '../bloc/shopping_cart_bloc.dart';

class CheckOutWidget extends StatefulWidget {
  static const customerInfo = 'customer-info';
  String amount;
  CheckOutWidget({required this.amount});

  @override
  _CheckOutWidgetState createState() => _CheckOutWidgetState();
}

class _CheckOutWidgetState extends State<CheckOutWidget> {
  String? title;
  String? description;
  String currency = 'ETB';
  String key = 'CHASECK_TEST-KzqTmzYnjSL5UDnlA7YuiAZY3OoeujYo';

  var rs = RandomString();

  var txRef = RandomString().getRandomString(
    uppersCount: 10,
    lowersCount: 10,
    specialsCount: 2,
  );

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return BlocListener<ShoppingCartBloc, ShoppingCartState>(
      listener: (context, state) {},
      child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: Container(
                color: Colors.white,
                height: deviceSize.height * 0.35,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: deviceSize.width * 0.05,
                  right: deviceSize.width * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Complete action via',
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.star),
                      title: Text(
                        'Chapa Financial Technologies',
                        style: TextStyle(fontSize: deviceSize.width * 0.04),
                        textAlign: TextAlign.center,
                      ),
                      trailing: SizedBox(
                        width: deviceSize.width * 0.2,
                        child: Image.asset(
                          ChapaImage.chapa,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      'Total: ${widget.amount} Birr',
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.04,
                        color: Colors.black,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            BlocProvider.of<ShoppingCartBloc>(context).add(
                              BuyEvent(
                                amount: widget.amount,
                                txRef: txRef,
                                currency: currency,
                              ),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFFEC54B)),
                            minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 50),
                            ),
                          ),
                          child: Text(
                            'Buy',
                            style: TextStyle(
                              fontSize: deviceSize.width * 0.05,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
