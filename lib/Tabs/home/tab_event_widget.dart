import 'package:flutter/material.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:eventlyapp/utils/styles.dart';

class TabEventWidget extends StatelessWidget {
  bool isSelected;
  String eventName;
  Color backGroundColor;
  TextStyle textSelectedStyle;
  TextStyle textUnSelectedStyle;
  Color? borderColor;

  TabEventWidget({
    required this.isSelected,
    required this.eventName,
    required this.backGroundColor,
    required this.textSelectedStyle,
    required this.textUnSelectedStyle,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * .003,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
          color: borderColor ?? AppColors.whiteColor,
          width: 1,
        ),
        color: isSelected ? backGroundColor : AppColors.transparentColor,
      ),
      child: Text(
        eventName,
        style: isSelected ? textSelectedStyle : textUnSelectedStyle,
      ),
    );
  }
}
