import 'package:flutter/cupertino.dart';
import 'package:messenger/widgets/dialog_widget.dart';

class DialogService {
  static show({
    required BuildContext context,
    required WidgetBuilder builder,
    required String title,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) => DialogWidget(
        title: title,
        child: builder.call(context),
      ),
    );
  }
}
