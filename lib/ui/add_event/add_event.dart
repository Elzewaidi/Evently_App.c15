import 'package:eventlyapp/l10n/app_localizations.dart';
import 'package:eventlyapp/ui/add_event/widgets/event_date_or_time.dart';
import 'package:eventlyapp/ui/home_tab/widget/event_tab_item.dart';
import 'package:eventlyapp/ui/widgets/custom_elevated_button.dart';
import 'package:eventlyapp/ui/widgets/custom_text_form_field.dart';
import 'package:eventlyapp/utils/app_assets.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:eventlyapp/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/app_theme_provider.dart';

class AddEvent extends StatefulWidget {
  AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  DateTime? selectedDate;
  String? formatDate;
  TimeOfDay? selectedTime;
  String? formatTime;
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    List<String> eventNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    List<String> eventImageLightList = [
      AppAssets.sportImageLight,
      AppAssets.birthdayImageLight,
      AppAssets.meetingImageLight,
      AppAssets.gammingImageLight,
      AppAssets.workShopImageLight,
      AppAssets.bookClubImageLight,
      AppAssets.exhibitionImageLight,
      AppAssets.holidayImageLight,
      AppAssets.eatingImageLight,
    ];
    List<String> eventImageDarkList = [
      AppAssets.sportImageDark,
      AppAssets.birthdayImageDark,
      AppAssets.meetingImageDark,
      AppAssets.gammingImageDark,
      AppAssets.workShopImageDark,
      AppAssets.bookClubImageDark,
      AppAssets.exhibitionImageDark,
      AppAssets.holidayImageDark,
      AppAssets.eatingImageDark,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: AppStyles.medium20Primary,
        ),
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .02,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: ClipRRect(
                  child: themeProvider.iSDark()
                      ? Image.asset(
                          eventImageDarkList[selectedIndex],
                          height: height * .2,
                        )
                      : Image.asset(
                          eventImageLightList[selectedIndex],
                          height: height * .2,
                        ),

                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              SizedBox(height: height * .02),
              SizedBox(
                height: height * .04,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        selectedIndex = index;
                        setState(() {});
                      },
                      child: EventTabItem(
                        isSelectedBgColor: AppColors.primaryLight,
                        selecetdEventTextStyle: Theme.of(
                          context,
                        ).textTheme.labelMedium,
                        eventName: eventNameList[index],
                        unSelecetdEventTextStyle: AppStyles.bold16Primary,
                        borderColor: AppColors.primaryLight,
                        isSelected: selectedIndex == index,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: width * .01);
                  },
                  itemCount: eventNameList.length,
                ),
              ),
              SizedBox(height: height * .02),
              Text(
                AppLocalizations.of(context)!.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: height * .02),
              CustomTextFormField(
                controller: eventTitleController,
                hintText: AppLocalizations.of(context)!.event_time,
                prefixIcon: Image.asset(
                  AppAssets.editIcon,
                  color: themeProvider.iSDark()
                      ? AppColors.whiteColor
                      : AppColors.greyColor,
                ),
              ),
              SizedBox(height: height * .02),
              Text(
                AppLocalizations.of(context)!.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: height * .02),
              CustomTextFormField(
                controller: eventDescriptionController,
                hintText: AppLocalizations.of(context)!.event_description,
                maxLines: 4,
              ),
              SizedBox(height: height * .02),
              EventDateOrTime(
                eventDateOrItemIcon: AppAssets.eventDateIcon,
                eventDateOrItemName: AppLocalizations.of(context)!.event_date,
                chooseDateOrTime: selectedDate == null
                    ? AppLocalizations.of(context)!.choose_date
                    : formatDate!,
                chooseDateOrTimeClicked: ChooseDate,
              ),
              EventDateOrTime(
                eventDateOrItemIcon: AppAssets.eventTimeIcon,
                eventDateOrItemName: AppLocalizations.of(context)!.event_time,
                chooseDateOrTime: selectedTime == null
                    ? AppLocalizations.of(context)!.choose_time
                    : formatTime!,
                chooseDateOrTimeClicked: ChooseTime,
              ),
              SizedBox(height: height * .02),
              Text(
                AppLocalizations.of(context)!.location,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: height * .01),
              CustomElevatedButton(
                backgroundColor: AppColors.transparentColor,
                text: '',
                isIcon: true,
                iconWidget: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .02),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * .02,
                          vertical: height * .01,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primaryLight,
                        ),
                        child: Image.asset(AppAssets.locationIcon),
                      ),
                      SizedBox(width: width * .02),
                      Text(
                        AppLocalizations.of(context)!.choose_event_location,
                        style: AppStyles.medium16Primary,
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
                onPressed: AddEvent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void ChooseDate() async {
    var chooseDate = await showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = chooseDate;
    formatDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    setState(() {});
  }

  void ChooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    formatTime = selectedTime!.format(context);
    setState(() {});
  }

  void AddEvent() {}
}
