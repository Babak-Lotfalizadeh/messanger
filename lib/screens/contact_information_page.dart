import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/enums/assets.dart';
import 'package:messenger/enums/hero_code.dart';
import 'package:messenger/providers/contacts_provider.dart';
import 'package:messenger/screens/chat_page.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/view_model/contact_view_model.dart';
import 'package:messenger/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class ContactInformationPage extends StatelessWidget {
  final ContactViewModel? contactViewModel;
  final UserViewModel? userViewModel;
  final bool comeFromChat;

  const ContactInformationPage({
    this.contactViewModel,
    this.userViewModel,
    required this.comeFromChat,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget fallbackImage() => Container(
          color: Theme.of(context).primaryColor,
          child: SvgPicture.asset(
            Assets.userManNoBackground.value,
            width: double.infinity,
            height: ScreenValues.normalImageSize,
          ),
        );
    String title() {
      if (userViewModel != null) {
        if (userViewModel?.name.isNotEmpty == true) {
          return userViewModel?.name ?? "";
        } else {
          return userViewModel?.email ?? "";
        }
      } else {
        return contactViewModel?.title ?? "";
      }
    }

    String imageURL() {
      if (userViewModel != null) {
        return userViewModel?.imageURL ?? "";
      } else {
        return contactViewModel?.imageAddress ?? "";
      }
    }

    String name() {
      if (userViewModel != null) {
        return userViewModel?.name ?? "";
      } else {
        return contactViewModel?.title ?? "";
      }
    }

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
                name(),
                maxLines: 1,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
                  imageURL(),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => fallbackImage(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(ScreenValues.paddingLarge),
              child: Text(title()),
            ),
          ),
          const SliverFillRemaining(),
        ],
      ),
      floatingActionButton: Consumer<ContactsProvider>(
        builder: (context, contactsProvider, child) => FloatingActionButton(
          child: contactsProvider.loading
              ? const CircularProgressIndicator()
              : const Icon(Icons.message),
          onPressed: () async {
            if (contactsProvider.loading) {
              return;
            }
            if (comeFromChat) {
              NavigationService.pop();
            } else {
              ContactViewModel? contact;
              if (userViewModel != null) {
                contact = await contactsProvider.createContact(userViewModel);
              } else {
                contact = contactViewModel;
              }

              NavigationService.push(ChatPage(contactViewModel: contact));
            }
          },
        ),
      ),
    );
  }
}
