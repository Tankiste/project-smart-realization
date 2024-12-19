import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_home/firebase_services.dart';
import 'package:smart_home/model/devices/device_data.dart';
import 'package:smart_home/model/rooms/room_data.dart';

Future<void> addRoomsAndDevices() async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseServices _services = FirebaseServices();

  //Livingroom
  List<DeviceData> livingRoomDevices = [
    DeviceData(
        id: '',
        roomId: '',
        roomName: 'Living Room',
        device_name: 'Lighting',
        isActive: false),
    DeviceData(
        id: '',
        roomId: '',
        roomName: 'Living Room',
        device_name: 'Air Conditioner',
        isActive: false),
    DeviceData(
        id: '',
        roomId: '',
        roomName: 'Living Room',
        device_name: 'Heater',
        isActive: false),
  ];

  List<String> livingRoomDeviceIds = [];

  for (var device in livingRoomDevices) {
    DocumentReference deviceRef =
        await _services.devices.add(device.toMapDevice());
    livingRoomDeviceIds.add(deviceRef.id);

    await deviceRef.update({
      'id': deviceRef.id,
    });
  }

  DocumentReference livingRoomRef = await _services.rooms.add(
      RoomData(id: '', name: 'Living Room', deviceIds: livingRoomDeviceIds)
          .toMapRoom());

  await livingRoomRef.update({'id': livingRoomRef.id});

  //Kitchen
  List<DeviceData> kitchenDevices = [
    DeviceData(
        id: '',
        roomId: '',
        roomName: 'Kitchen',
        device_name: 'Lighting',
        isActive: false)
  ];

  List<String> kitchenDeviceIds = [];

  for (var device in kitchenDevices) {
    DocumentReference deviceRef =
        await _services.devices.add(device.toMapDevice());
    kitchenDeviceIds.add(deviceRef.id);

    await deviceRef.update({'id': deviceRef.id});
  }

  DocumentReference kitchenRef = await _services.rooms.add(
      RoomData(id: '', name: 'Kitchen', deviceIds: kitchenDeviceIds)
          .toMapRoom());

  await kitchenRef.update({'id': kitchenRef.id});

  //Bedroom
  List<DeviceData> bedroomDevices = [
    DeviceData(
        id: '',
        roomId: '',
        roomName: 'Bedroom',
        device_name: 'Lighting',
        isActive: false),
  ];

  List<String> bedroomDeviceIds = [];

  for (var device in bedroomDevices) {
    DocumentReference deviceRef =
        await _services.devices.add(device.toMapDevice());
    bedroomDeviceIds.add(deviceRef.id);

    await deviceRef.update({'id': deviceRef.id});
  }

  DocumentReference bedroomRef = await _services.rooms.add(
      RoomData(id: '', name: 'Bedroom', deviceIds: bedroomDeviceIds)
          .toMapRoom());

  await bedroomRef.update({'id': bedroomRef.id});

  //Garage
  List<DeviceData> garageDevices = [
    DeviceData(
        id: '',
        roomId: '',
        roomName: 'Garage',
        device_name: 'Lighting',
        isActive: false),
  ];

  List<String> garageDeviceIds = [];

  for (var device in garageDevices) {
    DocumentReference deviceRef =
        await _services.devices.add(device.toMapDevice());
    garageDeviceIds.add(deviceRef.id);

    await deviceRef.update({'id': deviceRef.id});
  }

  DocumentReference garageRef = await _services.rooms.add(
      RoomData(id: '', name: 'Garage', deviceIds: garageDeviceIds).toMapRoom());

  await garageRef.update({'id': garageRef.id});
}
