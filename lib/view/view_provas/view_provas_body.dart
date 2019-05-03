import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/bloc/bloc_provas/bloc_provas.dart';
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
    final b = BlocProvider.of<BlocProvas>(context);

    return Scaffold(
      appBar: AppBar(title: Text(Strings.provas)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => b.addProva(),
      ),
      body: Column(
        children: <Widget>[
          ProvasList(),
        ],
      ),
    );
  }
}
