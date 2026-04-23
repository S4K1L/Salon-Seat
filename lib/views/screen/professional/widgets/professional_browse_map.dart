import 'package:flutter/material.dart';
import 'package:flutter_extension/data/model/professional_browse_listing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

/// Google Map with pins for the current filtered [listings]. Requests location when in use.
class ProfessionalBrowseMap extends StatefulWidget {
  const ProfessionalBrowseMap({super.key, required this.listings});

  final List<ProfessionalBrowseListing> listings;

  @override
  State<ProfessionalBrowseMap> createState() => _ProfessionalBrowseMapState();
}

class _ProfessionalBrowseMapState extends State<ProfessionalBrowseMap> {
  static const LatLng _fallbackCenter = LatLng(34.0522, -118.2437);

  bool _myLocationEnabled = false;

  @override
  void initState() {
    super.initState();
    _requestLocation();
  }

  Future<void> _requestLocation() async {
    final status = await Permission.locationWhenInUse.request();
    if (!mounted) return;
    setState(() => _myLocationEnabled = status.isGranted);
  }

  @override
  Widget build(BuildContext context) {
    final listings = widget.listings;
    final target = listings.isEmpty
        ? _fallbackCenter
        : LatLng(listings.first.latitude, listings.first.longitude);

    final markers = listings
        .map(
          (e) => Marker(
            markerId: MarkerId(e.id),
            position: LatLng(e.latitude, e.longitude),
            infoWindow: InfoWindow(title: e.title, snippet: e.priceLabel),
          ),
        )
        .toSet();

    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: SizedBox(
        height: 200.h,
        width: double.infinity,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: target,
            zoom: listings.length <= 1 ? 12 : 11,
          ),
          markers: markers,
          myLocationEnabled: _myLocationEnabled,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: false,
        ),
      ),
    );
  }
}
