import 'package:curso/widgets/placeholders/awaiting_container.dart';
import 'package:curso/widgets/placeholders/happy_placeholder.dart';
import 'package:flutter/material.dart';

class StreamAwaiter<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) widgetBuilder;
  final bool isHappy;

  const StreamAwaiter({
    Key key,
    @required this.stream,
    @required this.widgetBuilder,
    this.isHappy: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if (!snapshot.hasData) {
          if (isHappy) {
            return HappyPlaceholder();
          } else {
            return AwaitingContainer();
          }
        } else {
          return widgetBuilder(context, snapshot.data);
        }
      },
    );
  }
}

class PairStreamAwaiter<T, K> extends StatelessWidget {
  final Stream<T> stream1;
  final Stream<K> stream2;
  final Widget Function(T data1, K data2) buildWidget;

  const PairStreamAwaiter({
    Key key,
    @required this.stream1,
    @required this.stream2,
    @required this.buildWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream1,
      builder: (context, AsyncSnapshot<T> snapshot1) {
        if (!snapshot1.hasData) {
          return AwaitingContainer();
        } else {
          return StreamBuilder<K>(
            stream: stream2,
            builder: (BuildContext context, AsyncSnapshot snapshot2) {
              if (!snapshot2.hasData) {
                return AwaitingContainer();
              } else {
                return buildWidget(snapshot1.data, snapshot2.data);
              }
            },
          );
        }
      },
    );
  }
}
