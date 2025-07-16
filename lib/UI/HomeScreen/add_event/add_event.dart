import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:eventlyapp/Model/event.dart';
import 'package:eventlyapp/Tabs/home/tab_event_widget.dart';
import 'package:eventlyapp/Tabs/widget/choose_date_or_time.dart';
import 'package:eventlyapp/Tabs/widget/custem_text_feild.dart';
import 'package:eventlyapp/Tabs/widget/custom_elevated_button.dart';
import 'package:eventlyapp/UI/HomeScreen/add_event/location_service/lolo_services.dart';
import 'package:eventlyapp/firebase_utlis.dart';
import 'package:eventlyapp/providers/event_list_provider.dart';
import 'package:eventlyapp/providers/location_provider.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:eventlyapp/utils/app_assets.dart';
import 'package:eventlyapp/utils/flutter_toast.dart';
import 'package:eventlyapp/utils/styles.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../providers/user_provider.dart';
import '../home_screen.dart';

class AddEvent extends StatefulWidget {
  static const String routeName = 'addEvent';

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var formKey = GlobalKey<FormState>();
  LatLng? selectedLocation;
  String? eventAddress;
  String? formatedDate;
  DateTime? selectedDate;
  String formatedTime = '';
  TimeOfDay? selectedTime;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  String selectedEvent = 'sport';
  late EventListProvider eventListProvider;
  String selectedImage = '';
  LatLng? selectedLatLng;

  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
    eventListProvider.getEventNameList(context);
    eventListProvider.eventsNameList.removeAt(0);
    var userProvider = Provider.of<UserProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var locationProvider = Provider.of<LocationProvider>(context);
    locationProvider.userLocation ??
        locationProvider.getCurrentLocation(context);

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
        iconTheme: IconThemeData(color: AppColors.primaryLight),

        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: AppStyles.medium20Primary(context),
        ),

        backgroundColor: themeProvider.apptheme == ThemeMode.dark
            ? AppColors.primaryDark
            : AppColors.whiteColor,
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
                      style: themeProvider.apptheme == ThemeMode.dark
                          ? AppStyles.medium16White(context)
                          : AppStyles.medium16Black(context),
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
                      hintText: AppLocalizations.of(context)!.event_title,
                      style: AppStyles.medium16Black(context),
                      prefixIcon: Image.asset(AseetsMnger.iconTitle),
                    ),
                    SizedBox(height: height * .02),
                    Text(
                      AppLocalizations.of(context)!.description,
                      style: themeProvider.apptheme == ThemeMode.dark
                          ? AppStyles.medium16White(context)
                          : AppStyles.medium16Black(context),
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

                      hintText: AppLocalizations.of(context)!.event_description,

                      maxLines: 4,

                      style: AppStyles.medium16Black(context),
                    ),
                    SizedBox(height: height * .02),
                    ChooseDateOrTime(
                      chooseEventDateOrTime: selectedDate == null
                          ? AppLocalizations.of(context)!.choose_date
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      eventDateOrTime: AppLocalizations.of(context)!.event_date,
                      onChooseDateOrTimeClicked: chooseDate,
                      iconName: themeProvider.apptheme == ThemeMode.dark
                          ? AseetsMnger.date
                          : AseetsMnger.iconDate,
                    ),
                    SizedBox(height: height * .02),
                    ChooseDateOrTime(
                      chooseEventDateOrTime: selectedTime == null
                          ? AppLocalizations.of(context)!.choose_time
                          : formatedTime,
                      eventDateOrTime: AppLocalizations.of(context)!.event_time,
                      onChooseDateOrTimeClicked: chooseTime,
                      iconName: themeProvider.apptheme == ThemeMode.dark
                          ? AseetsMnger.iconTime
                          : AseetsMnger.iconTime1,
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
                      text: AppLocalizations.of(context)!.add_event,
                      onButtonClicked: addEvent,
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

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      Event event = Event(
        description: descriptionController.text,
        title: titleController.text,
        dateTime: selectedDate!,
        image: selectedImage,
        time: formatedTime,
        eventName: selectedEvent,
        address: eventAddress,
        late: selectedLatLng?.latitude,
        long: selectedLatLng?.longitude,
      );
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      FirebaseUtlis.addEventToFirebase(event, userProvider.currentUser!.id)
          .then((Value) {
            print('Event Added Successfully');
            ToastMessage.toastMsg('Event Added Successfully');
            eventListProvider.getAllEvents(userProvider.currentUser!.id);
            Navigator.pushReplacementNamed(context, Homescreen.routeName);
          })
          .timeout(
            Duration(milliseconds: 500),
            onTimeout: () {
              print('Event Added Successfully');
              ToastMessage.toastMsg('Event Added Successfully');
              eventListProvider.getAllEvents(userProvider.currentUser!.id);
              Navigator.pop(context);
            },
          );
    }
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
