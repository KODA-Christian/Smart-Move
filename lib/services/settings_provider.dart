import 'dart:convert';
import 'package:hive/hive.dart';
import '/services/hive_provider.dart';
import '/models/setting.dart';

class SettingProvider {
  static Setting? _settings;

  static const String _hiveBoxName = 'settings';
  static const String _hiveBoxKey = 'settingsKey';

  static Future<void> initAppStart() async {
    Box box = await HiveProvider.getEncryptedBox(
          boxName: _hiveBoxName, boxKeyName: _hiveBoxKey);
      if (await box.get('settings') == null) {
        await box.put(
            'settings',
            jsonEncode(Setting(
                    appLanguage: 'en',
                    appVersion: '1.0.0',
                    isFirstLaunched: true)
                .toJson()));
      }

      _settings = Setting.fromJson(jsonDecode((await box.get('settings'))!));
      await _saveCurrentSettings();
  }

  static Future<void> setSettings(Setting newSetting) async {
    _settings = newSetting;
    await _saveCurrentSettings();
  }

  static Setting getCurrentSettings() {
    return _settings!;
  }

  static Future<void> _saveCurrentSettings() async {
    Box box = await HiveProvider.getEncryptedBox(
        boxName: _hiveBoxName, boxKeyName: _hiveBoxKey);
    await box.put('settings', jsonEncode(_settings?.toJson()));
    await box.compact();
  }
}
