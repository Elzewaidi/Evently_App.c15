// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'app_colors.dart';
//
// class AppStyles {
//   static TextStyle semi20Black = GoogleFonts.inter(
//     fontSize: 20,
//     fontWeight: FontWeight.w700,
//     color: AppColors.blackColor,
//   );
//
//   static TextStyle semi20Primary = GoogleFonts.inter(
//     fontSize: 20,
//     fontWeight: FontWeight.w700,
//     color: AppColors.primaryLight,
//   );
//
//   static TextStyle bold20Primary = GoogleFonts.inter(
//     fontSize: 20,
//     fontWeight: FontWeight.bold,
//     color: AppColors.primaryLight,
//   );
//
//   static TextStyle bold12White = GoogleFonts.inter(
//     fontSize: 12,
//     fontWeight: FontWeight.bold,
//     color: AppColors.whiteColor,
//   );
//
//   static TextStyle bold24White = GoogleFonts.inter(
//     fontSize: 24,
//     fontWeight: FontWeight.bold,
//     color: AppColors.whiteColor,
//   );
//   static TextStyle bold14black = GoogleFonts.inter(
//     fontSize: 14,
//     fontWeight: FontWeight.bold,
//     color: AppColors.blackColor,
//   );
//   static TextStyle bold14primary = GoogleFonts.inter(
//     fontSize: 14,
//     fontWeight: FontWeight.bold,
//     color: AppColors.primaryLight,
//   );
//   static TextStyle bold16primary = GoogleFonts.inter(
//     fontSize: 16,
//     fontWeight: FontWeight.bold,
//     color: AppColors.primaryLight,
//   );
//   static TextStyle bold16White = GoogleFonts.inter(
//     fontSize: 16,
//     fontWeight: FontWeight.bold,
//     color: AppColors.whiteColor,
//   );
//   static TextStyle bold20black = GoogleFonts.inter(
//     fontSize: 20,
//     fontWeight: FontWeight.bold,
//     color: AppColors.blackColor,
//   );
//   static TextStyle regular14white = GoogleFonts.inter(
//     fontSize: 14,
//     fontWeight: FontWeight.normal,
//     color: AppColors.whiteColor,
//   );
//
//   static TextStyle medium16gray = GoogleFonts.inter(
//     fontSize: 16,
//     fontWeight: FontWeight.w500,
//     color: Colors.grey,
//   );
//
//   static final TextStyle medium16White = GoogleFonts.inter(
//   fontSize: 16,
//   fontWeight: FontWeight.w500,
//   color: Colors.white,
//   );
//
//   static final TextStyle medium16Primary = GoogleFonts.inter(
//   fontSize: 16,
//   fontWeight: FontWeight.w500,
//   color: AppColors.primaryLight,
//   );
//
//   static final TextStyle medium14White = GoogleFonts.inter(
//   fontSize: 14,
//   fontWeight: FontWeight.w500,
//   color: Colors.white,
//   );
//
//   static final TextStyle medium20White = GoogleFonts.inter(
//   fontSize: 20,
//   fontWeight: FontWeight.w500,
//   color: Colors.white,
//   );
//
//   static final TextStyle medium20Primary = GoogleFonts.inter(
//   fontSize: 20,
//   fontWeight: FontWeight.w500,
//   color: AppColors.primaryLight,
//   );
//
//   static final TextStyle medium16Black = GoogleFonts.inter(
//   fontSize: 16,
//   fontWeight: FontWeight.w500,
//   color: Colors.black,
//   );
//
//   static final TextStyle medium16Grey = GoogleFonts.inter(
//   fontSize: 16,
//   fontWeight: FontWeight.w500,
//   color: Colors.grey,
//   );
//   static TextStyle reguler20white = GoogleFonts.inter(
//     fontSize: 20,
//     fontWeight: FontWeight.normal,
//     color: AppColors.whiteColor,
//   );
//
//
//
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyles {
  static TextStyle semi20Black(BuildContext context) => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Theme.of(context).colorScheme.onBackground,
  );

  static TextStyle semi20Primary(BuildContext context) => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Theme.of(context).primaryColor,
  );

  static TextStyle bold20Primary(BuildContext context) => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryLight,
  );

  static TextStyle bold12White(BuildContext context) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle bold24White(BuildContext context) => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle bold14Black(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.onBackground,
  );

  static TextStyle bold14White(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );

  static TextStyle bold14Primary(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).primaryColor,
  );

  static TextStyle bold16Primary(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryLight,
  );

  static TextStyle bold16White(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle bold20Black(BuildContext context) => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );

  static TextStyle bold200Black(BuildContext context) => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );

  static TextStyle regular14White(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static TextStyle medium16Gray(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  static TextStyle medium16White(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle medium16Primary(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryLight,
  );

  static TextStyle medium14White(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle medium20White(BuildContext context) => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle medium20Primary(BuildContext context) => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryLight,
  );

  static TextStyle medium16Black(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
  );

  static TextStyle medium16Grey(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  static TextStyle regular20White(BuildContext context) => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: AppColors.whiteColor,
  );
}
