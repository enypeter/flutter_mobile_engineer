import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:projects/constants/asset_paths.dart';
import 'package:projects/core/app_theme.dart';
import 'package:projects/helpers/image_holder.dart';
import 'package:projects/views/home_page.dart';
import 'package:projects/views/map_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  final pages = [
    const MapScreen(),
    Container(color: AppColors.backgroundColor),

    const HomeScreen(),
    Container(color: AppColors.backgroundColor),
    Container(color: AppColors.backgroundColor),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        pages[currentIndex],
        Positioned(
          bottom: 0,
          right: 45,
          left: 45,
          child: SafeArea(
            top: false,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.darkColor,
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildBottomNavigationBarItem(0, AppImages.search),
                    buildBottomNavigationBarItem(1, AppImages.message),
                    buildBottomNavigationBarItem(2, AppImages.home),
                    buildBottomNavigationBarItem(3, AppImages.favourite),
                    buildBottomNavigationBarItem(4, AppImages.profile),
                  ],
                ),
              ),
            ),
          ),
        ).animate().slideY(
            begin: 2,
            end: 0,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 950))
      ]),
    );
  }

  Widget buildBottomNavigationBarItem(index, image) {
    return CustomRippleAnimation(
        child: Container(
          decoration: BoxDecoration(
              color: currentIndex == index
                  ? AppColors.primaryColor
                  : Colors.transparent,
              shape: BoxShape.circle),
          padding: const EdgeInsets.all(15),
          child: ImageHolder(
            imagePath: image,
            color: AppColors.whiteColor,
            height: 20,
            width: 20,
          ),
        ),
        onTap: () => setState(() => currentIndex = index));
  }
}

class CustomRippleAnimation extends StatefulWidget {
  final Widget child;
  final Function()? onTap;

  const CustomRippleAnimation({super.key, required this.child, this.onTap});

  @override
  _CustomRippleAnimationState createState() => _CustomRippleAnimationState();
}

class _CustomRippleAnimationState extends State<CustomRippleAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  static const int numberOfRipples = 3;
  static const double maxRippleRadius = 60.0;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
        numberOfRipples,
        (index) => AnimationController(
            vsync: this, duration: Duration(milliseconds: 800 + index * 200)));
    _animations = _controllers
        .map((controller) =>
            Tween<double>(begin: 0.0, end: maxRippleRadius).animate(controller))
        .toList();
    for (var controller in _controllers) {
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset(); // Reset immediately on completion to be ready for the next tap
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startRippleEffect() {
    Future.forEach(_controllers, (AnimationController controller) async {
      await Future.delayed(const Duration(
          milliseconds: 100)); // Delay between starting each ring
      controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _startRippleEffect();
        Future.delayed(const Duration(milliseconds: 600), () {
          widget.onTap?.call();
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ..._animations.map((animation) {
            return AnimatedBuilder(
              animation: animation,
              builder: (_, child) {
                return CustomPaint(
                  painter: RipplePainter(
                      radius: animation.value,
                      color: Colors.white
                          .withOpacity(1 - animation.value / maxRippleRadius)),
                  child: Container(),
                );
              },
            );
          }),
          widget.child,
        ],
      ),
    );
  }
}

class RipplePainter extends CustomPainter {
  final double radius;
  final Color color;

  RipplePainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(size.center(Offset.zero), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
