import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/enums/assets.dart';
import 'package:messenger/enums/hero_code.dart';
import 'package:messenger/screens/chat_page.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/view_model/contact_view_model.dart';

class ContactInformationPage extends StatelessWidget {
  final ContactViewModel? contactViewModel;
  final bool comeFromChat;

  const ContactInformationPage({
    required this.contactViewModel,
    required this.comeFromChat,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget fallbackImage() => Container(
          color: const Color(0xff90DFAA),
          child: SvgPicture.asset(
            Assets.userManNoBackground.value,
            width: double.infinity,
            height: ScreenValues.normalImageSize,
          ),
        );

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: ScreenValues.normalImageSize,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                contactViewModel?.title ?? "",
                style: Theme.of(context).textTheme.headline6?.copyWith(
                  shadows: [
                    Shadow(
                      color: Theme.of(context).appBarTheme.backgroundColor ??
                          Colors.black,
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              background: Hero(
                tag: HeroCode.userImage.toString(),
                child: Image.network(
                  contactViewModel?.imageAddress ?? "",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => fallbackImage(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(ScreenValues.paddingLarge),
              child: Text(contactViewModel?.title ?? ""),
            ),
          ),
          const SliverFillRemaining(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: () {
          if (comeFromChat) {
            NavigationService.pop();
          } else {
            NavigationService.push(
              ChatPage(contactViewModel: contactViewModel),
            );
          }
        },
      ),
    );
  }
}
