import 'package:eventlyapp/Tabs/home/event_item_widget.dart';
import 'package:eventlyapp/Tabs/widget/custem_text_feild.dart';
import 'package:eventlyapp/l10n/app_localizations.dart';
import 'package:eventlyapp/providers/event_list_provider.dart';
import 'package:eventlyapp/utils/app_assets.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:eventlyapp/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/event.dart';
import '../../providers/user_provider.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

List<Event> _filteredList = [];
String _searchQuery = '';


class _FavoriteTabState extends State<FavoriteTab> {
  @override
  Widget build(BuildContext context) {
    var favoriteListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    if (favoriteListProvider.isFavoriteList.isEmpty) {
      favoriteListProvider.getFavoriteEvent(userProvider.currentUser!.id);
    } else if (_filteredList.isEmpty && _searchQuery.isEmpty) {
      _filteredList = List.from(favoriteListProvider.isFavoriteList);
    }


    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Column(
          children: [
            CustomTextFiled(
              onChanged: filterSearchResults,
              style: AppStyles.medium16Primary(context),
              hintText: AppLocalizations.of(context)!.search_event,
              hintStyle: AppStyles.bold14Primary(context),
              prefixIcon: Image.asset(
                AseetsMnger.iconSearch,
                color: AppColors.primaryLight,
              ),
              borderColor: AppColors.primaryLight,
            ),

            Expanded(
              child: _filteredList.isEmpty
                  ? Center(
                child: Text(
                  AppLocalizations.of(context)!.no_event_found,
                ),
              )
                  : ListView.builder(
                itemCount: _filteredList.length,
                itemBuilder: (context, index) {
                  return EventItemWidget(
                    event: _filteredList[index],
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }

  void filterSearchResults(String query) {
    final provider = Provider.of<EventListProvider>(context, listen: false);
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredList = List.from(provider.isFavoriteList);
      } else {
        _filteredList = provider.isFavoriteList.where((event) {
          final title = event.title.toLowerCase() ?? '';
          return title.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

}
