import 'package:flutter/material.dart';

import '../../../../../config/text_styles.dart';

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    super.key, required this.title, required this.trailing,
  });
  final String title;
  final Widget trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,style: TextStyles.style20.copyWith(fontSize: 18),),
      trailing: trailing,
    );
  }
}
