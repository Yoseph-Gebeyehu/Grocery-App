import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/api_request.dart';
import '../../../data/repositories/remote-request/repository.dart';

part 'shopping_cart_event.dart';
part 'shopping_cart_state.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  ShoppingCartBloc() : super(ShoppingCartInitial()) {
    Repository repository = Repository();

    on<BuyEvent>((event, emit) async {
      ApiRequest apiRequest = ApiRequest(
        email: "yosephgebeyehu73@gmail.com",
        amount: event.amount,
        firstName: "firstName",
        lastName: "lastName",
        phoneNumber: "0918292773",
        txRef: event.txRef,
        currency: event.currency,
        callbackUrl: "https://your-callback-url.com",
        returnUrl: "https://your-return-url.com",
        customization: Customization(
          title: "title",
          description: "description",
        ),
      );

      var response = await repository.postData(apiRequest);

      if (response.status == 200) {
        String? checkoutUrl = response.checkoutUrl;
        if (!await launchUrl(Uri.parse(checkoutUrl!))) {
          throw Exception('Could not launch ${Uri.parse(checkoutUrl)}');
        }
      }

      emit(BuySuccessState());
    });
  }
}
