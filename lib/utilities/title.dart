import 'package:flutter/material.dart';

import 'app_text.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title, this.color, this.subtitle});

  final String title;
  final bool? color;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: kTitle),
      subtitle:
      subtitle != null
          ? color == true
          ? SelectableText(
        subtitle!,
        style: kSubtitle.copyWith(color: color == true ? Colors.blueAccent : null),
      )
          : Text(
        subtitle!,
        style: kSubtitle.copyWith(color: color == true ? Colors.blueAccent : null),
      )
          : null,
    );
  }
}