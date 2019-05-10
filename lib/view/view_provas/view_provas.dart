import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_provas/bloc_provas.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/view/view_provas/view_provas_body.dart';
import 'package:flutter/material.dart';

class ViewProvas extends StatefulWidget {
  final Periodos periodo;

  const ViewProvas({
    @required this.periodo,
    Key key,
  }) : super(key: key);

  @override
  _ViewProvasState createState() => _ViewProvasState();
}

class _ViewProvasState extends State<ViewProvas> {
  BlocProvas bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvas(widget.periodo);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocProvas>(
      creator: (_, __) => bloc,
      child: ViewProvasBody(),
    );
  }
}
