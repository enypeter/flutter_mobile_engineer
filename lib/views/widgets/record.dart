import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:projects/constants/constants.dart';
import 'package:projects/constants/dimensions.dart';
import 'package:projects/core/app_theme.dart';
import 'package:projects/core/app_typography.dart';

class Records extends StatelessWidget {
  const Records({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: BODY_PADDING),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: height(context) * 0.18,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primaryColor),
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Text(
                    "BUY",
                    style: TextStyles.style13Regular
                        .copyWith(color: AppColors.whiteColor),
                  ),
                  const Spacer(),
                  Countup(
                    begin: 506,
                    end: 1034,
                    duration: const Duration(seconds: 3),
                    separator: ' ',
                    style: TextStyles.style32Bold
                        .copyWith(color: AppColors.whiteColor),
                  ),
                  tinyVerticalSpace,
                  Text(
                    "offers",
                    style: TextStyles.style13Regular
                        .copyWith(color: AppColors.whiteColor),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )
              .animate()
              .fadeIn() // uses `Animate.defaultDuration`
              .scale() // inherits duration from fadeIn
              .move(delay: 300.ms, duration: 600.ms),
          largeHorizontalSpace(context, 0.1),
          Expanded(
            child: Container(
              height: height(context) * 0.18,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFFFDF8F2)),
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Text(
                    "RENT",
                    style: TextStyles.style13Regular
                        .copyWith(color: AppColors.accentColor),
                  ),
                  const Spacer(),
                  Countup(
                    begin: 1000,
                    end: 2212,
                    duration: const Duration(seconds: 3),
                    separator: ' ',
                    style: TextStyles.style32Bold
                        .copyWith(color: AppColors.accentColor),
                  ),
                  tinyVerticalSpace,
                  Text(
                    "offers",
                    style: TextStyles.style13Regular
                        .copyWith(color: AppColors.accentColor),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )
              .animate()
              .fadeIn() // uses `Animate.defaultDuration`
              .scale() // inherits duration from fadeIn
              .move(delay: 300.ms, duration: 600.ms)
        ],
      ),
    );
  }
}
