import 'package:flutter/cupertino.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/dialog_widget.dart';

class DialogService {
  static show({
    required BuildContext context,
    required WidgetBuilder builder,
    required String title,
    bool showClose = true,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) => DialogWidget(
        title: title,
        showClose: showClose,
        child: builder.call(context),
      ),
    );
  }

  static showYesOrNo({
    required BuildContext context,
    required String title,
    String? description,
    String? yesText,
    String? noText,
    Function()? onYes,
    Function()? onNo,
  }) {
    var strings = AppLocalizations.of(context);
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(description ?? ""),
        actions: [
          CupertinoDialogAction(
            onPressed: onYes ?? () => NavigationService.pop(),
            child: Text(yesText ?? strings?.yes ?? ""),
          ),
          CupertinoDialogAction(
            onPressed: onNo ?? () => NavigationService.pop(),
            child: Text(noText ?? strings?.no ?? ""),
          ),
        ],
      ),
    );
  }
}
