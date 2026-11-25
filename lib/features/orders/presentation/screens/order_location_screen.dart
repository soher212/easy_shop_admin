import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OrderLocationScreen extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String address;

  const OrderLocationScreen({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final point = LatLng(latitude, longitude);
    return Scaffold(
      appBar: AppBar(title: const Text('Delivery Location')),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(initialCenter: point, initialZoom: 15),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.easy_shop_admin',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: point,
                      width: 48,
                      height: 48,
                      child: Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 44,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (address.isNotEmpty)
            SafeArea(
              top: false,
              child: Container(
                width: double.infinity,
                color: context.appColors.surface,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: context.appColors.textMuted,
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(address)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
