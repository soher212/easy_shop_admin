import 'package:easy_shop_admin/core/services/reverse_geocoder.dart';
import 'package:easy_shop_admin/core/theme/app_theme.dart';
import 'package:easy_shop_admin/features/maps/domain/entities/picked_location.dart';
import 'package:easy_shop_admin/features/maps/presentation/pick_location_on_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReverseGeocoder.labelFromResponse', () {
    test('uses the city and the country', () {
      expect(
        ReverseGeocoder.labelFromResponse({
          'address': {'city': 'Cairo', 'country': 'Egypt'},
        }),
        'Cairo, Egypt',
      );
    });

    test('falls back to the state when there is no city', () {
      expect(
        ReverseGeocoder.labelFromResponse({
          'address': {'state': 'Giza Governorate', 'country': 'Egypt'},
        }),
        'Giza Governorate, Egypt',
      );
    });

    test('returns just the country when that is all there is', () {
      expect(
        ReverseGeocoder.labelFromResponse({
          'address': {'country': 'Egypt'},
        }),
        'Egypt',
      );
    });

    test('returns null when there is no address', () {
      expect(ReverseGeocoder.labelFromResponse(null), isNull);
      expect(ReverseGeocoder.labelFromResponse({'error': 'x'}), isNull);
    });
  });

  testWidgets('the map picker confirms the location it was opened with', (
    tester,
  ) async {
    PickedLocation? result;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () async {
                  result = await pickLocationOnMap(
                    context,
                    latitude: 30.0444,
                    longitude: 31.2357,
                  );
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.text('Select Location'), findsOneWidget);
    final confirm = find.widgetWithText(ElevatedButton, 'Confirm Location');
    expect(tester.widget<ElevatedButton>(confirm).onPressed, isNotNull);

    await tester.tap(confirm);
    await tester.pumpAndSettle();

    expect(result?.latitude, 30.0444);
    expect(result?.longitude, 31.2357);
  });

  testWidgets('the map picker cannot confirm before a pin is placed', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => pickLocationOnMap(context),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    final confirm = find.widgetWithText(ElevatedButton, 'Confirm Location');
    expect(tester.widget<ElevatedButton>(confirm).onPressed, isNull);
    expect(find.text('Tap the map to choose the location'), findsOneWidget);
  });
}
