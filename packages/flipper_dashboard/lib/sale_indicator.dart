import 'package:flipper/localization.dart';
import 'package:flipper_dashboard/popup_modal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:ionicons/ionicons.dart';

import 'add_product_buttons.dart';
import 'hero_dialog_route.dart';

final isAndroid = UniversalPlatform.isAndroid;

class SaleIndicator extends StatelessWidget {
  const SaleIndicator(
      {Key? key,
      this.counts = 0,
      required this.onClick,
      required this.onLogout})
      : super(key: key);

  final int counts;
  final Function onClick;
  final Function onLogout;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context)
          .copyWith(canvasColor: Colors.transparent)
          .canvasColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: ListTile(
          trailing: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                HeroDialogRoute(
                  builder: (context) {
                    return const OptionModal(
                      child: AddProductButtons(),
                    );
                  },
                ),
              );
            },
            child: Icon(Ionicons.add),
          ),
          title: Expanded(
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.black),
              onPressed: () {
                onClick();
              },
              child: counts == 0
                  ? Text(
                      'No Sale',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 16,
                            color: const Color(0xff363f47),
                            fontWeight: FontWeight.w600,
                          ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Localization.of(context)!.currentSale),
                        Stack(
                          alignment: isAndroid
                              ? AlignmentDirectional.bottomCenter
                              : AlignmentDirectional.center,
                          children: [
                            Text(counts.toString()),
                            const IconButton(
                              icon: FaIcon(FontAwesomeIcons.clone),
                              onPressed: null,
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
