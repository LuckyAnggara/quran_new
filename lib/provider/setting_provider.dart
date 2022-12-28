import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:reverpod/models/setting.dart';

final arabicStateProvider = StateProvider<bool>((ref) {
  return false;
});

final translateStateProvider = StateProvider<bool>((ref) {
  return false;
});

final latinStateProvider = StateProvider<bool>((ref) {
  return false;
});

final darkStateProvider = StateProvider<bool>((ref) {
  return false;
});

final arabicSizeProvider = StateProvider<double>((ref) {
  return 14;
});

final latinSizeProvider = StateProvider<double>((ref) {
  return 14;
});

final translateSizeProvider = StateProvider<double>((ref) {
  return 14;
});
