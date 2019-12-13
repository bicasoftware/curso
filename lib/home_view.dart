import 'package:curso/custom_themes.dart';
import 'package:curso/models/periodos.dart';
import 'package:curso/providers/provider_configuration.dart';
import 'package:curso/providers/provider_periodos.dart';
import 'package:curso/splash_screen.dart';
import 'package:curso/utils.dart/storage_utils.dart';
import 'package:curso/view/view_home/view_home.dart';
import 'package:curso/view/view_login/view_login.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:provider/provider.dart';

import 'bloc/bloc_main/bloc_main.dart';

///ViewCheckState, testa se já existe o token salvo
///Se não existir, vai pra [ViewLogin],
///se existir, vai direto para [ViewHome]
class ViewCheckState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomThemes.lightTheme,
      home: FutureObserver<List>(
        future: Future.wait([
          StorageUtils.readToken(),
        ]),
        onAwaiting: (_) => SplashScreen(),
        onSuccess: (_, List data) {
          if ((data[0] as String ?? "").isEmpty) {
            return ViewLogin();
          } else {
            return Cursando();
          }
        },
      ),
    );
  }
}

class Cursando extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureObserver(
      future: Future.wait([
        ProviderConfiguration.fetchBrightness(),
        ProviderPeriodos.fetchAllPeriodos(),
      ]),
      onAwaiting: (_) => SplashScreen(),
      onSuccess: (_, List data) {
        final bool isLight = data[0] as bool;
        final List<Periodos> periodos = data[1] as List<Periodos>;
        return Provider<BlocMain>(
          builder: (BuildContext context) => BlocMain(periodos: periodos, isLight: isLight),
          dispose: (BuildContext a, BlocMain b) => b.dispose(),
          child: ViewHome(
            initialPos: periodos.isNotEmpty ? 1 : 0,
          ),
        );
      },
    );
  }
}
