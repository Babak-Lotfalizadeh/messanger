import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/button_widget.dart';

class BottomSheetChangeTheme extends StatefulWidget {
  final Function(Color color) onSave;
  final Color defaultColor;

  const BottomSheetChangeTheme({
    required this.defaultColor,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  @override
  State<BottomSheetChangeTheme> createState() => _BottomSheetChangeThemeState();
}

class _BottomSheetChangeThemeState extends State<BottomSheetChangeTheme> {
  late Color pickerColor = widget.defaultColor;

  void onColorChanged(Color newValue) {
    pickerColor = newValue;
  }

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: onColorChanged,
          ),
          ButtonWidget(
            onPressed: () => widget.onSave(pickerColor),
            title: strings?.save ?? "",
          ),
        ],
      ),
    );
  }
}
