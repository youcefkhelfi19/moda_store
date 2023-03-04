import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moda_store/config/text_styles.dart';

class ScreenSwitch extends StatelessWidget {
  const ScreenSwitch({
    Key? key, required this.description, required this.btnTitle, required this.routeName,
  }) : super(key: key);
  final String description;
  final String btnTitle;
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: "$description ",
              style: TextStyles.style20.copyWith(color: Colors.black54)
          ),
          TextSpan(
              text: btnTitle,
              style: TextStyles.style20.copyWith(fontSize: 16),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacementNamed(context, routeName);
                }),
        ]),
      ),
    );
  }
}
