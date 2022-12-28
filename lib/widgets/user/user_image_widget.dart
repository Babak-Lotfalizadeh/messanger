import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class UserImageWidget extends StatelessWidget {
  final String? userImageAddress;

  const UserImageWidget({
    required this.userImageAddress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenValues.normalImageSize,
      height: ScreenValues.normalImageSize,
      child: CircleAvatar(
        child: Image.network(
          userImageAddress ?? "",
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.account_circle_sharp,
            size: ScreenValues.normalImageSize,
          ),
        ),
      ),
    );
  }
}
