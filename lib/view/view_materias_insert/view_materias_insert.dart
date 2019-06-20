import 'package:curso/container/materias.dart';
import 'package:curso/container/view_materias_insert_result.dart';
import 'package:curso/utils.dart/StringUtils.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/dialogs.dart';
import 'package:curso/widgets/materia_color_container.dart';
import 'package:flutter/material.dart';
import 'package:helper_tiles/helper_tiles.dart';

class ViewMateriasInsert extends StatefulWidget {
  final Materias materia;
  final int pos;

  const ViewMateriasInsert({Key key, this.materia, this.pos}) : super(key: key);

  @override
  _ViewMateriasInsertState createState() => _ViewMateriasInsertState();
}

class _ViewMateriasInsertState extends State<ViewMateriasInsert> {
  static final _formKey = GlobalKey<FormState>();
  int _cor;
  String _materia, _sigla;

  @override
  void initState() {
    super.initState();
    _cor = widget.materia.cor;
    _sigla = widget.materia.sigla;
    _materia = widget.materia.nome;
  }

  void _setSigla(String sigla) => setState(() => _sigla = sigla);
  void _setMateria(String materia) => setState(() => _materia = materia);
  void _setCor(int cor) => setState(() => _cor = cor);
  void _generateSigla(String nome) => _setSigla(StringUtils.geraSigla(nome));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(title: Text(Strings.materia)),
      floatingActionButton: FloatingActionButton(
        heroTag: ObjectKey(Strings.materias),
        child: Icon(Icons.save),
        onPressed: () {
          final state = _formKey.currentState;
          if (state.validate()) {
            state.save();
            widget.materia.cor = _cor;
            widget.materia.sigla = _sigla;
            widget.materia.nome = _materia;
            Navigator.of(context).pop(ViewMateriasInsertResult(widget.pos, widget.materia));
          }
        },
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  TextInputTile(
                    icon: Icons.library_books,
                    initialValue: _materia,
                    hint: Strings.materia,
                    label: Strings.materia,
                    sufix: _sigla,
                    onSaved: _setMateria,
                    validator: (nome) {
                      if (nome.isEmpty || nome.length < 3) return Errors.errNomeMateria;
                    },
                    onChanged: _generateSigla,
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            Card(
              child: DefaultListTile(
                icon: Icons.color_lens,
                leading: Text(Strings.corMateria),
                trailing: Hero(
                  tag: ObjectKey(widget.materia),
                  child: MateriaColorContainer(color: Color(_cor), size: 32),
                ),
                onTap: () async {
                  final cor = await Dialogs.showColorDialog(
                    context: context,
                    initialColor: _cor,
                  );

                  if (cor != null) _setCor(cor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
