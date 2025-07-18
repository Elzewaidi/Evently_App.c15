import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles.dart';

class CustomElevatedButton extends StatelessWidget {
  Color? backGroundColor;
  Widget? prefixIconButton;
  String text;
  TextStyle? textStyle;
  Function onButtonClicked;
  CustomElevatedButton({

    this.backGroundColor,
    this.prefixIconButton,
    required this.text,
    this.textStyle,
    required this.onButtonClicked
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor ?? AppColors.primaryLight,
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .02,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
            side: BorderSide(
                color: Theme
                    .of(context)
                    .primaryColor,
                width: 2
            )


        ),
      ),
      onPressed: () {
        onButtonClicked();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixIconButton ?? SizedBox(),
          SizedBox(width: width * .02),
          Text(text, style: textStyle ?? AppStyles.regular20White(context)),
        ],
      ),
    );
  }
}
