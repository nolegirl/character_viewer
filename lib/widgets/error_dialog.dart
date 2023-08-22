import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:character_viewer/utils/app_colors.dart';
import 'package:character_viewer/utils/helper_funcs.dart';

class ErrorMessageDialog extends StatelessWidget {
  final String? title;
  final String? message;
  String optionOnPressButtonTitle = '';
  final VoidCallback? optionalOnPress;

  ErrorMessageDialog({this.title, this.message, this.optionalOnPress});

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor = isDarkMode(context) ? AppColors.matteBlack : AppColors.cream;

    String buttonTitle = optionOnPressButtonTitle != '' ? optionOnPressButtonTitle : 'OK';

    return AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(title ?? 'Error',
          style: TextStyle(color: isDarkMode(context) ? AppColors.cream : AppColors.matteBlack, fontSize: 16)),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message ?? 'Uh Oh',
                style: TextStyle(color: isDarkMode(context) ? AppColors.cream : AppColors.matteBlack, fontSize: 12)),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.purpleAccent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ))),
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    optionalOnPress?.call();
                    Navigator.of(context).pop();
                  },
                  child: Text(buttonTitle,
                    style: TextStyle(color: backgroundColor),
                  )),
            )
          ]),
    );
  }
}
