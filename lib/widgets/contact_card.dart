import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/enums/hero_code.dart';
import 'package:messenger/widgets/user/user_image_widget.dart';

class ContactCard extends StatelessWidget {
  final String? title;
  final String? backupTitle;
  final String? imageURL;
  final bool heroTag;
  final Function() onTab;

  const ContactCard({
    required this.onTab,
    required this.title,
    required this.backupTitle,
    required this.imageURL,
    this.heroTag = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget userImage() {
      var result = UserImageWidget(
        userImageAddress: imageURL,
        size: ScreenValues.iconLarge,
      );
      if (heroTag) {
        return Hero(
          tag: HeroCode.userImage.toString(),
          child: result,
        );
      }
      return result;
    }

    return Card(
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(ScreenValues.radiusNormal),
        ),
        splashColor: Theme.of(context).primaryColor,
        splashFactory: InkRipple.splashFactory,
        onTap: onTab,
        child: Padding(
          padding: const EdgeInsets.all(ScreenValues.paddingLarge),
          child: Row(
            children: [
              userImage(),
              const SizedBox(width: ScreenValues.paddingNormal),
              Text(
                ((title?.isNotEmpty == true) ? title : backupTitle) ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
