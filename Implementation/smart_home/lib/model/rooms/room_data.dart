import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:smart_home/model/devices/device_data.dart';

class RoomData {
  String id;
  String name;
  List<String>? deviceIds;

  RoomData({
    required this.id,
    required this.name,
    this.deviceIds,
  });

  Map<String, dynamic> toMapRoom() {
    return {
      // 'id': id,
      'name': name,
      'devices': deviceIds,
      // 'devices': devices!.map((device) => device.toMapDevice()).toList(),
    };
  }

  static RoomData fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    // List<DeviceData> deviceList = (snapshot['devices'] as List)
    //     .map((device) => DeviceData.fromSnap(device))
    //     .toList();

    return RoomData(
      id: snapshot['id'],
      name: snapshot['name'],
      deviceIds: snapshot['devices'],
    );
  }
}
