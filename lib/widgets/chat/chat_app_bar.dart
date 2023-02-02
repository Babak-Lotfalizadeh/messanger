import 'package:flutter/material.dart';
import 'package:messenger/enums/hero_code.dart';
import 'package:messenger/screens/contact_information_page.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/view_model/contact_view_model.dart';
import 'package:messenger/widgets/app_bar_widget.dart';
import 'package:messenger/widgets/user/user_image_widget.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ContactViewModel? contactViewModel;

  const ChatAppBar({
    required this.contactViewModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      prefixIcon: InkWell(
        onTap: () => NavigationService.push(
          ContactInformationPage(
            contactViewModel: contactViewModel,
            comeFromChat: true,
          ),
        ),
        child: Row(
          children: [
            Hero(
              tag: HeroCode.userImage.toString(),
              child: UserImageWidget(
                userImageAddress: contactViewModel?.imageAddress ?? "",
                size: kToolbarHeight * 0.7,
              ),
            ),
            const SizedBox(width: kToolbarHeight * 0.2),
            Text(
              contactViewModel?.title ?? "",
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
