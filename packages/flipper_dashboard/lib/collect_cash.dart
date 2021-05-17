import 'package:flipper_dashboard/customappbar.dart';
import 'package:flipper_dashboard/payable_view.dart';
import 'package:flipper_services/proxy.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flipper_models/view_models/business_home_viewmodel.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CollectCashView extends StatelessWidget {
  CollectCashView({Key? key, required this.paymentType}) : super(key: key);
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final String paymentType;
  final _formKey = GlobalKey<FormState>();

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
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(height: 40),
                            paymentType == 'spenn'
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
                                        // validator: (){},
                                        onChanged: (String phone) {
                                          // model.phone = phone;
                                        },
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
                                  onChanged: (String cash) {
                                    // model.keypad.setCashReceived.value =
                                    //     double.parse(cash);
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Cash Received',
                                    fillColor: Theme.of(context)
                                        .copyWith(canvasColor: Colors.white)
                                        .canvasColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor('#D0D7E3')),
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (paymentType == 'spenn') {
                                    // model.collectSPENNPayment();
                                  } else {
                                    // model.collectCashPayment();
                                    // ProxyService.nav
                                    //     .navigateTo(Routing.afterSaleView);
                                  }
                                } else {
                                  _btnController.stop();
                                }
                              },
                              child: const Text('Tender',
                                  style: TextStyle(color: Colors.white)),
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
        onModelReady: (BusinessHomeViewModel model) {
          // model.completedSale.value = null;
          // model.completedSale.listen((v) {
          //   try {
          //     if (v != null && v == true) {
          //       _btnController.success();
          //     } else if (v != null && v == false) {
          //       _btnController.error();
          //     }
          //   } on Exception {
          //     rethrow;
          //   }
          // });
          // ProxyService.pusher.subs();
          // model.listenPaymentComplete();
        },
        viewModelBuilder: () => BusinessHomeViewModel());
  }
}
