import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eventlyapp/providers/app_languge_provider.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:eventlyapp/utils/styles.dart';

class langugeBottomSheet extends StatefulWidget {
  const langugeBottomSheet({super.key});

  @override
  State<langugeBottomSheet> createState() => _langugeBottomSheetState();
}

class _langugeBottomSheetState extends State<langugeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var LanguageProvider = Provider.of<AppLangugeProvider>(context);
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
                LanguageProvider.changeLanguage('en');
              },
              child: LanguageProvider.appLanguage == 'en' ?
              getselecteditemwidget(AppLocalizations.of(context)!.english) :
              getunselecteditemwidget(AppLocalizations.of(context)!.english)),
          SizedBox(height: heghit * 0.02,),
          InkWell(onTap: () {
            LanguageProvider.changeLanguage('ar');
          },
              child: LanguageProvider.appLanguage == 'ar' ?
              getselecteditemwidget(AppLocalizations.of(context)!.arabic) :
              getunselecteditemwidget(AppLocalizations.of(context)!.arabic))
        ],
      ),
    );
  }

  Widget getselecteditemwidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: AppStyles.bold20Primary(context),),
        Icon(Icons.check, color: AppColors.primaryLight, size: 25,)
      ],
    );
  }

  Widget getunselecteditemwidget(String text) {
    return Text(text, style: AppStyles.bold200Black(context),);
  }
}
