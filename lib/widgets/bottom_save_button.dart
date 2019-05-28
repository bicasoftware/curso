import 'package:flutter/material.dart';

class BottomSaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const BottomSaveButton({Key key, @required this.onPressed, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          width: double.infinity,
          child: MaterialButton(
            colorBrightness: Brightness.dark,
            child: Text(title),
            color: Theme.of(context).primaryColor,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
