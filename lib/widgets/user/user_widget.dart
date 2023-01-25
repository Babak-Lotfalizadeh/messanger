import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/widgets/user/user_image_widget.dart';

class UserWidget extends StatelessWidget {
  final User? user;
  const UserWidget({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        UserImageWidget(userImageAddress: user?.photoURL),
        Text(user?.displayName ?? ""),
        Text(user?.email ?? ""),
        Text(user?.photoURL ?? ""),
      ],
    );
  }
}
