import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:reverpod/constant.dart';

class Setting {
  final box = Hive.box('setting');

  bool getBool(String value) {
    return box.containsKey(value) ? box.get(value) : true;
  }

  double getDouble(String value) {
    return box.containsKey(value) ? box.get(value) : kFontSize;
  }

  String getString(String value) {
    if (value == 'lokasiId') {
      return box.containsKey(value) ? box.get(value) : '1301';
    }
    return box.containsKey(value) ? box.get(value) : '';
  }

  setBool(String keyValue, bool value) {
    box.put(keyValue, value);
  }

  setString(String keyValue, String value) {
    box.put(keyValue, value);
  }

  setDouble(String keyValue, double value) {
    box.put(keyValue, value);
  }
}

final settingProvider = StateProvider<Setting>((ref) => Setting());

class SettingNotifier extends ChangeNotifier {
  final setting = Setting();

  void updateKeyBool(String keyValue, value) {
    setting.setBool(keyValue, value);
    notifyListeners();
  }

  void updateKeyString(String keyValue, value) {
    setting.setString(keyValue, value);
    notifyListeners();
  }

  void updateKeyDouble(String keyValue, value) {
    setting.setDouble(keyValue, value);
    notifyListeners();
  }
}

final settingNotifierProvider = ChangeNotifierProvider<SettingNotifier>((ref) {
  return SettingNotifier();
});
