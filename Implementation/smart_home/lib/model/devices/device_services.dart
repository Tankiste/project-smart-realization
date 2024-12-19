import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_home/firebase_services.dart';

Future<void> updateDevicesWithRoomInfo() async {
  final FirebaseServices _services = FirebaseServices();

  QuerySnapshot roomsSnapshot = await _services.rooms.get();

  for (var roomDoc in roomsSnapshot.docs) {
    List<dynamic> devicesInRoom = roomDoc['devices'];

    for (var deviceId in devicesInRoom) {
      var devicesSnapshot = await _services.devices.doc(deviceId).get();

      if (devicesSnapshot.exists) {
        await _services.devices.doc(deviceId).set({
          'room id': roomDoc.id,
          'room name': roomDoc['name'],
        }, SetOptions(merge: true));
      }
    }
  }
}
