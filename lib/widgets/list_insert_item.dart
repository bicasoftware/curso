import 'package:flutter/material.dart';

class ListInsertItem extends StatelessWidget {

  final String title;
  final VoidCallback onAddTapped;

  const ListInsertItem({Key key, this.title, this.onAddTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text(
              title,
              style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: onAddTapped,
        ),
      ],
    );
  }
}
