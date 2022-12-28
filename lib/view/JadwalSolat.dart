import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/provider.dart';

class JadwalSolat extends ConsumerWidget {
  const JadwalSolat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(suratProvider);

    return Scaffold(
      body: Center(
        child: Text(_data.value.toString()),
      ),
    );
  }
}
