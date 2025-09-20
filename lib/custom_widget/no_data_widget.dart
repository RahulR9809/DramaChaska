import 'package:flutter/material.dart';
import 'package:drama_chaska/main.dart';
import 'package:drama_chaska/utils/asset.dart';
import 'package:drama_chaska/utils/color.dart';
import 'package:drama_chaska/utils/font_style.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppAsset.noData,
            fit: BoxFit.cover,
            height: 80,
            color: AppColor.colorIconGrey,
          ),
          20.height,
          Text(
            text,
            style: AppFontStyle.styleW500(AppColor.colorIconGrey, 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
