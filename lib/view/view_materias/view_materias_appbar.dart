import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class ViewMateriasAppBar extends StatelessWidget {
  const ViewMateriasAppBar({
    Key key,
    @required this.onClosePressed,
    @required this.onAddPressed,
  }) : super(key: key);

  final VoidCallback onClosePressed;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(Strings.materias),
      floating: true,
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: onClosePressed,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: onAddPressed,
        )
      ],
    );
  }
}
