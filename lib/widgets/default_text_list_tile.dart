import 'package:flutter/material.dart';

class DefaultTextListTile extends StatefulWidget {
  final IconData icon;
  final String initialValue, label, hint, sufix;
  final Function(String) onSaved;
  final Function(String) validator;
  final Function(String) onChanged;
  final VoidCallback onTap;

  const DefaultTextListTile({
    Key key,
    @required this.icon,
    @required this.onSaved,
    @required this.initialValue,
    @required this.label,
    @required this.hint,
    @required this.validator,
    this.onChanged,
    this.onTap,
    this.sufix,
  }) : super(key: key);

  @override
  _DefaultTextListTileState createState() => _DefaultTextListTileState();
}

class _DefaultTextListTileState extends State<DefaultTextListTile> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(() {
      widget.onChanged(_controller.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      leading: Column(
        children: [
          SizedBox(height: 24),
          Icon(
            widget.icon,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
      title: TextFormField(
        controller: widget.onChanged != null ? _controller : null,
        validator: widget.validator,
        onSaved: widget.onSaved,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          suffixText: widget.sufix ?? null,
        ),
      ),
    );
  }
}
