import 'package:curso/widgets/default_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:curso/utils.dart/date_utils.dart';

class DatePickerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final DateTime initialDate;
  final Function(DateTime) onDateSet;

  const DatePickerTile({
    Key key,
    @required this.title,
    @required this.onDateSet,
    @required this.initialDate,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultListTile(
      icon: icon ?? Icons.date_range,
      leading: Text(title),
      trailing: Text(formatDate(initialDate)),
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime(1970, 01, 01),
          lastDate: DateTime(2050, 01, 01),
        );

        if(selectedDate != null && selectedDate != initialDate){
          onDateSet(selectedDate);
        }
      },
    );
  }
}
