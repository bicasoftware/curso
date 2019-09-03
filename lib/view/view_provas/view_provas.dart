import 'package:curso/container/periodos.dart';
import 'package:curso/view/view_provas/bloc/bloc_provas.dart';
import 'package:curso/view/view_provas/view_provas_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewProvas extends StatefulWidget {
  const ViewProvas({
    @required this.periodo,
    Key key,
  }) : super(key: key);

  final Periodos periodo;

  @override
  _ViewProvasState createState() => _ViewProvasState();
}

class _ViewProvasState extends State<ViewProvas> {
  @override
  Widget build(BuildContext context) {
    return Provider<BlocProvas>(
      builder: (_) => BlocProvas(widget.periodo),
      dispose: (_, BlocProvas b) => b.dispose(),
      child: ViewProvasBody(),
    );
  }
}
