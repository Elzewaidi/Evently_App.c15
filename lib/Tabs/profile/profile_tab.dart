import 'package:eventlyapp/Tabs/widget/custom_elevated_button.dart';
import 'package:eventlyapp/UI/auth/login/login.dart';
import 'package:eventlyapp/UI/langugebottomsheet.dart';
import 'package:eventlyapp/UI/themebottomsheet.dart';
import 'package:eventlyapp/l10n/app_localizations.dart';
import 'package:eventlyapp/providers/app_theme_provider.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:eventlyapp/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/users.dart';
import '../../providers/app_languge_provider.dart';
import '../../providers/event_list_provider.dart' show EventListProvider;
import '../../providers/user_provider.dart';

class ProfileTab extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<ProfileTab> createState() => _HomeScreenState();
}

MyUser? myUser;

class _HomeScreenState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var LanguageProvider = Provider.of<AppLangugeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: height * .04,
              left: width * .04,
              right: width * .02,
            ),
            height: height * .25,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                //Image.asset(AseetsMnger.trImage),
                SizedBox(width: width * .02),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        userProvider.currentUser!.name,
                        style: AppStyles.bold24White(context),
                      ),
                      Text(
                        userProvider.currentUser!.email,
                        style: AppStyles.medium16White(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: AppStyles.bold20Black(context),
                ),
                SizedBox(height: height * 0.02),
                InkWell(
                  onTap: () {
                    showLangugeBottomSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primaryLight,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LanguageProvider.appLanguage == 'en'
                              ? AppLocalizations.of(context)!.english
                              : AppLocalizations.of(context)!.arabic,
                          style: AppStyles.bold20Primary(context),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.primaryLight,
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: AppStyles.bold20Black(context),
                ),
                SizedBox(height: height * 0.02),
                InkWell(
                  onTap: () {
                    showThemeBottomSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primaryLight,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          themeProvider.apptheme == ThemeMode.dark
                              ? AppLocalizations.of(context)!.dark
                              : AppLocalizations.of(context)!.light,
                          style: AppStyles.bold20Primary(context),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.primaryLight,

                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * .04,
              vertical: height * .04,
            ),
            child: CustomElevatedButton(
              onButtonClicked: () {
                //todo remove event list
                eventListProvider.filterEventList = [];
                Navigator.of(
                  context,
                ).pushReplacementNamed(LoginScreen.routeName);
              },

              text: AppLocalizations.of(context)!.logout,
              backGroundColor: AppColors.primaryLight,
              prefixIconButton: Icon(
                Icons.logout,
                color: Theme.of(context).canvasColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLangugeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => langugeBottomSheet(),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => themeBottomSheet(),
    );
  }
}
