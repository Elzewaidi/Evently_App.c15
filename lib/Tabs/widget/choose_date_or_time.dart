import 'package:eventlyapp/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_theme_provider.dart';

class ChooseDateOrTime extends StatelessWidget {
  String chooseEventDateOrTime;
  String eventDateOrTime;
  String iconName;
  Function onChooseDateOrTimeClicked;

  ChooseDateOrTime({
    required this.chooseEventDateOrTime,
    required this.eventDateOrTime,
    required this.onChooseDateOrTimeClicked,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Image.asset(iconName),
        SizedBox(width: width * .04),
        Text(
          eventDateOrTime,
          style: themeProvider.apptheme == ThemeMode.dark
              ? AppStyles.medium16White(context)
              : AppStyles.medium16Black(context),
        ),
        Spacer(),

        TextButton(
          onPressed: () => onChooseDateOrTimeClicked(),
          child: Text(
            chooseEventDateOrTime,
            style: themeProvider.apptheme == ThemeMode.dark
                ? AppStyles.bold14White(context)
                : AppStyles.bold14Black(context),
          ),
        ),
      ],
    );
  }
}
