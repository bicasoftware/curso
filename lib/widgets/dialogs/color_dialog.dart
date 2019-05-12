import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';


class ColorDialog extends StatelessWidget {
  final Function(int) onTap;

  const ColorDialog({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  Strings.selectCor,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 10 : 5,
            children: Arrays.materialColors.map((int cor) {
              return GestureDetector(
                onTap: () => onTap(cor),
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: CircleAvatar(backgroundColor: Color(cor)),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
