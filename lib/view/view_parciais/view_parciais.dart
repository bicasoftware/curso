import 'package:curso/view/view_parciais/widgets/parcial_list_item.dart';
import 'package:flutter/material.dart';

class ViewInfo extends StatelessWidget {
  const ViewInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ParcialListItem(),
    );
  }
}
