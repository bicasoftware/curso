import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:provider/provider.dart';

class BrightnessButton extends StatelessWidget {
  const BrightnessButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);
    return StreamObserver(
      stream: b.outBrightness,
      onSuccess: (_, bool isLight) => AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: IconButton(
          key: UniqueKey(),
          icon: Icon(isLight ? Icons.brightness_5 : Icons.brightness_4),
          onPressed: b.toggleBrightness,
        ),
        transitionBuilder: (Widget w, Animation<double> a) => ScaleTransition(
          scale: a,
          child: FadeTransition(
            opacity: a,
            child: RotationTransition(
              turns: a,
              child: w,
            ),
          ),
        ),
      ),
    );
  }
}
