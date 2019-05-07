import 'package:curso/widgets/default_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:curso/utils.dart/date_utils.dart';

class TimePickerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeSet;

  const TimePickerTile({
    Key key,
    @required this.title,
    @required this.onTimeSet,
    @required this.initialTime,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultListTile(
      icon: icon ?? Icons.date_range,
      leading: Text(title),
      trailing: Text(formatTimeOfDay(initialTime)),
      onTap: () async {
        final newTime = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );

        if (newTime != null && newTime != initialTime) {
          onTimeSet(newTime);
        }
      },
    );
  }
}
