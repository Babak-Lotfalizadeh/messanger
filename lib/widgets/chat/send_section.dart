import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/enums/text_field_design.dart';
import 'package:messenger/providers/chat_send_section_provider.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/view_model/contact_view_model.dart';
import 'package:messenger/widgets/teddy/text_field_widget.dart';
import 'package:provider/provider.dart';

class SendSection extends StatelessWidget {
  final ContactViewModel? contactViewModel;

  const SendSection({
    required this.contactViewModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);
    return ChangeNotifierProvider(
      create: (context) => ChatSendSectionProvider(),
      child: Consumer<ChatSendSectionProvider>(
        builder: (context, chatSendSectionProvider, child) => Material(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.all(ScreenValues.paddingNormal),
            child: Row(
              children: [
                Expanded(
                  child: TextFieldWidget(
                    hintText: strings?.writeYourMessage ?? "",
                    textFieldDesign: TextFieldDesign.borderLess,
                    controller: chatSendSectionProvider.controller,
                    focusNode: chatSendSectionProvider.focusNode,
                    suffixIcon: IconButton(
                      onPressed: () => chatSendSectionProvider.sendMessage(
                        contactViewModel,
                      ),
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
