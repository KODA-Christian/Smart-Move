import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import 'helpers/names.dart';
import 'helpers/themes.dart';

import 'services/settings_provider.dart';

import 'views/common/oops_unexpected.dart';
import 'home_page.dart';
import 'welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool appInitialized = true;

  try {
    await Hive.initFlutter();
    await EasyLocalization.ensureInitialized();
    await SettingProvider.initAppStart();
  } catch (e) {
    appInitialized = false;
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: App(
        appInitialized: appInitialized,
        firstAppLaunch: SettingProvider.getCurrentSettings().isFirstLaunched,
      ),
    ),
  );
  // TODO:
}

class App extends StatelessWidget {
  final bool appInitialized;
  final bool firstAppLaunch;
  const App(
      {super.key, required this.firstAppLaunch, required this.appInitialized});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppNames.appName,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppThemes.lightTheme.copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        home: !appInitialized
            ? const OopsUnexpected()
            : (firstAppLaunch ? const WelcomePage() : const HomePage()),
      ),
    );
  }
}
