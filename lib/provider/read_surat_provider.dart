import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

final scrollControllerProvider =
    ChangeNotifierProvider.autoDispose<ScrollControllerSurat>((ref) {
  return ScrollControllerSurat();
});

class ScrollControllerSurat extends ChangeNotifier {
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  int index = 4;
  String message = '';
  double offset = 0.01;
  double max = 0.01;
  double oy = 0.01;

  ScrollControllerSurat() {
    listener();
  }

  void add() {
    index + 4;
    notifyListeners();
  }

  void listener() {
    itemPositionsListener.itemPositions.addListener(() {
      notifyListeners();
    });
  }
}
