import 'package:bloc_test/bloc_test.dart';
import 'package:easy_shop_admin/core/theme/app_theme.dart';
import 'package:easy_shop_admin/features/profile/domain/entities/profile_entity.dart';
import 'package:easy_shop_admin/features/profile/domain/entities/profile_form_data.dart';
import 'package:easy_shop_admin/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:easy_shop_admin/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:easy_shop_admin/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:easy_shop_admin/features/profile/presentation/cubit/profile_form_cubit.dart';
import 'package:easy_shop_admin/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:easy_shop_admin/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetProfile extends Mock implements GetProfileUseCase {}

class _MockUpdateProfile extends Mock implements UpdateProfileUseCase {}

class _FakeProfileFormData extends Fake implements ProfileFormData {}

void main() {
  const profile = ProfileEntity(
    name: 'Ahmed Khalil',
    email: 'ahmed@khalilstore.com',
    phone: '+201001234567',
    nationalId: '29801234567890',
    businessName: 'Khalil Digital Store',
    businessAddress: '18 El Nasr Road',
    latitude: 30.05,
    longitude: 31.33,
    pictureUrl: 'assets/images/person.jpg',
    commercialRegisterUrl: 'assets/images/logo.png',
  );

  late _MockGetProfile getProfile;
  late _MockUpdateProfile updateProfile;

  setUpAll(() => registerFallbackValue(_FakeProfileFormData()));

  setUp(() {
    getProfile = _MockGetProfile();
    updateProfile = _MockUpdateProfile();
    when(() => getProfile()).thenAnswer((_) async => profile);
    when(() => updateProfile(any())).thenAnswer((_) async {});
  });

  test('document flags follow the uploaded urls', () {
    expect(profile.hasCommercialRegister, isTrue);
    expect(profile.hasTaxCard, isFalse);
    expect(profile.hasLocation, isTrue);
  });

  blocTest<ProfileCubit, ProfileState>(
    'load emits loading then the profile',
    build: () => ProfileCubit(getProfile),
    act: (cubit) => cubit.load(),
    expect: () => [isA<ProfileLoading>(), isA<ProfileSuccess>()],
  );

  blocTest<ProfileCubit, ProfileState>(
    'load emits failure when the request throws',
    build: () {
      when(() => getProfile()).thenThrow(Exception('boom'));
      return ProfileCubit(getProfile);
    },
    act: (cubit) => cubit.load(),
    expect: () => [isA<ProfileLoading>(), isA<ProfileFailure>()],
  );

  blocTest<ProfileFormCubit, ProfileFormState>(
    'submit reports saved',
    build: () => ProfileFormCubit(updateProfile),
    act: (cubit) => cubit.submit(
      const ProfileFormData(
        name: 'A B',
        email: 'a@b.co',
        phone: '+201001234567',
        nationalId: '29801234567890',
        businessName: 'Shop',
        businessAddress: '',
      ),
    ),
    verify: (cubit) => expect(cubit.state.status, ProfileFormStatus.saved),
  );

  testWidgets('profile screen shows the merchant details', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: BlocProvider(
            create: (_) => ProfileCubit(getProfile)..load(),
            child: ProfileScreen(onEdit: (_) {}),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('MERCHANT'), findsOneWidget);
    expect(find.text('29801234567890'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Not uploaded'), 200);
    expect(find.text('Uploaded'), findsOneWidget);
    expect(find.text('Not uploaded'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('edit profile prefills the form and saves', (tester) async {
    bool? closedWith;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: BlocProvider(
          create: (_) => ProfileFormCubit(updateProfile),
          child: EditProfileScreen(
            profile: profile,
            onClose: (saved) => closedWith = saved,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final fields = tester
        .widgetList<EditableText>(find.byType(EditableText))
        .map((field) => field.controller.text)
        .toList();
    expect(fields, contains('Ahmed Khalil'));
    expect(fields, contains('Khalil Digital Store'));

    await tester.enterText(find.byType(TextFormField).first, 'Ahmed Ali');
    final save = find.widgetWithText(ElevatedButton, 'Save Changes');
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pumpAndSettle();

    verify(() => updateProfile(any())).called(1);
    expect(closedWith, isTrue);
  });

  testWidgets('edit profile blocks a one-word name', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: BlocProvider(
          create: (_) => ProfileFormCubit(updateProfile),
          child: EditProfileScreen(profile: profile, onClose: (_) {}),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Ahmed');
    final save = find.widgetWithText(ElevatedButton, 'Save Changes');
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pumpAndSettle();

    expect(find.textContaining('full name'), findsOneWidget);
    verifyNever(() => updateProfile(any()));
  });

  testWidgets('removing an uploaded document sends the remove flag', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: BlocProvider(
          create: (_) => ProfileFormCubit(updateProfile),
          child: EditProfileScreen(profile: profile, onClose: (_) {}),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final close = find.byIcon(Icons.close);
    expect(close, findsOneWidget);
    await tester.ensureVisible(close);
    await tester.tap(close);
    await tester.pumpAndSettle();
    expect(find.text('Upload Commercial Register'), findsOneWidget);

    final save = find.widgetWithText(ElevatedButton, 'Save Changes');
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pumpAndSettle();

    final sent =
        verify(() => updateProfile(captureAny())).captured.single
            as ProfileFormData;
    expect(sent.removeCommercialRegister, isTrue);
    expect(sent.removeTaxCard, isFalse);
  });
}
