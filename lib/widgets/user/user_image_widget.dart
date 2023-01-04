import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/enums/assets.dart';

class UserImageWidget extends StatelessWidget {
  final String? userImageAddress;
  final double? size;

  const UserImageWidget({
    required this.userImageAddress,
    this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget fallbackImage() => SvgPicture.asset(
          Assets.userMan.value,
          width: size ?? ScreenValues.normalImageSize,
          height: size ?? ScreenValues.normalImageSize,
        );

    return SizedBox(
      width: size ?? ScreenValues.normalImageSize,
      height: size ?? ScreenValues.normalImageSize,
      child: CircleAvatar(
        child: userImageAddress?.isNotEmpty == true
            ? Image.network(
                userImageAddress ?? "",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => fallbackImage(),
              )
            : fallbackImage(),
      ),
    );
  }
}
