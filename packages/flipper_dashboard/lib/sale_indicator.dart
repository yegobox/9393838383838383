import 'package:flipper/localization.dart';
import 'package:flipper_dashboard/popup_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flipper_models/business.dart';
import 'package:flipper_routing/routes.router.dart';
import 'package:flipper_services/proxy.dart';
import 'package:flipper_services/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_product_buttons.dart';
import 'hero_dialog_route.dart';

final isAndroid = UniversalPlatform.isAndroid;
final isIos = UniversalPlatform.isIOS;

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
    return ListTile(
      trailing: SizedBox(
        width: 120,
        child: Row(
          children: [
            if (isAndroid && isIos)
              GestureDetector(
                onTap: () {
                  /// in Flipper business, business will be able to setup geo fence
                  /// when users are near they will receive notification of business advertizing their service.
                  /// if a pro user you can call a business from directly from the map marker long press.
                  ProxyService.nav.navigateTo(Routes.map);
                },
                child: Icon(Ionicons.map),
              ),
            Spacer(),
            if (isAndroid || isIos)
              GestureDetector(
                onTap: () {
                  goToFlipperChat();
                },
                child: Icon(Ionicons.chatbox_sharp),
              ),
            Spacer(),
            GestureDetector(
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
              child: Icon(CupertinoIcons.add),
            ),
          ],
        ),
      ),
      // leading: Icon(Ionicons.chatbox),
      title: TextButton(
        style: TextButton.styleFrom(primary: Colors.black),
        onPressed: () {
          onClick();
        },
        child: counts == 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Sale',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 16,
                          color: const Color(0xff363f47),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
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
    );
  }

  void goToFlipperChat() async {
    ProxyService.box.write(key: pageKey, value: 'social');
    //first register the user in firestore db
    //get the current firebase user
    User? user = await ProxyService.auth.getCurrentUserId();
    int businessId = ProxyService.box.read(key: 'businessId');
    Business business = await ProxyService.api.getBusinessById(id: businessId);
    //patch a business to add a chat uid

    ProxyService.firestore.createUserInFirestore(user: {
      'firstName': business.name,
      'lastName': '',
      'email': '  ',
      'uid': user!.uid,
      'imageUrl': 'https://dummyimage.com/300/09f.png/fff'
      // 'imageUrl':
      // "https://avatars.dicebear.com/api/micah/$name.svg",
    });
    ProxyService.nav.navigateTo(Routes.chat);
  }
}
