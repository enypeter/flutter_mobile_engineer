import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:projects/constants/asset_paths.dart';
import 'package:projects/core/app_theme.dart';
import 'package:projects/constants/constants.dart';
import 'package:projects/constants/dimensions.dart';
import 'package:projects/views/widgets/app_bar.dart';
import 'package:projects/views/widgets/image_card.dart';
import 'package:projects/views/widgets/large_image_card.dart';
import 'package:projects/views/widgets/record.dart';
import 'package:projects/views/widgets/welcome_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double modalHeightFactor = 0.05;
  bool over = false;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        modalHeightFactor = minHeightRatio;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [AppColors.backgroundColor, AppColors.lightColor],
              stops: const [0.4, 1])),
      height: height(context),
      width: width(context),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                const CustomAppBar(),
                tinyVerticalSpace,
                const WelcomeText(),
                const Records(),
                largeVerticalSpace(context, 0.04),
              ],
            ),
          ),
          bottomSheet: AnimatedContainer(
            height: height(context) * modalHeightFactor,
            duration: const Duration(milliseconds: 600),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(25)),
            padding: const EdgeInsets.all(10),
            child: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;

                if (direction == ScrollDirection.forward &&
                    scrollController.offset == 0) {
                  modalHeightFactor = minHeightRatio;
                  over = false;
                } else if (direction == ScrollDirection.reverse) {
                  modalHeightFactor = maxHeightRatio;
                  over = true;
                }

                setState(() {});
                return true;
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: ListView(
                  padding: EdgeInsets.zero,
                  controller: scrollController,
                  children: [
                    const LardImageCard(),
                    mediumVerticalSpace,
                    StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: [
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 4,
                          child: ImageBox(AppImages.room1, over: over),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: ImageBox(AppImages.room2, over: over),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: ImageBox(AppImages.room3, over: over),
                        ),
                      ],
                    ),
                    smallVerticalSpace,
                    StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: [
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 4,
                          child: ImageBox(AppImages.room1, over: over),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: ImageBox(AppImages.room2, over: over),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: ImageBox(
                            AppImages.room3,
                            over: over,
                          ),
                        ),
                      ],
                    ),
                    largeVerticalSpace(context, 0.1)
                  ],
                ),
              ),
            ),
          )),
    );
  }
}



