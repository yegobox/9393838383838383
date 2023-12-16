// ignore_for_file: unused_result
import 'package:flipper_dashboard/ProductList.dart';
import 'package:flipper_dashboard/functions.dart';
import 'package:flipper_services/constants.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flipper_models/states/selectedSupplierProvider.dart';
import 'package:flipper_models/states/supplierListProvider.dart';

class Orders extends StatefulHookConsumerWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  OrdersState createState() => OrdersState();
}

/// note: when creating a transaction, it is created as my transaction
/// when it is received on other hand it will be cloned or copied so that it appear on both end

class OrdersState extends ConsumerState<Orders> {
  @override
  Widget build(BuildContext context) {
    final searchController = ref.read(searchQueryControllerProvider);
    final suppliers = ref.watch(supplierListProvider);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        onWillPop(
          context: context,
          navigationPurpose: NavigationPurpose.back,
          message: 'Done shopping?',
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Supplier'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).state = value;
                  ref.refresh(supplierListProvider);
                },
                decoration: const InputDecoration(
                  labelText: 'Search Supplier',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: suppliers.when(
                data: (suppliers) {
                  return ListView.builder(
                    itemCount: suppliers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(suppliers[index].name),
                        onTap: () {
                          ref
                              .read(selectedSupplierProvider.notifier)
                              .setSupplier(supplier: suppliers[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductListScreen(),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: Text("No supplier choosen")),
                error: (error, stack) => Text('Error: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
