import 'package:curso/container/materias.dart';
import 'package:curso/utils.dart/StringUtils.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_materias_insert/view_materias_insert_result.dart';
import 'package:curso/widgets/default_list_tile.dart';
import 'package:curso/widgets/default_text_list_tile.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text(Strings.materia),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final state = _formKey.currentState;
              if (state.validate()) {
                state.save();
                final m = widget.materia.copyWith(
                  cor: _cor,
                  sigla: _sigla,
                  nome: _materia,
                );
                Navigator.of(context).pop(ViewMateriasInsertResult(widget.pos, m));
              }
            },
          )
        ],
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DefaultTextListTile(
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
              DefaultListTile(
                icon: Icons.color_lens,
                leading: Text(Strings.corMateria),
                trailing: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    onChanged: _setCor,
                    value: _cor,
                    items: _colorList,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> get _colorList {
    return Arrays.materialColors.map((color) {
      return DropdownMenuItem<int>(
        child: CircleAvatar(
          backgroundColor: Color(color.value),
          maxRadius: 10,
        ),
        value: color.value,
      );
    }).toList();
  }
}
