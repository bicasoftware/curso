import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/widgets/placeholders/stream_builder_child.dart';
import 'package:flutter/material.dart';

class ViewHomeFab extends StatelessWidget {
  final VoidCallback onTap;

  const ViewHomeFab({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return StreamAwaiter<int>(
      stream: b.outPos,
      widgetBuilder: (BuildContext context, int pos) {
        return AnimatedOpacity(
          curve: Curves.ease,
          opacity: pos == 0 ? 1 : 0,
          child: FloatingActionButton(
            elevation: 1,
            child: Icon(Icons.add),
            onPressed: onTap,
          ),
          duration: Duration(milliseconds: 300),
        );
      },
    );
  }
}
