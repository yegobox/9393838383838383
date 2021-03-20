import 'dart:convert';

import 'package:flipper/routes/router.gr.dart';
import 'package:flipper_services/keypad_service.dart';
import 'package:flipper_services/locator.dart';
import 'package:flipper_services/proxy.dart';
import 'package:flipper_services/shared_state_service.dart';
import 'package:stacked/stacked.dart';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class CompleteSaleViewModel extends ReactiveViewModel {
  final _sharedState = locator<SharedStateService>();
  final keypad = locator<KeyPadService>();

  String _phone;

  set phone(String phone) {
    _phone = phone;
  }

  void listenPaymentComplete() {
    ProxyService.pusher.pay.listen((completeCashCollection) {
      if (completeCashCollection != null) {
        ProxyService.nav.navigateTo(Routing.afterSaleView);
      }
    });
  }

  void collectCash() async {
    final String transactionNumber = Uuid().v1();
    await http.post('https://flipper.yegobox.com/pay',
        body: jsonEncode({
          'amount': 100,
          'message': ProxyService.sharedState.business.name.substring(0, 3) +
              '-' +
              transactionNumber.substring(0, 4),
          'phoneNumber': '+25' + _phone,
          'uid': ProxyService.sharedState.user.id
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }).then((response) {
      //TODO: get the object update it with transaction guid.
      print(response.body);
    });
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [_sharedState, keypad];
}
