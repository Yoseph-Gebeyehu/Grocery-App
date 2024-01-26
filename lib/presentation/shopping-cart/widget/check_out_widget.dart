import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/presentation/auth/widgets/custom_button.dart';
import 'package:randomstring_dart/randomstring_dart.dart';

import '../bloc/shopping_cart_bloc.dart';

class CheckOutWidget extends StatefulWidget {
  static const customerInfo = 'customer-info';
  final String amount;
  final String title;
  final String description;
  const CheckOutWidget({
    super.key,
    required this.amount,
    required this.title,
    required this.description,
  });

  @override
  CheckOutWidgetState createState() => CheckOutWidgetState();
}

class CheckOutWidgetState extends State<CheckOutWidget> {
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
          // if (state is BuySuccessState) {
          //   final controller = WebViewController()
          //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
          //     ..loadRequest(Uri.parse(
          //       state.checkoutUrl,
          //     ));
          //   return Scaffold(
          //     appBar: AppBar(
          //       title: const Text('Chapa Checkout'),
          //     ),
          //     body: WebViewWidget(
          //       controller: controller,
          //     ),
          //   );
          // }
          return SingleChildScrollView(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
              child: Container(
                color: Colors.white,
                height: deviceSize.height * 0.3,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: deviceSize.width * 0.1,
                  right: deviceSize.width * 0.1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.order_details,
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        rowText(
                          AppLocalizations.of(context)!.price_of_items,
                          widget.amount,
                        ),
                        SizedBox(height: deviceSize.height * 0.007),
                        rowText(
                          AppLocalizations.of(context)!.delivery_fee,
                          '0',
                        ),
                        SizedBox(height: deviceSize.height * 0.007),
                        rowText(
                          AppLocalizations.of(context)!.total_fee,
                          widget.amount,
                        ),
                      ],
                    ),
                    CustomButton(
                      function: () async {
                        BlocProvider.of<ShoppingCartBloc>(context).add(
                          BuyEvent(
                            amount: widget.amount,
                            txRef: txRef,
                            currency: currency,
                            title: widget.title,
                            description: widget.description,
                          ),
                        );
                      },
                      text: AppLocalizations.of(context)!.checkout,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  rowText(String title, String amount) {
    Size deviceSize = MediaQuery.of(context).size;
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: deviceSize.width * 0.04,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        Text(
          '$amount ${AppLocalizations.of(context)!.br}',
          style: TextStyle(
            fontSize: deviceSize.width * 0.04,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
