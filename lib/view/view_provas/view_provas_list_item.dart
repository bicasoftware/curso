import 'package:curso/container/cronograma.dart';
import 'package:curso/widgets/circle.dart';
import 'package:curso/widgets/squared_card.dart';
import 'package:flutter/material.dart';
import 'package:curso/utils.dart/date_utils.dart';

class ProvasListItem extends StatelessWidget {
  final CronogramaDates dates;
  final Function(CronogramaDates) onTap;

  const ProvasListItem({
    Key key,
    @required this.dates,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SquaredCard(
      elevation: 2,
      child: InkWell(
        onTap: () => onTap(dates),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.date_range),
                  SizedBox(width: 20),
                  Text(
                    formatDate(dates.date),
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.only(left: 36),
                child: ListView.separated(
                  itemCount: dates.materias.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (c, i) => Divider(height: 0),
                  itemBuilder: (c, i) {
                    final m = dates.materias[i];
                    return MateriaAulaTile(nomeMateria: m.nome, cor: m.cor);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MateriaAulaTile extends StatelessWidget {
  final String nomeMateria;
  final int cor;

  const MateriaAulaTile({Key key, this.nomeMateria, this.cor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Circle(color: cor, size: 20),
          SizedBox(width: 16),
          Expanded(child: Text(nomeMateria))
        ],
      ),
    );
  }
}
