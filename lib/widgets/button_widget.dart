import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class ButtonWidget extends StatefulWidget {
  final Future<dynamic> Function() onPressed;
  final Widget? child;
  final String title;

  const ButtonWidget({
    required this.onPressed,
    required this.title,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  final _resizeDuration = const Duration(milliseconds: 300);
  final double _height = 45;
  bool _loading = false;

  double? get _loadingSize => _loading ? _height : null;

  void _startLoading() {
    setState(() {
      _loading = true;
    });
  }

  void _stopLoading() {
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.bodyText1?.copyWith(
          color: Theme.of(context).cardColor,
        );
    Widget child() {
      if (_loading) {
        return CircularProgressIndicator(
          color: textTheme?.color,
        );
      } else if (widget.child != null) {
        return widget.child ?? const SizedBox();
      }
      return Text(
        widget.title,
        style: textTheme,
      );
    }

    return Center(
      child: InkWell(
        onTap: () async {
          _startLoading();
          await widget.onPressed.call();
          _stopLoading();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                _loading
                    ? ScreenValues.radiusXLarge
                    : ScreenValues.radiusNormal,
              ),
            ),
          ),
          child: AnimatedSize(
            curve: Curves.easeIn,
            duration: _resizeDuration,
            child: SizedBox(
              width: _loadingSize,
              height: _height,
              child: Center(child: child()),
            ),
          ),
        ),
      ),
    );
  }
}
