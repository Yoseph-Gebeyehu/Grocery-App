import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/api_request.dart';
import '../../../data/repositories/remote-request/repository.dart';

part 'shopping_cart_event.dart';
part 'shopping_cart_state.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  List<String> _txRef = [];
  ShoppingCartBloc() : super(ShoppingCartInitial()) {
    Repository repository = Repository();

    Future<void> loadTxRef() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _txRef = prefs.getStringList('txns') ?? [];
    }

    Future<void> saveTxRef() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('txns', _txRef);
    }

    on<BuyEvent>((event, emit) async {
      ApiRequest apiRequest = ApiRequest(
        email: "yosephgebeyehu73@gmail.com",
        amount: event.amount,
        firstName: "firstName",
        lastName: "lastName",
        phoneNumber: "0918292773",
        txRef: event.txRef,
        currency: event.currency,
        callbackUrl:
            "https://webhook.site/077164d6-29cb-40df-ba29-8a00e59a7e60",
        returnUrl: "https://your-return-url.com",
        customization: Customization(
          title: 'Title',
          description: 'Description',
        ),
      );

      var response = await repository.postData(apiRequest);
      // print(response.status);
      if (response.status == 200) {
        String? checkoutUrl = response.checkoutUrl;
        if (!await launchUrl(Uri.parse(checkoutUrl!))) {
          throw Exception('Could not launch ${Uri.parse(checkoutUrl)}');
        }
        await loadTxRef();
        _txRef.add(event.txRef);
        await saveTxRef();
        emit(BuySuccessState(checkoutUrl: response.checkoutUrl!));
      }
    });
  }
}
