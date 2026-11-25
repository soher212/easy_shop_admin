import 'package:easy_shop_admin/core/services/reverse_geocoder.dart';
import 'package:easy_shop_admin/core/widgets/info_card.dart';
import 'package:flutter/material.dart';

// Shows the place name for the store coordinates, or the coordinates
// themselves while loading and when the name can't be found.
class StoreLocationText extends StatefulWidget {
  final double? latitude;
  final double? longitude;

  const StoreLocationText({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<StoreLocationText> createState() => _StoreLocationTextState();
}

class _StoreLocationTextState extends State<StoreLocationText> {
  late Future<String?> _label;
  String? _localeCode;

  Future<String?> _resolve(String languageCode) {
    if (widget.latitude == null || widget.longitude == null) {
      return Future.value(null);
    }
    return ReverseGeocoder.labelFor(
      widget.latitude!,
      widget.longitude!,
      languageCode: languageCode,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final languageCode = Localizations.localeOf(context).languageCode;
    if (_localeCode != languageCode) {
      _localeCode = languageCode;
      _label = _resolve(languageCode);
    }
  }

  @override
  void didUpdateWidget(StoreLocationText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.latitude != widget.latitude ||
        oldWidget.longitude != widget.longitude) {
      _label = _resolve(_localeCode ?? 'en');
    }
  }

  String get _coordinates {
    if (widget.latitude == null || widget.longitude == null) return '';
    return '${widget.latitude!.toStringAsFixed(4)}, '
        '${widget.longitude!.toStringAsFixed(4)}';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _label,
      builder: (context, snapshot) => InfoValue(snapshot.data ?? _coordinates),
    );
  }
}
