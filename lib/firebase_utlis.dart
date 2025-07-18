import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyapp/Model/event.dart';
import 'package:eventlyapp/Model/users.dart';

class FirebaseUtlis {

  static CollectionReference<Event> getEventCollection(String uId) {
    return getUsersCollection().doc(uId).collection(Event.collectionName)
        .withConverter<Event>(
      fromFirestore:
          (snapshot, option) => Event.fromFireStore(snapshot.data()!),
      toFirestore: (Event, _) => Event.toFireStore(),
    );
  }

  static CollectionReference <MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(fromFirestore: (snapshot, options) =>
        MyUser.fromFireStore(snapshot.data()!),
        toFirestore: (myUsers, _) => myUsers.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser meUser) {
    return getUsersCollection().doc(meUser.id).set(meUser);
  }

  static Future<void> addEventToFirebase(Event event, String uId) {
    var collection = getEventCollection(uId);
    var docRe = collection.doc();
    event.id = docRe.id;
    return docRe.set(event);
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    var querySnapShot = await getUsersCollection().doc(id).get();
    return querySnapShot.data();
  }
//json
//[],{}
//firebase=>jsonS
//developer=>object
//json>object
//object>json
//sayed ali
}
