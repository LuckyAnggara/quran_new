import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

final suratPageControllerProvider = StateProvider.autoDispose<ScrollController>(
  (ref) => ScrollController(),
);
final jadwalSolatControllerProvider =
    StateProvider.autoDispose<ScrollController>(
  (ref) => ScrollController(),
);

final cariAyatProvider = StateProvider.autoDispose<int>((ref) {
  return 1;
});

final itemScrollProvider =
    StateProvider.autoDispose<ItemScrollController>((ref) {
  return ItemScrollController();
});

class AyatPosition extends ChangeNotifier {
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final ItemScrollController itemScrollController = ItemScrollController();

  AyatPosition() {
    init();
  }

  final double position = 0;

  void init() {
    itemPositionsListener.itemPositions.addListener(() {
      debugPrint(itemScrollController.toString());
      notifyListeners();
    });
  }
}

final itemPositionProvider =
    StateProvider.autoDispose<ItemPositionsListener>((ref) {
  return ItemPositionsListener.create();
});

final ayatPositionProvider = ChangeNotifierProvider<AyatPosition>((ref) {
  return AyatPosition();
});
