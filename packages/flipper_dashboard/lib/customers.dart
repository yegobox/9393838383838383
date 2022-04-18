import 'package:flipper_routing/routes.logger.dart';
import 'package:flutter/material.dart';
import 'package:flipper_services/proxy.dart';
import 'add_customer.dart';
import 'customappbar.dart';
import 'package:flipper_models/isar_models.dart';
import 'package:stacked/stacked.dart';
import 'package:flipper_ui/flipper_ui.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_text_drawable/flutter_text_drawable.dart';
import 'package:go_router/go_router.dart';

class Customers extends StatelessWidget {
  Customers({Key? key, required this.orderId}) : super(key: key);
  final int orderId;
  final TextEditingController _seach = TextEditingController();
  final log = getLogger('Customers');
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessHomeViewModel>.reactive(
        viewModelBuilder: () => BusinessHomeViewModel(),
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              appBar: CustomAppBar(
                onPop: () {
                  GoRouter.of(context).pop();
                },
                title: 'Add Customer to Sale',
                showActionButton: false,
                onPressedCallback: () async {
                  GoRouter.of(context).pop();
                },
                icon: Icons.close,
                multi: 3,
                bottomSpacer: 50,
              ),
              body: Column(
                children: [
                  verticalSpaceSmall,
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: BoxInputField(
                      controller: _seach,
                      trailing: const Icon(Icons.clear_outlined),
                      placeholder: 'Search for a customer',
                      onChanged: (value) {
                        model.setSearch(value);
                      },
                    ),
                  ),
                  verticalSpaceSmall,
                  StreamBuilder<Customer?>(
                      stream: ProxyService.isarApi.getCustomer(
                        key: model.searchCustomerkey,
                      ),
                      builder: (context, snapshot) {
                        return snapshot.data != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 18, right: 18),
                                child: Slidable(
                                    child: GestureDetector(
                                      onTap: () async {
                                        log.i(snapshot.data!.id);
                                        await model.assignToSale(
                                          customerId: snapshot.data!.id,
                                          orderId: orderId,
                                        );

                                        /// this update a model when the Order has the customerId in it then will show related data accordingly!
                                        model.getOrderById();
                                        GoRouter.of(context).pop();
                                      },
                                      onLongPress: () {},
                                      child: Column(children: <Widget>[
                                        ListTile(
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  0, 0, 10, 0),
                                          // leading: callImageBox(context, product),
                                          leading: SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              width: 58,
                                              child: TextDrawable(
                                                backgroundColor: Colors.red,
                                                text: snapshot.data!.name,
                                                isTappable: true,
                                                onTap: null,
                                                boxShape: BoxShape.rectangle,
                                              )),
                                          title: Text(
                                            snapshot.data!.phone,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          height: 0.5,
                                          color: Colors.black26,
                                        ),
                                      ]),
                                    ),
                                    endActionPane: ActionPane(
                                      // A motion is a widget used to control how the pane animates.
                                      motion: const ScrollMotion(),

                                      // A pane can dismiss the Slidable.
                                      dismissible:
                                          DismissiblePane(onDismissed: () {}),

                                      // All actions are defined in the children parameter.
                                      children: const [
                                        // A SlidableAction can have an icon and/or a label.
                                        SlidableAction(
                                          onPressed: null,
                                          backgroundColor: Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ],
                                    )),
                              )
                            : const SizedBox.shrink();
                      }),
                  verticalSpaceSmall,
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18.0, right: 18.0, top: 0),
                    child: BoxButton(
                      title: model.searchCustomerkey.isNotEmpty
                          ? 'Create Customer ' '"' +
                              model.searchCustomerkey +
                              '"'
                          : 'Add Customer',
                      onTap: () {
                        _showModalBottomSheet(
                            context, orderId, model.searchCustomerkey);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _showModalBottomSheet(BuildContext context, int orderId, searchedKey) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AddCustomer(
            orderId: orderId,
            searchedKey: searchedKey,
          ),
        );
      },
    );
  }
}
