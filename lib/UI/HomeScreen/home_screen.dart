import 'package:eventlyapp/Tabs/favourite/favourite_tab.dart';
import 'package:eventlyapp/Tabs/home/home_tab.dart';
import 'package:eventlyapp/Tabs/map/map_tab.dart';
import 'package:eventlyapp/Tabs/profile/profile_tab.dart';
import 'package:eventlyapp/UI/HomeScreen/add_event/add_event.dart';
import 'package:eventlyapp/l10n/app_localizations.dart';
import 'package:eventlyapp/utils/app_assets.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  static const String routeName = 'Homescreen';

  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTap(), FavoriteTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(
          context,
        ).copyWith(canvasColor: AppColors.transparentColor),
        child: BottomAppBar(
          color: Theme.of(context).primaryColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 4,
          padding: EdgeInsets.zero,

          child: SingleChildScrollView(
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              selectedItemColor: AppColors.whiteColor,
              items: [
                buildBottomNavitems(
                  iconName: AseetsMnger.iconHome,
                  index: 0,
                  iconSelectedName: AseetsMnger.iconeSelectedHome,
                  labelName: AppLocalizations.of(context)!.home,
                ),
                buildBottomNavitems(
                  iconName: AseetsMnger.iconMap,
                  index: 1,
                  iconSelectedName: AseetsMnger.iconMapSelected,
                  labelName: AppLocalizations.of(context)!.map,
                ),
                buildBottomNavitems(
                  iconName: AseetsMnger.favorate,
                  index: 2,
                  iconSelectedName: AseetsMnger.favorateSelcted,
                  labelName: AppLocalizations.of(context)!.favorite,
                ),
                buildBottomNavitems(
                  iconName: AseetsMnger.iconProfaile,
                  index: 3,
                  iconSelectedName: AseetsMnger.iconSelectedProfile,
                  labelName: AppLocalizations.of(context)!.profile,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigate to event screen
          //add event
          Navigator.of(context).pushNamed(AddEvent.routeName);
        },
        child: Icon(Icons.add, color: AppColors.whiteColor, size: 25),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  BottomNavigationBarItem buildBottomNavitems({
    required int index,
    required String iconName,
    required String labelName,
    required String iconSelectedName,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(selectedIndex == index ? iconSelectedName : iconName),
      ),
      label: labelName,
    );
  }
}
