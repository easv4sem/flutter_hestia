import 'package:flutter/material.dart';
import 'package:hestia/device/data/provider/device_provider.dart';
import 'package:hestia/device/presentation/widgets/device_card_widget.dart';
import 'package:hestia/device/presentation/widgets/device_summary_list.dart';
import 'package:hestia/presentation/widgets/main_layout_widget.dart';
import 'package:provider/provider.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  final TextEditingController searchEditingController = TextEditingController();
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DeviceProvider>();
    return MainLayoutWidget(
      body: Column(
        children: [
          DeviceSummaryList(),
          const SizedBox(height: 24.0),
          _buildSearchAndFilterRow(context),
          const SizedBox(height: 16.0),
          provider.isLoading
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16.0),
                    Text('Loading devices...'),
                  ],
                ),
              )
              : const SizedBox(height: 24.0),
          const SizedBox(height: 16.0),
          Expanded(child: _buildDeviceList(context)),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterRow(BuildContext context) {
    final provider = context.watch<DeviceProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: provider.refreshDevices,
          tooltip: 'Refresh Devices',
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => (),
          tooltip: 'Create Device',
        ),
        // Sort Button
        IconButton(
          icon: Icon(
            provider.isAscending ? Icons.arrow_upward : Icons.arrow_downward,
          ),
          onPressed: () => provider.orderByName(),
          tooltip: provider.isAscending ? 'Sort Ascending' : 'Sort Descending',
        ),
        const SizedBox(width: 8.0),

        // Search Bar
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2, // 20% of screen width
          child: TextField(
            controller: searchEditingController,
            onChanged:
                (value) => setState(() {
                  provider.filteredDevices =
                      provider.devices
                          .where(
                            (device) => device.displayName
                                .toLowerCase()
                                .contains(value.toLowerCase()),
                          )
                          .toList();
                }),
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
      ],
    );
  }

  Widget _buildDeviceList(BuildContext context) {
    final provider = context.watch<DeviceProvider>();

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8.0),
      itemCount: provider.filteredDevices.length,
      itemBuilder: (context, index) {
        final device = provider.filteredDevices[index];
        return DeviceCardWidget(device: device);
      },
    );
  }
}
