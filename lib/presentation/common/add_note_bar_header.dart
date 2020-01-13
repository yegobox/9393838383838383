import 'package:flipper/theme.dart';
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget _action;
  final Widget _leftAction;
  final String _title;
  final String _subtitle;
  final String _actionTitle;
  final IconData _icon;
  final double _headerMultiplier;
  final double _positioningActionButton;

  const CommonAppBar({
    Widget action,
    Widget leftAction,
    @required String title,
    String subtitle,
    String actionTitle,
    IconData icon,
    double multi,
    double positioningActionButton,
    Key key,
  })  : _action = action,
        _leftAction = leftAction,
        _title = title,
        _subtitle = subtitle,
        _actionTitle = actionTitle,
        _icon = icon,
        _headerMultiplier = multi,
        _positioningActionButton = positioningActionButton,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 1.0),
            )
          ],
        ),
        child: Wrap(
          children: <Widget>[
            SafeArea(
              top: true,
              child: Visibility(
                visible: _leftAction == null,
                child: Container(
                  // Minimum size of a flat button
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 18,
                      ),
                      IconButton(
                          icon: Icon(
                            _icon ?? Icons.close,
                            size: 30,
                          ),
                          iconSize: 40,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      _title == null
                          ? Container()
                          : SizedBox(
                              child: FlatButton(
                                child: Text(
                                  _title,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: _subtitle == null
                                      ? AppTheme.appBarTitleTextStyle
                                      : AppTheme.appBarTitle2TextStyle,
                                ),
                              ),
                            ),
                      Container(
                        width: (_positioningActionButton == null
                            ? 0
                            : _positioningActionButton),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          height: 52,
                          child: Container(
                              color: Colors.blue,
                              child: FlatButton(
                                child: Text(
                                  _actionTitle ?? "Done",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                replacement: _leftAction ?? SizedBox.shrink(),
              ),
            ),
            Container(
              width: 200.0, // Minimum size of a flat button
              child: _action,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppTheme.appBarSize *
      (_headerMultiplier == null ? 0.8 : _headerMultiplier));
}
