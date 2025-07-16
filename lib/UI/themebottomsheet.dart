import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eventlyapp/providers/app_languge_provider.dart';
import 'package:eventlyapp/providers/app_theme_provider.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:eventlyapp/utils/styles.dart';

class themeBottomSheet extends StatefulWidget {
  const themeBottomSheet({super.key});

  @override
  State<themeBottomSheet> createState() => _themeBottomSheetState();
}

class _themeBottomSheetState extends State<themeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var heghit = MediaQuery
        .of(context)
        .size
        .height;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child:
            themeProvider.isDarkMode()
                ? getselecteditemwidget(AppLocalizations.of(context)!.dark)
                : getunselecteditemwidget(
              AppLocalizations.of(context)!.dark,
            ),
          ),
          SizedBox(height: heghit * 0.02),
          InkWell(
            onTap: () {
              //change theme
              themeProvider.changeTheme(ThemeMode.light);
            },
            child:
            themeProvider.apptheme == ThemeMode.light
                ? getselecteditemwidget(AppLocalizations.of(context)!.light)
                : getunselecteditemwidget(
              AppLocalizations.of(context)!.light,
            ),
          ),
        ],
      ),
    );
  }

  Widget getselecteditemwidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: AppStyles.bold20Primary(context)),
        Icon(Icons.check, color: AppColors.primaryLight, size: 25),
      ],
    );
  }

  Widget getunselecteditemwidget(String text) {
    return Text(text, style: AppStyles.bold200Black(context));

  }
}
