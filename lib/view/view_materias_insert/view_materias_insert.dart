import 'package:curso/container/view_materias_insert_result.dart';
import 'package:curso/custom_colors.dart';
import 'package:curso/models/materias.dart';
import 'package:curso/utils.dart/StringUtils.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/materia_color_container.dart';
import 'package:flutter/material.dart';

class ViewMateriasInsert extends StatefulWidget {
  const ViewMateriasInsert({Key key, this.materia, this.pos}) : super(key: key);

  final Materias materia;
  final int pos;

  @override
  _ViewMateriasInsertState createState() => _ViewMateriasInsertState();
}

class _ViewMateriasInsertState extends State<ViewMateriasInsert> {
  static final _formKey = GlobalKey<FormState>();
  int _cor;
  String _materia, _sigla;
  FocusNode focus;

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _cor = widget.materia.cor;
    _sigla = widget.materia.sigla;
    _materia = widget.materia.nome;

    ///Aguardar alguns milisegundos antes de colocar o foco, melhora a visibilidade das animações
    focus = FocusNode();
    Future.delayed(const Duration(milliseconds: 600), () {
      focus.requestFocus();
    });
  }

  void _setSigla(String sigla) => setState(() => _sigla = sigla);
  void _setMateria(String materia) => setState(() => _materia = materia);
  void _generateSigla(String nome) => _setSigla(StringUtils.geraSigla(nome));

  void doSave() {
    final state = _formKey.currentState;
    if (state.validate()) {
      state.save();
      widget.materia.cor = _cor;
      widget.materia.sigla = _sigla;
      widget.materia.nome = _materia;
      Navigator.of(context).pop(ViewMateriasInsertResult(widget.pos, widget.materia));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.materia),
        actions: <Widget>[
          FlatButton(
            colorBrightness: Brightness.dark,
            child: const Text(Strings.salvar),
            onPressed: doSave,
          )
        ],
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  focusNode: focus,
                  initialValue: _materia,
                  decoration: InputDecoration(
                    hintText: "Matemática",
                    labelText: Strings.nomeMateria,
                    suffixText: _sigla,
                  ),
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
                const SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.palette),
                  title: const Text(Strings.corMateria),
                  trailing: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      onChanged: (int c) => setState(() => _cor = c),
                      value: _cor,
                      items: [
                        for (Color c in DropdownColors)
                          DropdownMenuItem<int>(
                            value: c.value,
                            child: MateriaColorContainer(color: c),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      /* appBar: AppBar(title: Text(Strings.materia)), */
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
