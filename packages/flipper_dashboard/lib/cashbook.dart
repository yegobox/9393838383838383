import 'package:flipper_dashboard/DateCoreWidget.dart';
import 'package:flipper_dashboard/keypad_view.dart';
import 'package:flipper_models/providers/date_range_provider.dart';
import 'package:flipper_models/view_models/mixins/riverpod_states.dart';
import 'package:flipper_services/constants.dart';
import 'package:flipper_ui/flipper_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked/stacked.dart';
import 'package:flipper_dashboard/BuildGaugeOrList.dart';
import 'package:flipper_models/realm_model_export.dart';
import 'widgets/dropdown.dart';

class Cashbook extends StatefulHookConsumerWidget {
  Cashbook({Key? key, required this.isBigScreen}) : super(key: key);
  final bool isBigScreen;

  @override
  CashbookState createState() => CashbookState();
}

class CashbookState extends ConsumerState<Cashbook> with DateCoreWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CoreViewModel>.reactive(
      fireOnViewModelReadyOnce: true,
      viewModelBuilder: () => CoreViewModel(),
      onViewModelReady: (model) async {},
      builder: (context, model, child) {
        return Scaffold(
          appBar: buildCustomAppBar(model),
          body: buildBody(context, model),
        );
      },
    );
  }

  PreferredSizeWidget buildCustomAppBar(CoreViewModel model) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [datePicker()],
      title: Text('Cash Book'),
    );
  }

  Widget buildBody(BuildContext context, CoreViewModel model) {
    return Column(
      children: [
        buildTransactionSection(context, model),
        SizedBox(height: 31),
      ],
    );
  }

  Widget buildDropdowns(CoreViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ReusableDropdown(
          options: model.transactionPeriodOptions,
          selectedOption: model.transactionPeriod,
          onChanged: (String? newPeriod) {
            model.transactionPeriod = newPeriod!;
          },
        ),
        ReusableDropdown(
          options: model.profitTypeOptions,
          selectedOption: model.profitType,
          onChanged: (String? newProfitType) {
            model.profitType = newProfitType!;
            model.notifyListeners();
          },
        ),
      ],
    );
  }

  Widget buildTransactionSection(BuildContext context, CoreViewModel model) {
    return Expanded(
      child: model.newTransactionPressed
          ? buildNewTransactionContent(context, model)
          : buildTransactionListContent(model),
    );
  }

  Widget buildTransactionListContent(CoreViewModel model) {
    final transactionData = ref.watch(transactionsStreamProvider);
    final dateRange = ref.watch(dateRangeProvider);
    final startDate = dateRange.startDate;
    final endDate = dateRange.endDate;
    return Column(
      children: [
        SizedBox(height: 5),
        Expanded(
          child: BuildGaugeOrList(
              startDate: startDate,
              endDate: endDate,
              context: context,
              model: model,
              widgetType: 'list',
              data: transactionData),
        ),
        buildTransactionButtons(model),
      ],
    );
  }

  Widget buildTransactionButtons(CoreViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FlipperButton(
          text: 'Cash In',
          color: Colors.green,
          onPressed: () {
            model.newTransactionPressed = true;
            model.newTransactionType = TransactionType.cashIn;
            model.notifyListeners();
          },
        ),
        FlipperButton(
          text: TransactionType.cashOut,
          color: Color(0xFFFF0331),
          onPressed: () {
            model.newTransactionPressed = true;
            model.newTransactionType = TransactionType.cashOut;
            model.notifyListeners();
          },
        ),
      ],
    );
  }

  Widget buildNewTransactionContent(BuildContext context, CoreViewModel model) {
    return Column(
      children: [
        Expanded(
          child: KeyPadView.cashBookMode(
              model: model,
              isBigScreen: widget.isBigScreen,
              accountingMode: true,
              transactionType: model.newTransactionType),
        ),
      ],
    );
  }
}
