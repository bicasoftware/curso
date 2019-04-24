import 'package:flutter/material.dart';

class HappyPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Icon(Icons.tag_faces, color: Theme.of(context).primaryColorLight),
      ),
    );
  }
}
