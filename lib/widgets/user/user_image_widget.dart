import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/enums/assets.dart';

class UserImageWidget extends StatelessWidget {
  final String? userImageAddress;
  final Function()? onEdit;
  final double? size;
  final bool loading;

  const UserImageWidget({
    required this.userImageAddress,
    this.onEdit,
    this.size,
    this.loading = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgetSize = size ?? ScreenValues.normalImageSize;
    Widget fallbackImage() => SvgPicture.asset(
          Assets.userMan.value,
          width: widgetSize,
          height: widgetSize,
        );
    var borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(widgetSize),
      bottomRight: Radius.circular(widgetSize),
    );

    return SizedBox(
      width: widgetSize,
      height: widgetSize,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: widgetSize,
            height: widgetSize,
            child: CircleAvatar(
              foregroundImage: userImageAddress?.isNotEmpty == true
                  ? NetworkImage(
                      userImageAddress ?? "",
                    )
                  : null,
              child: fallbackImage(),
            ),
          ),
          Visibility(
            visible: onEdit != null,
            child: InkWell(
              onTap: loading ? null : onEdit,
              borderRadius: borderRadius,
              child: Container(
                width: widgetSize,
                height: (widgetSize) * 0.5,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: Colors.white.withOpacity(0.5),
                ),
                child: loading
                    ? const Center(child: CircularProgressIndicator())
                    : Icon(
                        Icons.camera_alt,
                        size: widgetSize * 0.2,
                        color: Theme.of(context).primaryColor,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
