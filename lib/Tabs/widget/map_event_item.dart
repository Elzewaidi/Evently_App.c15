import 'package:eventlyapp/Model/event.dart';
import 'package:eventlyapp/providers/event_list_provider.dart';
import 'package:eventlyapp/utils/app_assets.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:eventlyapp/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapEventItem extends StatelessWidget {
  Event event;

  MapEventItem({required this.event});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * .02,
        vertical: height * .02,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: width * .02,
      ).copyWith(right: width * .16, bottom: height * 0.05),
      height: height * .20,
      constraints: BoxConstraints(maxWidth: width * .83),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        spacing: 15,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRect(child: Image.asset(event.image, width: width * .4)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.bold20Primary(
                      context,
                    ).copyWith(fontSize: 16),
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      AseetsMnger.iconMap,
                      color: AppColors.blackColor,
                    ),
                    Expanded(
                      child: Text(
                        event.address ?? "",
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.bold20Primary(
                          context,
                        ).copyWith(fontSize: 10, color: AppColors.blackColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
