import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:projects/constants/asset_paths.dart';
import 'package:projects/constants/dimensions.dart';
import 'package:projects/core/app_theme.dart';
import 'package:projects/core/app_typography.dart';

class LardImageCard extends StatelessWidget {
  const LardImageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context) * 0.23,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          image: const DecorationImage(
              image: AssetImage(AppImages.kitchen), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(25)),
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: AppColors.whiteColor.withOpacity(0.5)),
              child: Row(
                children: [
                  Expanded(
                      child: Text('Glaskova St.,25',
                          style: TextStyles.style15Regular,
                          textAlign: TextAlign.center)),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.whiteColor),
                    child: Icon(
                      Icons.chevron_right_outlined,
                      color: AppColors.accentColor,
                      size: 18,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
