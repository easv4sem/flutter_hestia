import 'package:flutter/material.dart';
import 'package:hestia/device/data/models/device.dart';
import 'package:hestia/device/data/enums/device_state.dart';
import 'package:hestia/service/api_service.dart';

class DeviceProvider extends ChangeNotifier {
  static final DeviceProvider _instance = DeviceProvider._internal();

  factory DeviceProvider() => _instance;
  DeviceProvider._internal();

  static DeviceProvider get instance => _instance;

  List<Device> devices = [];
  List<Device> filteredDevices = [];
  String selectedFilter = 'All';
  bool isAscending = true;
  bool isLoading = false;

  Device? getDeviceByMac(String id) {
    try {
      return devices.firstWhere((device) => device.mac == id);
    } catch (e) {
      return null;
    }
  }


  void setDevices(List<Device> newDevices) {
    devices = newDevices;
    filteredDevices = List.from(devices);
    notifyListeners();
  }

  void setSelectedFilter(String filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  void setIsAscending(bool ascending) {
    isAscending = ascending;
    notifyListeners();
  }

  void setIsLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void orderByName() {
    setIsAscending(!isAscending);
    filteredDevices.sort(
      (a, b) =>
          isAscending
              ? a.displayName.compareTo(b.displayName)
              : b.displayName.compareTo(a.displayName),
    );
    notifyListeners();
  }

  void orderByStatus() {
    filteredDevices.sort(
      (a, b) => a.mode.toString().compareTo(b.mode.toString()),
    );
    notifyListeners();
  }

  int getNumberOfDevices() {
    return devices.length;
  }

  int getNumberOfDevicesByStatus(DeviceState state) {
    return devices.where((device) => device.mode == state).length;
  }

  Future<void> loadDevices() async {
    setIsLoading(true);

    try {
      final response = await ApiService().get('/devices');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final List<Device> loadedDevices =
            jsonList.map((deviceJson) => Device.fromJson(deviceJson)).toList();


        devices = loadedDevices;
        filteredDevices = List.from(devices);
      } else {
        devices = [];
        filteredDevices = [];
      }
    } catch (e) {
      devices = [];
      filteredDevices = [];
    }

    setIsLoading(false);
    notifyListeners();
  }

  Future<void> refreshDevices() async {
    await loadDevices();
  }

  void search(String query) {
    filteredDevices =
        devices
            .where(
              (device) => device.displayName.toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();
    notifyListeners();
  }

  void sortByName(bool ascending) {
    filteredDevices.sort(
      (a, b) =>
          ascending
              ? a.displayName.compareTo(b.displayName)
              : b.displayName.compareTo(a.displayName),
    );
    notifyListeners();
  }
}
