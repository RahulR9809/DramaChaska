// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:drama_chaska/custom_widget/create_repprt/report_bottom_sheet_ui.dart';
// import 'package:drama_chaska/main.dart';
// import 'package:drama_chaska/ui/home_page/controller/home_controller.dart';
// import 'package:drama_chaska/ui/home_page/widget/home_widget.dart';
// import 'package:drama_chaska/utils/color.dart';
// import 'package:drama_chaska/utils/constant.dart';

// class HomeViewPage extends StatelessWidget {
//   const HomeViewPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final HomeController homeController = Get.find<HomeController>();

//     return Scaffold(
//       backgroundColor: AppColor.colorBlack,
//       body: NotificationListener<ScrollNotification>(
//         onNotification: (scrollNotification) {
//           if (scrollNotification is ScrollUpdateNotification) {
//             // Update opacity based on scroll position
//             if (scrollNotification.metrics.axis == Axis.vertical) {
//               homeController.updateAppBarOpacity(scrollNotification.metrics.pixels);
//               log("Vertical Scroll position: ${scrollNotification.metrics.pixels}");
//             }
//           }
//           return true;
//         },
//         child: RefreshIndicator(
//           color: AppColor.colorBlack,
//           onRefresh: () async {
//             await 400.milliseconds.delay();
//             await homeController.onRefresh();
//           },
//           child: CustomScrollView(
//             physics: const BouncingScrollPhysics(),
//             slivers: [
//               const HomeAppBar(),
//               SliverToBoxAdapter(
//                 child: GetBuilder<HomeController>(
//                   id: Constant.idMostTrending,
//                   builder: (context) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const CarouselBlurBackground(),
//                         18.height,
//                         if (homeController.trendingMovieSeriesModel?.data != null &&
//                             homeController.trendingMovieSeriesModel!.data!.isNotEmpty)
//                         MostTrendingBuilderView(),
//                         const SizedBox(height: 18),
                        
//                         const ContinueWatchingBuilderView(),
//                         if (homeController.newReleasesVideoModel?.videos != null && homeController.newReleasesVideoModel!.videos!.isNotEmpty) const NewReleaseBuilderView(),
//                         // const ComingSoonBuilderView(),
//                         if (homeController.getMoviesGroupedByCategoryModel?.groupedMovies != null && homeController.getMoviesGroupedByCategoryModel!.groupedMovies!.isNotEmpty)
//                           GetBuilder<HomeController>(
//                             builder: (logic) {
//                               return ListView.builder(
//                                 padding: EdgeInsets.zero,
//                                 shrinkWrap: true,
//                                 itemCount: logic.getMoviesGroupedByCategoryModel?.groupedMovies?.length ?? 0,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   return CustomCategoryWiseBuilderView(
//                                     title: logic.getMoviesGroupedByCategoryModel?.groupedMovies?[index].categoryName ?? '',
//                                     moviesList: logic.getMoviesGroupedByCategoryModel?.groupedMovies?[index].movies ?? [],
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:developer';

import 'package:drama_chaska/ui/refill/view/store_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drama_chaska/custom_widget/create_repprt/report_bottom_sheet_ui.dart';
import 'package:drama_chaska/main.dart';
import 'package:drama_chaska/ui/home_page/controller/home_controller.dart';
import 'package:drama_chaska/ui/home_page/widget/home_widget.dart';
import 'package:drama_chaska/utils/color.dart';
import 'package:drama_chaska/utils/constant.dart';

class HomeViewPage extends StatelessWidget {
  const HomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColor.colorBlack,
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            // Update opacity based on scroll position
            if (scrollNotification.metrics.axis == Axis.vertical) {
              homeController.updateAppBarOpacity(scrollNotification.metrics.pixels);
              log("Vertical Scroll position: ${scrollNotification.metrics.pixels}");
            }
          }
          return true;
        },
        child: RefreshIndicator(
          color: AppColor.colorBlack,
          onRefresh: () async {
            await 400.milliseconds.delay();
            await homeController.onRefresh();
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const HomeAppBar(),
              SliverToBoxAdapter(
                child: GetBuilder<HomeController>(
                  id: Constant.idMostTrending,
                  builder: (context) {
                    // Check if any data exists
                    final hasTrendingData = homeController.trendingMovieSeriesModel?.data != null &&
                        homeController.trendingMovieSeriesModel!.data!.isNotEmpty;
                    
                    final hasNewReleases = homeController.newReleasesVideoModel?.videos != null && 
                        homeController.newReleasesVideoModel!.videos!.isNotEmpty;
                    
                    final hasCategoryData = homeController.getMoviesGroupedByCategoryModel?.groupedMovies != null && 
                        homeController.getMoviesGroupedByCategoryModel!.groupedMovies!.isNotEmpty;

                    // If no data at all, show empty state
                    // if (!hasTrendingData && !hasNewReleases && !hasCategoryData) {
                    //   return _buildEmptyState();
                    // }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CarouselBlurBackground(),
                        18.height,
                        
                        // Most Trending Section
                        if (hasTrendingData) ...[
                          MostTrendingBuilderView(),
                          const SizedBox(height: 18),
                        ],
                        
                        // Continue Watching Section
                        const ContinueWatchingBuilderView(),
                        
                          

                        // New Releases Section
                        if (hasNewReleases) ...[
                          const NewReleaseBuilderView(),
                          const SizedBox(height: 18),
                        ],
                        // const ComingSoonBuilderView(),
                        // Category-wise Movies Section
                        if (hasCategoryData)
                          GetBuilder<HomeController>(
                            builder: (logic) {
                              final groupedMovies = logic.getMoviesGroupedByCategoryModel?.groupedMovies ?? [];
                              
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: groupedMovies.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final categoryData = groupedMovies[index];
                                  
                                  // Additional null check for each category
                                  if (categoryData.movies == null || categoryData.movies!.isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  
                                  return CustomCategoryWiseBuilderView(
                                    title: categoryData.categoryName ?? 'Unknown Category',
                                    moviesList: categoryData.movies!,
                                  );
                                },
                              );
                            },
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build empty state when no content is available
  Widget _buildEmptyState() {
    return Container(
      height: Get.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_outlined,
            size: 80,
            color: Colors.white.withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          Text(
            'No Content Available',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for new movies and series',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              final HomeController homeController = Get.find<HomeController>();
              homeController.onRefresh();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.colorPrimary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}