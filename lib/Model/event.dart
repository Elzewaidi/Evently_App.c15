import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  //dataclass
  static const String collectionName = 'Events';
  String id;
  String image;
  String title;
  String description;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavorite;
  String? linkedEventId;
  double? long;
  double? late;
  String? address;

  Event({
    required this.description,
    required this.title,
    required this.dateTime,
    required this.image,
    required this.time,
    required this.eventName,
    this.isFavorite = false,
    this.id = '',
    this.late,
    this.address,
    this.long,
  });

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'event_Name': eventName,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'description': description,
      'isFavorite': isFavorite,
      'image': image,
      'linkedEventId': linkedEventId,
      'long': long,
      'late': late,
      'address': address,
    };
  }

  Event.fromFireStore(Map<String, dynamic> data)
    : this(
        id: data['id'],
        eventName: data['event_Name'],
        image: data['image'],
        isFavorite: data['isFavorite'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
        description: data['description'],
        time: data['time'],
        title: data['title'],
        late: data['late'],
        long: data['long'],
        address: data['address'],
      );
}
