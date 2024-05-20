import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:projects/constants/constants.dart';
import 'package:projects/constants/dimensions.dart';
import 'package:projects/core/app_theme.dart';
import 'package:projects/core/app_typography.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: BODY_PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          mediumVerticalSpace,
          Text(
            'Hi, Marina',
            style: TextStyles.style20Regular
                .copyWith(color: AppColors.accentColor),
          ).animate().fadeIn(delay: 200.ms, duration: 700.ms),
          tinyVerticalSpace,
          Animate(
            effects: [
              FadeEffect(delay: 750.ms, duration: 500.ms),
              SlideEffect(
                  begin: SlideEffect.neutralValue.copyWith(dx: 0, dy: 0.5),
                  end: SlideEffect.neutralValue)
            ],
            child: Text(
              "let's select your\nperfect place",
              style: TextStyles.style32Regular.copyWith(),
            ),
          ),
          largeVerticalSpace(context, 0.04),
        ],
      ),
    );
  }
}
