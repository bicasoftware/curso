import 'package:curso/utils.dart/AppBrightness.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_options/ViewOptionsResult.dart';
import 'package:flutter/material.dart';

class ViewOptions extends StatefulWidget {
  final AppBrightness brightness;
  final bool notify;

  const ViewOptions({
    this.notify,
    this.brightness,
    Key key,
  }) : super(key: key);

  @override
  _ViewOptionsState createState() => _ViewOptionsState();
}

class _ViewOptionsState extends State<ViewOptions> {
  String _selected;
  bool _notify;
  AppBrightness br;

  @override
  void initState() {
    super.initState();
    _selected = widget.brightness == AppBrightness.DARK ? Strings.escuro : Strings.claro;
    _notify = widget.notify;
  }

  void _onSelected(String selected) {
    setState(() {
      _selected = selected;
    });

    if (selected == Strings.escuro) {
      br = AppBrightness.DARK;
    } else if (selected == Strings.claro) {
      br = AppBrightness.LIGHT;
    }
  }

  void _onChanged(bool notify) {
    setState(() {
      _notify = notify;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().canvasColor,
      appBar: AppBar(
        title: Text(Strings.appName),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop(
              ViewOptionsResult(
                brightness: br,
                notify: _notify,
              ),
            );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text(Strings.tema),
              trailing: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selected,
                  onChanged: _onSelected,
                  items: Arrays.temas.map((String it) {
                    return DropdownMenuItem(
                      value: it,
                      child: Text(it),
                    );
                  }).toList(),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text(Strings.notificar),
              trailing: Switch(
                value: _notify,
                onChanged: _onChanged,
              ),
            )
          ],
        ),
      ),
    );
  }
}
