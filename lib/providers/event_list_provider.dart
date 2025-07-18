import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyapp/firebase_utlis.dart';
import 'package:eventlyapp/l10n/app_localizations.dart';
import 'package:eventlyapp/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/event.dart';
import '../utils/flutter_toast.dart';

class EventListProvider extends ChangeNotifier {
  //data
  int selectedIndex = 0;

  List<String> eventsNameList = [];
  List<Event> filterEventList = [];
  List<Event> eventsList = [];
  List<Event> isFavoriteList = [];

  //function
  DateTime? dateTime;

  void getEventNameList(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    eventsNameList = [
      AppLocalizations.of(context)!.all,
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
  }

  void getAllEvents(String uId) async {
    // list --->//list<QuerySnapshot>
    print('in first get all events');
    QuerySnapshot<Event> querySnapshot = await FirebaseUtlis.getEventCollection(
      uId,
    ).get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    print('in end get all events');
    eventsList.sort((Event event, Event event2) {
      return event.dateTime.compareTo(event2.dateTime);
    });
    filterEventList = eventsList;
    notifyListeners();
  }

  void getFilterEvents(String uId) async {
    // list --->//list<QuerySnapshot>
    print('in first get all events');

    QuerySnapshot<Event> querySnapshot = await FirebaseUtlis.getEventCollection(
      uId,
    ).get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    //todo:filter
    filterEventList = eventsList.where((event) {
      return event.eventName == eventsNameList[selectedIndex];
    }).toList();
    //todo:sorting
    eventsList.sort((Event event, Event event2) {
      return event.dateTime.compareTo(event2.dateTime);
    });

    notifyListeners();
  }

  void getFavoriteEvent(String uId) async {
    var querySnapShot = await FirebaseUtlis.getEventCollection(uId)
        .orderBy('dateTime', descending: false)
        .where('isFavorite', isEqualTo: true)
        .get();
    isFavoriteList = querySnapShot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void changeSelectedIndex(newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;
    if (selectedIndex == 0) {
      getAllEvents(uId);
    } else {
      getFilterEvents(uId);
    }
  }

  void deleteEvent(Event event, String uId) async {
    try {
      await FirebaseUtlis.getEventCollection(uId).doc(event.id).delete();

      print('🗑️ Event deleted successfully');
      ToastMessage.toastMsg('🗑️ Event deleted successfully');

      selectedIndex == 0 ? getAllEvents(uId) : getFilterEvents(uId);
      getFavoriteEvent(uId);
    } catch (e) {
      print('❌ Error deleting event: $e');
      ToastMessage.toastMsg('❌ Error deleting event');
    }
  }

  void updateIsFavorite(Event event, String uId) {
    FirebaseUtlis.getEventCollection(uId)
        .doc(event.id)
        .update({'isFavorite': !event.isFavorite})
        .then((onValue) {
          print('updated successfully');
          ToastMessage.toastMsg('updated successfully');
        })
        .timeout(
          Duration(milliseconds: 500),
          onTimeout: () {
            print('updated successfully');
            ToastMessage.toastMsg('updated successfully');
            selectedIndex == 0 ? getAllEvents(uId) : getFilterEvents(uId);
            getFavoriteEvent(uId);
            //notifyListeners();
          },
        );
  }

  void updateEvent(Event event, String uId) async {
    try {
      await FirebaseUtlis.getEventCollection(uId).doc(event.id).update({
        'title': event.title,
        'dateTime': event.dateTime.millisecondsSinceEpoch,
        'description': event.description,
        'image': event.image,
        'time': event.time,
        'event_Name': event.eventName,
        'isFavorite': event.isFavorite,
      });

      print('Event updated successfully');
      ToastMessage.toastMsg('✅ Event updated successfully');

      selectedIndex == 0 ? getAllEvents(uId) : getFilterEvents(uId);
      getFavoriteEvent(uId);
    } catch (e) {
      print('❌ Failed to update event: $e');
      ToastMessage.toastMsg('❌ Failed to update event: $e');
    }
  }
}
