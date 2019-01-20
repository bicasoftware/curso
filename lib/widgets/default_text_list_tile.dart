import 'package:flutter/material.dart';

class DefaultTextListTile extends StatefulWidget {
  final IconData icon;
  final String initialValue, label, hint;
  final Function(String) onSaved;
  final Function(String) validator;
  final VoidCallback onTap;

  const DefaultTextListTile({
    Key key,
    @required this.icon,
    @required this.onSaved,
    @required this.initialValue,
    @required this.label,
    @required this.hint,
    @required this.validator,
    this.onTap,
  }) : super(key: key);

  @override
  _DefaultTextListTileState createState() => _DefaultTextListTileState();
}

class _DefaultTextListTileState extends State<DefaultTextListTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      leading: Icon(widget.icon),
      title: TextFormField(
        initialValue: widget.initialValue,
        validator: widget.validator,
        onSaved: widget.onSaved,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
        ),
      ),
    );
  }
}
