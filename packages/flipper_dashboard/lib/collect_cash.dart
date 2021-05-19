import 'dart:async';
import 'dart:convert';

import 'package:flipper_dashboard/customappbar.dart';
import 'package:flipper_dashboard/payable_view.dart';
import 'package:flipper_services/proxy.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flipper_models/view_models/business_home_viewmodel.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:flipper/routes.router.dart';

final socketUrl = 'https://apihub.yegobox.com/ws-message';

class CollectCashView extends StatefulWidget {
  CollectCashView({Key? key, required this.paymentType}) : super(key: key);
  final String paymentType;

  @override
  State<CollectCashView> createState() => _CollectCashViewState();
}

class _CollectCashViewState extends State<CollectCashView> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  final _formKey = GlobalKey<FormState>();
  String message = '';
  TextEditingController phoneController = TextEditingController();
  StreamController<String> streamController =
      StreamController<String>.broadcast();
  late StreamSubscription<String> subscription;
  StompClient? stompClient;
  void onConnect(StompFrame frame) {
    stompClient?.subscribe(
        destination: '/topic/message',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            Map<String, dynamic> result = json.decode(frame.body!);
            streamController.add(result['message']);
          }
        });
  }

  @override
  void initState() {
    super.initState();

    if (stompClient == null) {
      stompClient = StompClient(
          config: StompConfig.SockJS(
        url: socketUrl,
        onConnect: onConnect,
        onWebSocketError: (dynamic error) => print(error.toString()),
      ));

      stompClient?.activate();
    }
  }

  @override
  void dispose() {
    if (stompClient != null) {
      stompClient?.deactivate();
    }
    // streamController.dispose();
    subscription?.cancel(); //unsubscribe from stream
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessHomeViewModel>.reactive(
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              appBar: CustomAppBar(
                onPop: () {
                  ProxyService.nav.back();
                },
                title: '',
                icon: Icons.close,
                multi: 3,
                bottomSpacer: 52,
              ),
              body: Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            widget.paymentType == 'spenn'
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 18),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(color: Colors.black),
                                        // onChanged: (String phone) {},
                                        controller: phoneController,
                                        decoration: InputDecoration(
                                          hintText: 'Payer phone number',
                                          fillColor: Theme.of(context)
                                              .copyWith(
                                                  canvasColor: Colors.white)
                                              .canvasColor,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: HexColor('#D0D7E3')),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18, right: 18),
                              child: Container(
                                width: double.infinity,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Cash Received';
                                    }
                                    return null;
                                  },
                                  onChanged: (String cash) {},
                                  decoration: InputDecoration(
                                    hintText: 'Cash Received',
                                    fillColor: Theme.of(context)
                                        .copyWith(canvasColor: Colors.white)
                                        .canvasColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: HexColor('#D0D7E3'),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            RoundedLoadingButton(
                              borderRadius: 20.0,
                              controller: _btnController,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (widget.paymentType == 'spenn') {
                                    await model.collectSPENNPayment(
                                        phoneNumber: phoneController.text);
                                  } else {
                                    model.collectCashPayment();
                                    _btnController.success();
                                    ProxyService.nav
                                        .navigateTo(Routes.afterSale);
                                  }
                                } else {
                                  _btnController.stop();
                                }
                              },
                              child: const Text(
                                'Tender',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        onModelReady: (model) {
          Stream<String> stream = streamController.stream;
          subscription = stream.listen((event) {
            String userId = ProxyService.box.read(key: 'userId');
            if (event == userId) {
              _btnController.success();
              ProxyService.nav.navigateTo(Routes.afterSale);
            } else {
              _btnController.error();
            }
          });
        },
        viewModelBuilder: () => BusinessHomeViewModel());
  }
}
