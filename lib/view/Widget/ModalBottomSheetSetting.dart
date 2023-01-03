import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reverpod/constant.dart';
import 'package:reverpod/provider/provider.dart';

class ModalBottomSheet extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  ModalBottomSheet({Key? key, required this.child, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          color: backgroundColor,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(12),
          child: child,
        ),
      ),
    );
  }
}

class ModalFitSetting extends ConsumerWidget {
  const ModalFitSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    setting(string) =>
        ref.watch(settingNotifierProvider).setting.getBool(string);

    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                ),
                width: double.infinity,
                padding: const EdgeInsets.all(
                  10,
                ),
                child: Text(
                  'Settings',
                  style: kPrimaryFontStyle.copyWith(fontSize: 16),
                ),
              ),
            ),
            ListTile(
              minLeadingWidth: 10,
              title: const Text('Arabic'),
              leading: const Icon(Icons.text_fields),
              trailing: Switch(
                value: setting('arabicShow'),
                onChanged: (value) {
                  ref
                      .read(settingNotifierProvider.notifier)
                      .updateKeyBool('arabicShow', value);
                },
                activeTrackColor: kSecondaryColor.withOpacity(0.2),
                activeColor: kSecondaryColor.withOpacity(1),
              ),
            ),
            ListTile(
              minLeadingWidth: 10,
              title: Text('Terjemahan'),
              leading: Icon(Icons.language),
              trailing: Switch(
                value: setting('translateShow'),
                onChanged: (value) {
                  ref
                      .read(settingNotifierProvider.notifier)
                      .updateKeyBool('translateShow', value);
                },
                activeTrackColor: kSecondaryColor.withOpacity(0.2),
                activeColor: kSecondaryColor.withOpacity(1),
              ),
            ),
            ListTile(
              minLeadingWidth: 10,
              title: Text('Latin'),
              leading: Icon(Icons.translate),
              trailing: Switch(
                value: setting('latinShow'),
                onChanged: (value) {
                  ref
                      .read(settingNotifierProvider.notifier)
                      .updateKeyBool('latinShow', value);
                },
                activeTrackColor: kSecondaryColor.withOpacity(0.2),
                activeColor: kSecondaryColor.withOpacity(1),
              ),
            ),
            ListTile(
              minLeadingWidth: 10,
              title: Text('Ukuran Font'),
              leading: Icon(Icons.format_size),
              trailing: GestureDetector(
                onTap: () {
                  context.pushNamed('fontSetting');
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            ListTile(
              minLeadingWidth: 10,
              title: Text('Mode Gelap'),
              leading: Icon(Icons.dark_mode),
              trailing: Switch(
                value: setting('isDark'),
                onChanged: (value) {
                  ref
                      .read(settingNotifierProvider.notifier)
                      .updateKeyBool('isDark', value);
                },
                activeTrackColor: kSecondaryColor.withOpacity(0.2),
                activeColor: kSecondaryColor.withOpacity(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModalFitFont extends StatelessWidget {
  const ModalFitFont({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            ListTile(
              title: Text('Terjemahan'),
              leading: Icon(Icons.language),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
                activeTrackColor: kSecondaryColor.withOpacity(0.2),
                activeColor: kSecondaryColor.withOpacity(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
