import 'package:flipper_routing/routes.logger.dart';
import 'package:flipper_routing/routes.router.dart';
import 'package:flipper_services/proxy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:number_display/number_display.dart';
import 'package:stacked/stacked.dart';
import 'package:flipper_models/isar_models.dart';
import 'package:flipper_ui/flipper_ui.dart';
import 'customappbar.dart';
import 'package:google_ui/google_ui.dart';
import 'package:go_router/go_router.dart';

class AfterSale extends StatefulWidget {
  const AfterSale(
      {Key? key, required this.totalOrderAmount, required this.order})
      : super(key: key);
  final double totalOrderAmount;
  final Order order;

  @override
  _AfterSaleState createState() => _AfterSaleState();
}

class _AfterSaleState extends State<AfterSale> {
  final display = createDisplay(
    length: 8,
    decimal: 0,
  );
  final log = getLogger('AfterSale');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessHomeViewModel>.reactive(
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              appBar: CustomAppBar(
                useTransparentButton: false,
                onPop: () {
                  model.currentOrder();
                  GoRouter.of(context).push(Routes.home);
                },
                title: '',
                closeButton: CLOSEBUTTON.BUTTON,
                disableButton: false,
                showActionButton: true,
                onPressedCallback: () async {
                  await model.getOrderById();
                  GoRouter.of(context).push(
                      Routes.customers + '/' + model.kOrder!.id.toString());
                },
                leftActionButtonName:
                    model.kOrder != null && model.kOrder!.customerId != null
                        ? 'Remove Customer'
                        : 'New Sale',
                rightActionButtonName: 'Add Customer',
                // icon: Icons.close,
                multi: 3,
                bottomSpacer: 52,
              ),
              body: SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          Text(
                            'FRw' +
                                display(model.keypad.cashReceived -
                                        widget.totalOrderAmount)
                                    .toString() +
                                ' Change',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Out of FRw ' +
                                model.keypad.cashReceived.toStringAsFixed(0),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 200,
                      right: 0,
                      left: 0,
                      child: StreamBuilder<Customer?>(
                          stream: ProxyService.isarApi.getCustomerByOrderId(
                              id: model.kOrder == null ? 0 : model.kOrder!.id),
                          builder: (context, snapshot) {
                            return snapshot.data == null
                                ? Column(
                                    children: [
                                      const Text(
                                          'How would you like your receipt?'),
                                      const SizedBox(height: 10),
                                      ProxyService.remoteConfig
                                              .isReceiptOnEmail()
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18, right: 18),
                                              child: SizedBox(
                                                height: 50,
                                                width: double.infinity,
                                                child: GOutlinedButton(
                                                  'Email',
                                                  onPressed: () {},
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18, right: 18),
                                              child: SizedBox(
                                                height: 50,
                                                width: double.infinity,
                                                child: GOutlinedButton(
                                                  'Print Now',
                                                  onPressed: () async {
                                                    List<OrderItem> items =
                                                        await ProxyService
                                                            .isarApi
                                                            .orderItems(
                                                                orderId: widget
                                                                    .order.id);
                                                    ProxyService.tax
                                                        .createReceipt(
                                                            order: widget.order,
                                                            items: items);
                                                    // Print print = Print();
                                                    // print.feed(items);
                                                    // print.print(
                                                    //   grandTotal: 500,
                                                    //   currencySymbol: "RW",
                                                    //   info: "Richie",
                                                    //   taxId: "342",
                                                    //   receiverName: "Richie",
                                                    //   receiverMail:
                                                    //       "info@yegobox.com",
                                                    //   receiverPhone:
                                                    //       "+250788854800",
                                                    //   email: "info@yegobox.com",
                                                    // );
                                                  },
                                                ),
                                              ),
                                            ),
                                      const SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18, right: 18),
                                        child: SizedBox(
                                          height: 50,
                                          width: double.infinity,
                                          child: GOutlinedButton(
                                            'No Receipt',
                                            onPressed: () {
                                              // refresh orders
                                              model.currentOrder();
                                              GoRouter.of(context)
                                                  .push(Routes.home);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Text(
                                          'How would you like your receipt?'),
                                      const SizedBox(height: 10),
                                      ProxyService.remoteConfig
                                                  .isReceiptOnEmail() ||
                                              kDebugMode
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18, right: 18),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: BoxButton.outline(
                                                  title: 'Email(' +
                                                      snapshot.data!.email +
                                                      ')',
                                                  onTap: () {},
                                                ),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                      const SizedBox(height: 2),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18, right: 18),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: BoxButton.outline(
                                            title: 'No Receipt',
                                            onTap: () {
                                              // refresh orders
                                              model.currentOrder();
                                              GoRouter.of(context)
                                                  .pushNamed(Routes.home);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                          }),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.globe),
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: null,
                            ),
                            Text(
                              'English',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        },
        onModelReady: (model) {
          model.getOrderById();
        },
        viewModelBuilder: () => BusinessHomeViewModel());
  }
}
