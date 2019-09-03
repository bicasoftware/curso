import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class ColorDialog extends StatelessWidget {
  const ColorDialog({@required this.onTap, Key key}) : super(key: key);

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  Strings.selectCor,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 10 : 5,
            children: Arrays.materialColors.map((int cor) {
              return GestureDetector(
                onTap: () => onTap(cor),
                child: Container(
                  padding: const EdgeInsets.all(4),
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
