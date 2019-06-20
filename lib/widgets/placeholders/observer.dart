import 'package:curso/widgets/placeholders/stream_builder_child.dart';
import 'package:flutter/material.dart';

class AnimatedStreamAwaiter<T> extends StatelessWidget {
  final Stream stream;
  final Widget Function(T data) widgetBuilder;

  const AnimatedStreamAwaiter({
    Key key,
    @required this.stream,
    @required this.widgetBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer<T>(
      stream: stream,
      onSuccess: (_, T t) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 150),
          transitionBuilder: (w, Animation<double> a) {
            final scaleTween = TweenSequence([
              TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.9), weight: 1),
              TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 1),
            ]);
            return ScaleTransition(
              scale: scaleTween.animate(a),
              child: FadeTransition(
                opacity: a,
                child: w,
              ),
            );
          },
          child: widgetBuilder(t),
        );
      },
    );
  }
}
