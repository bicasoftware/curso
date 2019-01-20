import 'package:flutter/material.dart';

class DefaultListTile extends StatelessWidget {
  final IconData icon;
  final Widget leading, trailing;
  final VoidCallback onTap;

  const DefaultListTile({
    Key key,
    @required this.icon,
    @required this.leading,
    @required this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Theme.of(context).accentColor,
      ),
      title: leading,
      trailing: trailing,
    );
  }
}
