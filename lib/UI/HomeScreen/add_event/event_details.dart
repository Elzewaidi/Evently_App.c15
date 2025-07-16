import 'package:eventlyapp/Model/event.dart';
import 'package:eventlyapp/UI/HomeScreen/add_event/edit_event.dart';
import 'package:eventlyapp/providers/app_theme_provider.dart';
import 'package:eventlyapp/providers/event_list_provider.dart';
import 'package:eventlyapp/providers/user_provider.dart';
import 'package:eventlyapp/utils/app_assets.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:eventlyapp/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatelessWidget {
  static const String routeName = 'EventDetails';
  String selectedImage = '';

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final event = ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.apptheme == ThemeMode.dark
            ? AppColors.primaryDark
            : AppColors.whiteColor,
        actions: [
          IconButton(
            icon: Image.asset(AseetsMnger.editIcon),
            onPressed: () {
              Navigator.pushNamed(
                context,
                EditEvent.routeName,
                arguments: event,
              );
              // Action for editing
            },
          ),
          IconButton(
            icon: Image.asset(AseetsMnger.removeIcon),
            onPressed: () {
              final eventProvider = Provider.of<EventListProvider>(
                context,
                listen: false,
              );
              final userProvider = Provider.of<UserProvider>(
                context,
                listen: false,
              );

              eventProvider.deleteEvent(event, userProvider.currentUser!.id);
              Navigator.pop(context);
            },
          ),
        ],
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: AppStyles.bold20Primary(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .02,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  height: height * .24,
                  event.image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: height * .02),
              Center(
                child: Text(
                  event.title,
                  style: AppStyles.bold20Primary(context),
                ),
              ),
              SizedBox(height: height * .02),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .02,
                  vertical: height * .01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 2),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * .02,
                        vertical: height * .01,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(AseetsMnger.date),
                    ),
                    SizedBox(width: width * .02),
                    Text(
                      '${event.dateTime.day}/${event.dateTime.month}/${event.dateTime.year}',
                      style: AppStyles.bold16Primary(context),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColors.primaryLight,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .02),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .02,
                  vertical: height * .01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 2),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * .02,
                        vertical: height * .01,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(AseetsMnger.locationIcon),
                    ),
                    SizedBox(width: width * .02),
                    Text(
                      '${event.dateTime.day}/${event.dateTime.month}/${event.dateTime.year}',
                      style: AppStyles.bold16Primary(context),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColors.primaryLight,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .02),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryLight, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(30.0444, 31.2357), //
                      zoom: 14,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('1'),
                        position: LatLng(30.0444, 31.2357),
                      ),
                    },
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                  ),
                ),
              ),
              SizedBox(height: height * .02),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.description,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(height: height * .01),
              SizedBox(
                height: height * .2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      // padding: const EdgeInsets.all(12),
                      // decoration: BoxDecoration(
                      //   border: Border.all(
                      //
                      //     width: 1,
                      //   ), //
                      //   borderRadius: BorderRadius.circular(12),
                      // ),
                      child: SingleChildScrollView(
                        child: Text(
                          event.description,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
