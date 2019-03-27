import 'package:flutter/material.dart';

class SliderTile extends StatefulWidget {
  final double initialValue;
  final String title, mask;
  final Function(double) onChanged;
  final double min, max;
  final int divisions, fixedSize;

  const SliderTile({
    Key key,
    @required this.initialValue,
    @required this.title,
    @required this.onChanged,
    @required this.mask,
    @required this.min,
    @required this.max,
    @required this.divisions,
    this.fixedSize: 2,
  }) : super(key: key);

  @override
  SliderTileState createState() {
    return new SliderTileState();
  }
}

class SliderTileState extends State<SliderTile> {
  double value;

  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Slider(
                activeColor: Theme.of(context).accentColor,
                divisions: widget.divisions,
                min: widget.min,
                max: widget.max,
                value: value,
                onChanged: (double v) {
                  value = v;
                  widget.onChanged(v);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 16),
              child: Text(
                "${value.toStringAsFixed(widget.fixedSize)} ${widget.mask}",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        )
      ],
    );
  }
}
