import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hestia/models/device.dart';
import 'package:hestia/presentation/widgets/main_layout_widget.dart';
import 'package:hestia/service/api_service.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  final TextEditingController searchEditingController = TextEditingController();
  String selectedFilter = 'All';
  bool isAscending = true;
  bool isLoading = false;

  Future<void> _loadDevices() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiService().get('/devices');

      if (response.statusCode == 200) {
        devices.clear();

        final List<dynamic> jsonList = (response.data);
        final List<Device> loadedDevices =
            jsonList.map((deviceJson) => Device.fromJson(deviceJson)).toList();

        devices.clear();
        devices.addAll(
          loadedDevices.map((device) => device.toDisplayMap()).toList(),
        );
        filteredDevices = List.from(devices);
      } else {
        throw Exception('Failed to load devices');
      }
    } catch (e) {
      print('Error loading devices: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  void _filterDevices() {
    setState(() {
      filteredDevices =
          devices.where((device) {
            final matchesSearch = device['name'].toLowerCase().contains(
              searchEditingController.text.toLowerCase(),
            );
            final matchesFilter =
                selectedFilter == 'All' || device['type'] == selectedFilter;
            return matchesSearch && matchesFilter;
          }).toList();

      // Apply sorting
      _sortDevices();
    });
  }

  void _sortDevices() {
    filteredDevices.sort((a, b) {
      final comparison = a['name'].compareTo(b['name']);
      return isAscending ? comparison : -comparison;
    });
  }

  void _refreshDevices() {
    _loadDevices();
    setState(() {
      // Simulate refreshing devices (e.g., fetch from API)
      filteredDevices = devices;
      searchEditingController.clear();
      selectedFilter = 'All';
      isAscending = true;
    });
  }

  final List<Map<String, dynamic>> devices = [];
  List<Map<String, dynamic>> filteredDevices = [];

  @override
  void initState() {
    super.initState();
    filteredDevices = devices; // Initialize with all devices
  }

  Color _getDeviceColor(String mode) {
    switch (mode.toLowerCase()) {
      case 'Connected':
        return Colors.blue;
      case 'OK':
        return Colors.green;
      case 'Alerted':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayoutWidget(
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              isLoading
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16.0),
                        const Text('Loading devices...'),
                      ],
                    ),
                  )
                  : Column(
                    children: [
                      const SizedBox(height: 24.0),
                      _buildSearchAndFilterRow(context),
                      const SizedBox(height: 16.0),
                      _buildDeviceList(),
                    ],
                  ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilterRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: _refreshDevices,
          tooltip: 'Refresh Devices',
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => (),
          tooltip: 'Create Device',
        ),
        // Sort Button
        IconButton(
          icon: Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward),
          onPressed: () {
            setState(() {
              isAscending = !isAscending; // Toggle sorting order
              _sortDevices(); // Apply sorting
            });
          },
          tooltip: isAscending ? 'Sort Ascending' : 'Sort Descending',
        ),
        const SizedBox(width: 8.0),

        // Search Bar
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2, // 20% of screen width
          child: TextField(
            controller: searchEditingController,
            onChanged: (value) => _filterDevices(),
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),

        // Filter Icon with PopupMenuButton
        PopupMenuButton<String>(
          icon: const Icon(Icons.filter_list),
          onSelected: (value) {
            setState(() {
              selectedFilter = value;
              _filterDevices();
            });
          },
          itemBuilder:
              (context) => const [
                PopupMenuItem(value: 'All', child: Text('All')),
                PopupMenuItem(value: 'Connected', child: Text('Connected')),
                PopupMenuItem(value: 'OK', child: Text('OK')),
                PopupMenuItem(value: 'Alerted', child: Text('Alerted')),
              ],
        ),
      ],
    );
  }

  Widget _buildDeviceList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8.0),
        itemCount: filteredDevices.length,
        itemBuilder: (context, index) {
          final device = filteredDevices[index];
          return _buildDeviceCard(device);
        },
      ),
    );
  }

  Widget _buildDeviceCard(Map<String, dynamic> device) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(device['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(device['details']),
            const SizedBox(height: 4.0),
            Text(
              'Longitude: ${device['longitude']}, Latitude: ${device['latitude']}',
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              'Last Heartbeat: ${device['lasthardbeat'].toString().split('.').first}',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
        leading: Container(
          decoration: BoxDecoration(
            color: _getDeviceColor(device['type']),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const SizedBox(
            width: 50,
            height: 50,
            child: Icon(Icons.device_hub, color: Colors.white),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          // TODO: Handle device tap
        },
      ),
    );
  }
}
