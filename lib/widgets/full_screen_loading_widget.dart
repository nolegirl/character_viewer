import 'package:character_viewer/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:character_viewer/utils/helper_funcs.dart';

class FullScreenLoadingWidget extends StatelessWidget {
  final String? loadingText;

  FullScreenLoadingWidget({this.loadingText});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
            backgroundColor:
            isDarkMode(context) ? AppColors.white : AppColors.matteBlack,
        valueColor: AlwaysStoppedAnimation<Color>(
            isDarkMode(context) ? AppColors.matteBlack : AppColors.white),
      ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                loadingText ?? 'Loading',
                style: TextStyle(color: AppColors.cream),
              ),
            )
          ],
        ),
      ),
    );
  }
}
