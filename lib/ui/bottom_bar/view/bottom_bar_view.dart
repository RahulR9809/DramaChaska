import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drama_chaska/ui/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:drama_chaska/ui/bottom_bar/widget/bottom_bar_ui.dart';
import 'package:drama_chaska/utils/constant.dart';

class BottomBarView extends StatelessWidget {
  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<BottomBarController>(
        id: Constant.idOnChangeBottomBar,
        builder: (logic) {
          return PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: logic.bottomBarPages.length,
            controller: logic.pageController,
            onPageChanged: (int index) => logic.onChangeBottomBar(index),
            itemBuilder: (context, index) => logic.bottomBarPages[logic.selectedTabIndex],
          );
        },
      ),
      bottomNavigationBar:BottomBarUi(),
    );
  }
}
