import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/providers/image_picker_provider.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/setting/setting_item_card.dart';
import 'package:provider/provider.dart';

class BottomSheetChangeImage extends StatelessWidget {
  final Function(File? file) onFilePicked;

  const BottomSheetChangeImage({
    required this.onFilePicked,
    Key? key,
  }) : super(key: key);

  void _pick(BuildContext context, ImageSource imageSource) {
    var provider = context.read<ImagePickerProvider>();
    provider.pick(context: context, imageSource: imageSource).then((value) {
      onFilePicked(value);
      NavigationService.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);

    return ChangeNotifierProvider(
      create: (context) => ImagePickerProvider(),
      child: Consumer<ImagePickerProvider>(
        builder: (context, imagePickerProvider, child) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SettingItemCard(
              title: strings?.camera ?? "",
              iconData: Icons.camera,
              lock: imagePickerProvider.loading != null,
              loading: imagePickerProvider.loading == ImageSource.camera,
              onClick: () => _pick(context, ImageSource.camera),
            ),
            SettingItemCard(
              title: strings?.storage ?? "",
              iconData: Icons.sd_storage,
              lock: imagePickerProvider.loading != null,
              loading: imagePickerProvider.loading == ImageSource.gallery,
              onClick: () => _pick(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
