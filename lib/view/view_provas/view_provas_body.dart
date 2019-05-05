import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_provas/view_provas_list.dart';
import 'package:flutter/material.dart';

class ViewProvasBody extends StatefulWidget {
  @override
  _ViewProvasBodyState createState() => _ViewProvasBodyState();
}

class _ViewProvasBodyState extends State<ViewProvasBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("${Strings.provas}"),
            floating: true,
          ),
          ProvasList(),
        ],
      ),
    );
  }
}
