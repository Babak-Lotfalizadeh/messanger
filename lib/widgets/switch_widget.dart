import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const SwitchWidget({
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      activeColor: Theme.of(context).colorScheme.secondary,
      onChanged: onChanged,
    );
  }
}
