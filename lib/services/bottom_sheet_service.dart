import 'package:flutter/material.dart';
import 'package:messenger/widgets/bottom_sheet_widget.dart';

class BottomSheetService {
  static show({
    required BuildContext context,
    required WidgetBuilder builder,
    required String title,
  }) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      isScrollControlled: true,
      builder: (context) => BottomSheetWidget(
        title: title,
        child: builder.call(context),
      ),
    );
  }
}
