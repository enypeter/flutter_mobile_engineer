import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projects/core/app_theme.dart';
import 'package:projects/core/app_typography.dart';
import 'package:projects/constants/asset_paths.dart';
import 'package:projects/constants/constants.dart';
import 'package:projects/constants/dimensions.dart';
import 'package:projects/helpers/image_holder.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  String selectedMenu = '';
  bool showMarkerImage = false;
  final Random random = Random();
  final int numberOfBubbles = 10; // Define the number of bubbles
  final List<Widget> bubbles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      for (int i = 0; i < numberOfBubbles; i++) {
        bubbles.add(_buildBubble(size));
      }
      setState(() {});
    });
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        left: 20, // Adjust width as needed
        bottom: 150, // Adjust height as needed
        child: Material(
          elevation: 4.0,
          color: Colors.transparent,
          child: ScaleTransition(
            scale: _scaleAnimation,
            alignment: Alignment.bottomLeft,
            // Anchor expansion to the bottom-right corner
            child: Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(5).copyWith(top: 5, bottom: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  popUpTile(AppImages.shield, 'Cosy areas'),
                  popUpTile(AppImages.wallet, 'Price'),
                  popUpTile(AppImages.basket, 'Infrastructure'),
                  popUpTile(AppImages.layer, 'Without any layer'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget popUpTile(leadingImage, title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          setState(() => selectedMenu = title);
          _reversePopUp();
        },
        child: Row(
          children: [
            ImageHolder(
                imagePath: leadingImage,
                color: selectedMenu == title
                    ? AppColors.primaryColor
                    : AppColors.lighterGreyColor,
                height: 18),
            tinyHorizontalSpace,
            Text(
              title,
              style: TextStyles.style11Medium.copyWith(
                  color: selectedMenu == title
                      ? AppColors.primaryColor
                      : AppColors.lighterGreyColor),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePopup() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      _controller.forward();
    }
    showMarkerImage = false;
    setState(() {});
  }

  void _reversePopUp() {
    if (_overlayEntry != null) {
      _controller.reverse().then((value) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
      showMarkerImage = true;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _reversePopUp,
        child: Container(
          height: height(context),
          width: width(context),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.map), fit: BoxFit.cover)),
          child: Stack(
            children: [
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: BODY_PADDING + 5)
                                .copyWith(top: 15),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    color: AppColors.whiteColor),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Row(
                                  children: [
                                    ImageHolder(
                                      imagePath: AppImages.searchOutlined,
                                      height: 18,
                                      color: AppColors.lightGreyColor,
                                    ),
                                    tinyHorizontalSpace,
                                    Text(
                                      'Saint Petersburg',
                                      style: TextStyles.style13Medium.copyWith(
                                          color: AppColors.lightGreyColor),
                                    )
                                  ],
                                ),
                              ),
                            )
                                .animate()
                                .fadeIn() // uses `Animate.defaultDuration`
                                .scale() // inherits duration from fadeIn
                                .move(delay: 300.ms, duration: 800.ms),
                            smallHorizontalSpace,
                            CircleAvatar(
                                    radius: 25,
                                    backgroundColor: AppColors.whiteColor,
                                    child: ImageHolder(
                                      imagePath: AppImages.filter,
                                      height: 20,
                                      color: AppColors.lightGreyColor,
                                    ))
                                .animate()
                                .fadeIn() // uses `Animate.defaultDuration`
                                .scale() // inherits duration from fadeIn
                                .move(delay: 300.ms, duration: 800.ms)
                          ],
                        )),
                    Expanded(
                      child: Stack(
                        children: bubbles,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 105,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        buildFloatingActionButton(
                                ImageHolder(
                                    imagePath: AppImages.layer,
                                    color: AppColors.whiteColor,
                                    height: 18),
                                onTap: _togglePopup)
                            .animate()
                            .fadeIn() // uses `Animate.defaultDuration`
                            .scale(delay: 300.ms, duration: 400.ms),
                        smallVerticalSpace,
                        buildFloatingActionButton(ImageHolder(
                                imagePath: AppImages.send,
                                color: AppColors.whiteColor,
                                height: 18))
                            .animate()
                            .fadeIn() // uses `Animate.defaultDuration`
                            .scale(delay: 300.ms, duration: 400.ms),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.backgroundColor.withOpacity(0.35),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 17, vertical: 12),
                        child: Row(
                          children: [
                            ImageHolder(
                              imagePath: AppImages.list,
                              color: AppColors.whiteColor,
                              height: 15,
                            ),
                            tinyHorizontalSpace,
                            Text(
                              'List of variants',
                              style: TextStyles.style11Medium
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                          ],
                        ),
                      )
                          .animate()
                          .fadeIn() // uses `Animate.defaultDuration`
                          .scale(delay: 300.ms, duration: 400.ms),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBubble(Size size) {
    final diameter = random.nextInt(30); // Random diameter between 10 and 50
    return Positioned(
      left: random.nextDouble() * (size.width - diameter), // Random x position
      top: random.nextDouble() * (size.height - diameter), // Random y position
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          width: showMarkerImage ? 30.w : 100.w,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8))
                  .copyWith(bottomRight: const Radius.circular(8))),
          child: showMarkerImage
              ? Icon(
                  Icons.home_work_outlined,
                  color: AppColors.whiteColor,
                  size: 18,
                )
              : Text(
                  '${diameter + 7.3} mm P',
                  textAlign: TextAlign.center,
                  style: TextStyles.style11Medium
                      .copyWith(color: AppColors.whiteColor),
                ),
        ),
      ),
    )
        .animate()
        .fadeIn() // uses `Animate.defaultDuration`
        .scale(delay: 300.ms, duration: 400.ms);
  }

  Widget buildFloatingActionButton(Widget icon, {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.backgroundColor.withOpacity(0.35),
        ),
        child: icon,
      ),
    );
  }
}
