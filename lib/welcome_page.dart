import 'package:flutter/material.dart';
import 'package:smart_move/views/common/fullsize_page.dart';

import '/models/setting.dart';
import '/services/settings_provider.dart';
import '/helpers/names.dart';

import 'package:easy_localization/easy_localization.dart';

import 'home_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FullSizePage(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Image.asset(
                  AppNames.appLogo,
                ),
              ),
            ),
            const Text(
              "Welcome to",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
            ).tr(args: [AppNames.appName]),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 25),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final Setting currentSettings =
                          SettingProvider.getCurrentSettings();
                      SettingProvider.setSettings(
                        Setting(
                          appLanguage: currentSettings.appLanguage,
                          isFirstLaunched: false,
                          appVersion: currentSettings.appVersion,
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    child: const Text("Get Started").tr(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
