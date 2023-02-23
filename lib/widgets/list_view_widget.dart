import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class ListViewWidget extends StatelessWidget {
  final NullableIndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder separatorBuilder;
  final ScrollController? controller;
  final EdgeInsets? padding;
  final int itemCount;
  final bool loading;

  const ListViewWidget({
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.itemCount,
    this.controller,
    this.padding,
    this.loading = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.separated(
      padding: padding ?? const EdgeInsets.all(ScreenValues.paddingNormal),
      controller: controller,
      itemBuilder: itemBuilder,
      separatorBuilder: separatorBuilder,
      itemCount: itemCount,
    );
  }
}
