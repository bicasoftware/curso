import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_parciais/parcial_status.dart';
import 'package:flutter/material.dart';
import 'package:curso/utils.dart/double_utils.dart';


class ParcialPresencaProgress extends StatefulWidget {
  final double notaAprov, media;
  final ParcialStatus status;

  const ParcialPresencaProgress({
    Key key,
    @required this.notaAprov,
    @required this.media,
    @required this.status,
  }) : super(key: key);

  @override
  _ParcialPresencaProgressState createState() => _ParcialPresencaProgressState();
}

class _ParcialPresencaProgressState extends State<ParcialPresencaProgress>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation colorAnim;
  Animation notaAnim;
  Animation mediaAnim;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 400), vsync: this)
      ..addListener(() {
        setState(() {});
      });
    colorAnim = ColorTween(begin: Colors.red, end: widget.status.cor).animate(controller);
    notaAnim = Tween<double>(begin: 0.0, end: widget.notaAprov).animate(controller);
    mediaAnim = Tween<double>(begin: 0.0, end: widget.media).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                formatNota(mediaAnim.value)
              ),
            ],
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.black12,
            value: notaAnim.value / 10,
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
              Text(
                formatNota(notaAnim.value)
              ),
            ],
          ),          
          LinearProgressIndicator(
            valueColor: colorAnim,
            backgroundColor: Colors.black12,
            value: widget.media / 10,
          ),
        ],
      ),
    );
  }
}
