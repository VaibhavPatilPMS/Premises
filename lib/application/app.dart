import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/resources/resources.dart';
import '../common/utils/utils.dart';
import 'app_router.dart';

class Application extends StatefulWidget {
  late AppState _appState;

  Application(router, {super.key}) {
    _appState = AppState(router);
  }

  @override
  State<StatefulWidget> createState() {
    return _appState;
  }
}

class AppState extends State<Application> {
  AppRouter router;

  AppState(this.router);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return LayoutBuilder(builder: (context, constraints) {
      return MaterialApp(
        locale: const Locale('en', 'US'),
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                accessibleNavigation: false,
                boldText: false,
                textScaler:
                    TextScaler.linear(MediaQuery.of(context).textScaleFactor)),
            child: child!,
          );
        },
        theme: ThemeData(
          useMaterial3: false,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppColors.white,
                statusBarIconBrightness: Brightness.dark),
          ),
          fontFamily: FontFamily.fontFamily,
          brightness: Brightness.light,
          primaryColor: AppColors.color_primary,
          primaryColorDark: AppColors.color_secondary,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: AppColors.text_grey),
        ),
        title: AppStrings().app_title,
        onGenerateRoute: (settings) => router.router(settings),
      );
    });
  }
}
