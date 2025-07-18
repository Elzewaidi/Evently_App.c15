import 'package:eventlyapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(

      primaryColor: AppColors.primaryLight,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(width: 4, color: AppColors.whiteColor),
        ),
      ),
      scaffoldBackgroundColor: AppColors.whiteColor,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.whiteColor
      )

    //appBarTheme: AppBarTheme(
    // backgroundColor: AppColors.primaryLight
    // )
  );
  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryDark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        showUnselectedLabels: true,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(width: 4, color: AppColors.whiteColor),
        ),
      ),

      scaffoldBackgroundColor: AppColors.primaryDark,
      appBarTheme: AppBarTheme(

          backgroundColor: AppColors.primaryDark
      )
    //
  );

}
