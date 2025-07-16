import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:eventlyapp/Model/event.dart';
import 'package:eventlyapp/UI/HomeScreen/add_event/event_details.dart';
import 'package:eventlyapp/providers/event_list_provider.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:eventlyapp/utils/app_assets.dart';
import 'package:eventlyapp/utils/styles.dart';

import '../../providers/user_provider.dart';

class EventItemWidget extends StatelessWidget {
  Event event;

  EventItemWidget({required this.event});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EventDetails.routeName, arguments: event);
      },
      child: Container(
        height: height * 0.31,
        margin: EdgeInsets.symmetric(vertical: height * .01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.primaryLight, width: 2),
          image: DecorationImage(
            image: AssetImage(event.image),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * .02),
              margin: EdgeInsets.symmetric(
                horizontal: width * .02,
                vertical: height * .01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Column(
                children: [
                  Text(
                    '${event.dateTime.day}',
                    style: AppStyles.bold20Primary(context),
                  ),
                  Text(
                    DateFormat('MMM').format(event.dateTime),
                    style: AppStyles.bold20Primary(context),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * .02,
                vertical: height * .01,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: width * .02,
                vertical: height * .01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.whiteColor,
              ),
              child: Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      style: AppStyles.bold14Black(context),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      eventListProvider.updateIsFavorite(
                        event,
                        userProvider.currentUser!.id,
                      );
                    },
                    child: Image.asset(
                      event.isFavorite
                          ? AseetsMnger.favorateSelcted
                          : AseetsMnger.favorate,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
