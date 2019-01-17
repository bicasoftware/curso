import 'package:curso/container/CronogramaContainer.dart';
import 'package:flutter/material.dart';

class CronogramaItem extends StatelessWidget {
  
  final CronogramaContainer container;

  const CronogramaItem({Key key, this.container}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Container(
      color: container.corMateria ?? Theme.of(context).cardColor,
      margin: EdgeInsets.all(1),
      child: Center(
        child: Text(container.sigla),
      ),
    );
    
  }
}
