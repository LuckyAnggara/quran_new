import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

final audioPlayerProvider = Provider.family<void, String>((ref, url) async {
  final player = AudioPlayer();
  print(url);
  await player.setUrl(url);
  await player.play();
});
