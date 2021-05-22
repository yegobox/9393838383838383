// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flipper/rally/charts/pie_chart.dart';
import 'package:flipper/rally/data.dart';
import 'package:flipper/rally/finance.dart';
import 'package:flipper/rally/tabs/sidebar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/flipper_localizations.dart';

/// A page that shows a summary of bills.
class BillsView extends StatefulWidget {
  @override
  _BillsViewState createState() => _BillsViewState();
}

class _BillsViewState extends State<BillsView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final items = DummyDataService.getBillDataList(context);
    final dueTotal = sumBillDataPrimaryAmount(items);
    final paidTotal = sumBillDataPaidAmount(items);
    final detailItems = DummyDataService.getBillDetailList(
      context,
      dueTotal: dueTotal,
      paidTotal: paidTotal,
    );

    return TabWithSidebar(
      restorationId: 'bills_view',
      mainView: FinancialEntityView(
        // heroLabel: FlipperLocalizations.of(context).rallyBillsDue,
        heroLabel: 'Due',
        heroAmount: dueTotal,
        segments: buildSegmentsFromBillItems(items),
        wholeAmount: dueTotal,
        financialEntityCards: buildBillDataListViews(items, context),
      ),
      sidebarItems: [
        for (UserDetailData item in detailItems)
          SidebarItem(title: item.title, value: item.value)
      ],
    );
  }
}
