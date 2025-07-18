import 'package:eventlyapp/Tabs/home/event_item_widget.dart';
import 'package:eventlyapp/Tabs/home/tab_event_widget.dart';
import 'package:eventlyapp/UI/themebottomsheet.dart';
import 'package:eventlyapp/l10n/app_localizations.dart';
import 'package:eventlyapp/providers/event_list_provider.dart';
import 'package:eventlyapp/utils/app_assets.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:eventlyapp/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_languge_provider.dart';
import '../../providers/user_provider.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool isDataFetched = false;
  @override
  Widget build(BuildContext context) {
    var LanguageProvider = Provider.of<AppLangugeProvider>(context);

    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    if (!isDataFetched && eventListProvider.eventsList.isEmpty) {
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
      isDataFetched = true;
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider.getEventNameList(context);
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: AppStyles.regular20White(context),
                ),
                Text(
                  userProvider.currentUser!.name,
                  style: AppStyles.bold24White(context),
                ),
              ],
            ),

            Row(
              children: [
                InkWell(
                    onTap: () {
                      showThemeBottomSheet();
                    },
                    child: Icon(Icons.sunny, color: AppColors.whiteColor)),
                SizedBox(width: width * .02),
                Container(

                  margin: EdgeInsets.only(right: width * .02),
                  padding: EdgeInsets.symmetric(
                    horizontal: width * .01,
                    vertical: height * 0.01,
                  ),
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.whiteColor,
                  ),
                  child: Text(LanguageProvider.appLanguage == 'en'
                      ? 'EN'
                      : 'عربي', style: AppStyles.bold14Primary(context)),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            height: height * 0.1,
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(AseetsMnger.iconMap),
                    SizedBox(width: width * .01),
                    Text('Cairo,Egypt',
                        style: AppStyles.regular20White(context)),
                  ],
                ),
                SizedBox(height: height * .02),
                DefaultTabController(
                  length: eventListProvider.eventsNameList.length,
                  child: TabBar(
                    onTap: (index) {
                      eventListProvider.changeSelectedIndex(
                        index,
                        userProvider.currentUser!.id,
                      );
                      setState(() {});
                    },
                    tabAlignment: TabAlignment.start,
                    indicatorColor: AppColors.transparentColor,
                    dividerColor: AppColors.transparentColor,
                    isScrollable: true,
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.01,
                    ),
                    tabs:
                    eventListProvider.eventsNameList.map((eventName) {
                      return TabEventWidget(
                        backGroundColor: AppColors.whiteColor,
                        textSelectedStyle: AppStyles.medium16Primary(context),
                        textUnSelectedStyle: AppStyles.medium16White(context),

                        isSelected:
                        eventListProvider.selectedIndex ==
                            eventListProvider.eventsNameList.indexOf(
                              eventName,
                            ),
                        eventName: eventName,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
            eventListProvider.filterEventList.isEmpty
                ? Center(
              child: Text(
                AppLocalizations.of(context)!.no_event_found,
                style: AppStyles.bold16Primary(context),
              ),
            )
                : ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * .04,
                  ),
                  child: EventItemWidget(
                    event: eventListProvider.filterEventList[index],
                  ),
                );
              },
              itemCount: eventListProvider.filterEventList.length,
            ),
          ),
        ],
      ),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => themeBottomSheet(),
    );
  }
}
