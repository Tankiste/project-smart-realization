import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceData {
  String id;
  String device_name;
  bool? isActive = false;

  DeviceData({
    required this.id,
    required this.device_name,
    this.isActive,
  });

  Map<String, dynamic> toMapDevice() {
    return {
      'id': id,
      'device name': device_name,
      'state': isActive,
    };
  }

  static DeviceData fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return DeviceData(
        id: snapshot['id'],
        device_name: snapshot['device name'],
        isActive: snapshot['state']);
  }
}
