import 'package:curso/widgets/placeholders/awaiting_container.dart';
import 'package:flutter/material.dart';

class StreamBuilderChild<T> extends StatelessWidget {
  final AsyncSnapshot<T> snapshot;
  final Widget Function(BuildContext, T) builder;

  const StreamBuilderChild({
    Key key,
    @required this.snapshot,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !snapshot.hasData ? AwaitingContainer() : builder(context, snapshot.data);
  }
}

class StreamAwaiter<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) widgetBuilder;

  const StreamAwaiter({Key key, @required this.stream, @required this.widgetBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<T>(
      stream: stream,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if(!snapshot.hasData){
          return AwaitingContainer();
        } else {
          return widgetBuilder(context, snapshot.data);
        }
      },
    );
  }
}
