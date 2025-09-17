import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c16_sun/data/models/event.dart';

class EventsFirebaseDatabase {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static CollectionReference<Event> getCollectionReference() {
    return db
        .collection("events")
        .withConverter(
          fromFirestore:
              (data, snapshot) => Event.fromFirestore(data.data() ?? {}),
          toFirestore: (data, _) => data.toJson(),
        );
  }

  static Future<void> createEvent(Event event) async {
    try {
      var doc = await getCollectionReference().doc();
      event.id = doc.id;
      await doc.set(event);
    } catch (e) {
      print(e);
    }
  }
}
