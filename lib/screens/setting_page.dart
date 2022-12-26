import 'package:flutter/material.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/app_bar_widget.dart';
import 'package:messenger/widgets/setting/setting_content_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppLocalizations.of(context)?.setting,
      ),
      body: const SettingContentWidget(),
    );
  }
}
