import 'package:flutter/material.dart';

class CasperAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget trailing;
  final List<Widget> actions;

  const CasperAppBar({
    Key key,
    this.title,
    this.trailing,
    this.actions,
  }) : super(key: key);

  static const double margin = 10;

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      color: Theme.of(context).textTheme.title.color,
      fontSize: 18,
    );

    return Container(
      color: Theme.of(context).primaryColor,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.all(4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        child: Center(
          child: Row(
            children: [
              SizedBox(width: margin),
              Expanded(
                flex: 1,
                child: Text(
                  title,
                  style: titleStyle,
                ),
              ),
              actions == null ? Container() : Row(children: actions),
              trailing ?? Container,
              SizedBox(width: margin),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
