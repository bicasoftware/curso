import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_parciais/parcial_status.dart';
import 'package:flutter/material.dart';
import 'package:curso/utils.dart/double_utils.dart';

class ParcialNotaProgress extends StatefulWidget {
  final double notaAprov, notaAtual;
  final ParciaisStatus status;

  const ParcialNotaProgress({
    Key key,
    @required this.notaAprov,
    @required this.notaAtual,
    @required this.status,
  }) : super(key: key);

  @override
  _ParcialNotaProgressState createState() => _ParcialNotaProgressState();
}

class _ParcialNotaProgressState extends State<ParcialNotaProgress>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController controller;
  Animation colorAnim;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 400), vsync: this)
      ..addListener(() => setState(() {}));
    colorAnim = ColorTween(begin: Colors.red, end: widget.status.cor).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                Strings.notaAprovacao,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              Spacer(),
              Text(formatNota(widget.notaAprov)),
            ],
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.black12,
            value: widget.notaAprov / 10,
          ),
          SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                Strings.notaAtual,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              Spacer(),
              Text(formatNota(widget.notaAtual)),
            ],
          ),
          LinearProgressIndicator(
            valueColor: colorAnim,
            backgroundColor: Colors.black12,
            value: (widget.notaAtual ?? 0.0) / 10,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
