import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/enums/hero_code.dart';
import 'package:messenger/screens/chat_page.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/view_model/contact_view_model.dart';
import 'package:messenger/widgets/user/user_image_widget.dart';

class ContactCard extends StatelessWidget {
  final ContactViewModel? contactViewModel;

  const ContactCard({
    required this.contactViewModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(ScreenValues.radiusNormal),
        ),
        splashColor: Theme.of(context).primaryColor,
        splashFactory: InkRipple.splashFactory,
        onTap: () {
          NavigationService.push(ChatPage(contactViewModel: contactViewModel));
        },
        child: Padding(
          padding: const EdgeInsets.all(ScreenValues.paddingLarge),
          child: Row(
            children: [
              Hero(
                tag: HeroCode.userImage.toString(),
                child: UserImageWidget(
                  userImageAddress: contactViewModel?.imageAddress,
                  size: ScreenValues.iconLarge,
                ),
              ),
              const SizedBox(width: ScreenValues.paddingNormal),
              Text(
                contactViewModel?.title ?? "",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
