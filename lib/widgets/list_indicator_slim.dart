import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class ListIndicatorSlim extends StatelessWidget {
  final String hint;
  final bool hideDivider;

  const ListIndicatorSlim({Key key, this.hint: Strings.appName, this.hideDivider: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.caption.copyWith(color: Theme.of(context).accentColor);

    return Container(
      height: 56,
      child: Center(
        child: Column(
          children: <Widget>[
            hideDivider ? Container() : Divider(),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  hint,
                  style: txtTheme,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
