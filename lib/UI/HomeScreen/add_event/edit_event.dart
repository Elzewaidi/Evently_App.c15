import 'package:eventlyapp/UI/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../Model/event.dart';
import '../../../Tabs/home/tab_event_widget.dart';
import '../../../Tabs/widget/choose_date_or_time.dart';
import '../../../Tabs/widget/custem_text_feild.dart';
import '../../../Tabs/widget/custom_elevated_button.dart';
import '../../../firebase_utlis.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../providers/event_list_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/flutter_toast.dart';
import '../../../utils/styles.dart';
import 'location_service/lolo_services.dart';

class EditEvent extends StatefulWidget {
  static const String routeName = 'EditEvent';

  @override
  State<EditEvent> createState() => _EditEventState();
}

String? eventAddress;
LatLng? selectedLatLng;

var formKey = GlobalKey<FormState>();
String? formatedDate;
DateTime? selectedDate;
String formatedTime = '';
TimeOfDay? selectedTime;
var titleController = TextEditingController();
var descriptionController = TextEditingController();

String selectedEvent = 'sport';
late EventListProvider eventListProvider;
String selectedImage = '';

class _EditEventState extends State<EditEvent> {
  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    eventListProvider.getEventNameList(context);
    eventListProvider.eventsNameList.removeAt(0);
    var userProvider = Provider.of<UserProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    final event = ModalRoute.of(context)!.settings.arguments as Event;
    List<String> imageNameList = [
      AseetsMnger.sportImage,
      AseetsMnger.birthday,
      AseetsMnger.meeting,
      AseetsMnger.gaming,
      AseetsMnger.workShop,
      AseetsMnger.bookClub,
      AseetsMnger.exhibtion,
      AseetsMnger.holiday,
      AseetsMnger.eating,
    ];
    selectedImage = imageNameList[eventListProvider.selectedIndex];
    selectedEvent =
        eventListProvider.eventsNameList[eventListProvider.selectedIndex];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.apptheme == ThemeMode.dark
            ? AppColors.primaryDark
            : AppColors.whiteColor,

        iconTheme: IconThemeData(color: AppColors.primaryLight),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.edit_event,
          style: AppStyles.bold20Primary(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .02,
          vertical: height * .02,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  height: height * .24,
                  selectedImage,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: height * .02),
              Container(
                height: height * .036,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(width: width * .02);
                  },
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        event.eventName;
                        eventListProvider.changeSelectedIndex(
                          index,
                          userProvider.currentUser!.id,
                        );
                      },
                      child: TabEventWidget(
                        borderColor: AppColors.primaryLight,
                        isSelected: eventListProvider.selectedIndex == index,
                        eventName: eventListProvider.eventsNameList[index],
                        backGroundColor: AppColors.primaryLight,
                        textSelectedStyle: AppStyles.medium16White(context),
                        textUnSelectedStyle: AppStyles.medium16Primary(context),
                      ),
                    );
                  },
                  itemCount: eventListProvider.eventsNameList.length,
                ),
              ),
              SizedBox(height: height * .01),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: AppStyles.medium16Black(context),
                    ),
                    SizedBox(height: height * .01),
                    CustomTextFiled(
                      controller: titleController,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please enter event description';
                        }
                        return null;
                      },
                      hintText: event.title,
                      style: AppStyles.medium16Black(context),
                      prefixIcon: Image.asset(AseetsMnger.iconTitle),
                    ),
                    SizedBox(height: height * .02),
                    Text(
                      AppLocalizations.of(context)!.description,
                      style: AppStyles.medium16Black(context),
                    ),
                    SizedBox(height: height * .02),
                    CustomTextFiled(
                      controller: descriptionController,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please enter event title';
                        }
                        return null;
                      },

                      hintText: event.description,

                      maxLines: 4,

                      style: AppStyles.medium16Black(context),
                    ),
                    SizedBox(height: height * .02),
                    ChooseDateOrTime(
                      chooseEventDateOrTime: selectedDate == null
                          ? '${event.dateTime.day}/${event.dateTime.month}/${event.dateTime.year}'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      eventDateOrTime: AppLocalizations.of(context)!.event_date,
                      onChooseDateOrTimeClicked: chooseDate,
                      iconName: AseetsMnger.iconDate,
                    ),
                    SizedBox(height: height * .02),
                    ChooseDateOrTime(
                      chooseEventDateOrTime: selectedTime == null
                          ? event.time
                          : formatedTime,
                      eventDateOrTime: AppLocalizations.of(context)!.event_time,
                      onChooseDateOrTimeClicked: chooseTime,
                      iconName: AseetsMnger.iconTime1,
                    ),
                    SizedBox(height: height * .01),
                    InkWell(
                      onTap: () async {
                        LatLng? locationLatLng =
                            await LocationServices.pickedLocation(context);
                        if (locationLatLng != null) {
                          onLocationPicked(locationLatLng);
                          setState(() {});
                        }
                      },

                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * .02,
                          vertical: height * .01,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primaryLight,
                            width: 2,
                          ),
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
                            Expanded(
                              child: Text(
                                eventAddress ??
                                    AppLocalizations.of(
                                      context,
                                    )!.choose_event_location,
                                style: AppStyles.bold16Primary(context),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColors.primaryLight,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * .02),
                    CustomElevatedButton(
                      text: AppLocalizations.of(context)!.update_event,
                      onButtonClicked: () {
                        if (formKey.currentState!.validate()) {
                          final updatedEvent = Event(
                            id: event.id,
                            title: titleController.text.isEmpty
                                ? event.title
                                : titleController.text,
                            description: descriptionController.text.isEmpty
                                ? event.description
                                : descriptionController.text,
                            dateTime: selectedDate ?? event.dateTime,
                            time: selectedTime == null
                                ? event.time
                                : selectedTime!.format(context),
                            image: event.image,
                            eventName: event.eventName,
                            isFavorite: event.isFavorite,
                          );

                          eventListProvider.updateEvent(
                            updatedEvent,
                            userProvider.currentUser!.id,
                          );

                          Navigator.of(
                            context,
                          ).pushReplacementNamed(Homescreen.routeName);
                        }
                      },
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

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    setState(() {
      selectedDate = chooseDate;
      //formatedDate=DateFormat('dd-mm-yyyy').format(selectedDate!);
    });
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    formatedTime = selectedTime!.format(context);
    setState(() {
      formatedTime = selectedTime!.format(context);
    });
  }

  void onLocationPicked(LatLng location) async {
    selectedLatLng = location;
    if (selectedLatLng != null) {
      eventAddress = await LocationServices.getLocationDetails(selectedLatLng!);
      setState(() {});
    }
  }
}
