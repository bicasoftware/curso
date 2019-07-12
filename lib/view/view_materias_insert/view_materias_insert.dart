import 'package:curso/container/materias.dart';
import 'package:curso/container/view_materias_insert_result.dart';
import 'package:curso/utils.dart/StringUtils.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
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
  void _generateSigla(String nome) => _setSigla(StringUtils.geraSigla(nome));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(Strings.materia),
              floating: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                TextInputTile(
                  icon: Icons.library_books,
                  initialValue: _materia,
                  hint: Strings.materia,
                  label: Strings.materia,
                  sufix: _sigla,
                  onSaved: _setMateria,
                  validator: (nome) {
                    if (nome.isEmpty || nome.length < 3) {
                      return Errors.errNomeMateria;
                    } else {
                      return null;
                    }
                  },
                  onChanged: _generateSigla,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text(
                    Strings.corMateria,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                ),
                MaterialColorPicker(
                  selectedColor: Color(_cor),
                  circleSize: 36,
                  allowShades: true,
                  onColorChange: (Color c) => setState(() => _cor = c.value),
                ),
              ]),
            )
          ],
        ),
      ),
      /* appBar: AppBar(title: Text(Strings.materia)), */
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
      /* body: Form(
        key: _formKey,
        child: ListView(
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
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Text(
                Strings.corMateria,
                style: Theme.of(context)
                    .textTheme
                    .subtitle
                    .copyWith(color: Theme.of(context).accentColor),
              ),
            ),
            MaterialColorPicker(
              selectedColor: Color(_cor),
              circleSize: 36,
              allowShades: true,
              onColorChange: (Color c) => setState(() => _cor = c.value),
            ),
          ],
        ),
      ), */
    );
  }
}
