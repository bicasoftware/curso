import 'package:flutter/material.dart';

class ListInsertHeader extends StatelessWidget {
  final String title;
  final VoidCallback onAddTapped;
  final Icon trailingIcon;

  const ListInsertHeader({
    Key key,
    @required this.title,
    this.onAddTapped,
    this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
            onAddTapped != null
                ? IconButton(
                    icon: trailingIcon ?? Icon(Icons.add),
                    onPressed: onAddTapped,
                  )
                : Container(),
            SizedBox(width: 8)
          ],
        ),
        Divider(height: 0, color: Colors.black26),
      ],
    );
  }
}
