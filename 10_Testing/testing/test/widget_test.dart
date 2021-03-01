// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:testing/views/login_view.dart';

void main() {
  group('Login view tests', () {
    testWidgets("Login main stream test", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginView(),
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
      ));

      //find all elements.
      expect(find.byKey(Key('fieldEmail')), findsOneWidget);
      expect(find.byKey(Key('fieldPhone')), findsOneWidget);
      expect(find.text('Отправить'), findsOneWidget);
      expect(find.text('Добро пожаловать'), findsNothing);

      //populate email.
      await tester.enterText(find.byKey(Key('fieldEmail')), 'test@test.ru');
      expect(find.text('test@test.ru'), findsOneWidget);

      //populate phone with number.
      await tester.enterText(find.byKey(Key('fieldPhone')), '12345678');
      expect(find.text('12345678'), findsOneWidget);
      await tester.enterText(find.byKey(Key('fieldPhone')), 'aa12345678bb');
      expect(find.text('12345678'), findsOneWidget);

      //all OK.
      await tester.tap(find.text('Отправить'));
      await tester.pump();
      expect(find.text('Добро пожаловать'), findsOneWidget);
    });

    testWidgets("Login wrong fields test", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginView(),
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
      ));

      //find all elements.
      expect(find.byKey(Key('fieldEmail')), findsOneWidget);
      expect(find.byKey(Key('fieldPhone')), findsOneWidget);
      expect(find.text('Отправить'), findsOneWidget);
      expect(find.text('Добро пожаловать'), findsNothing);

      //empty email.
      await tester.enterText(find.byKey(Key('fieldEmail')), '');
      await tester.tap(find.text('Отправить'));
      await tester.pump();
      expect(find.text('Добро пожаловать'), findsNothing);

      //wrong email.
      await tester.enterText(find.byKey(Key('fieldEmail')), 'sdf3425gj');
      await tester.tap(find.text('Отправить'));
      await tester.pump();
      expect(find.text('Добро пожаловать'), findsNothing);

      //empty phone.
      await tester.enterText(find.byKey(Key('fieldPhone')), '');
      await tester.tap(find.text('Отправить'));
      await tester.pump();
      expect(find.text('Добро пожаловать'), findsNothing);
    });

    testWidgets("Registration main stream test", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginView(),
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
      ));

      //move to Registration.
      await tester.tap(find.byKey(Key('swichBtn')));
      await tester.pump();
      expect(find.text('Уже есть аккаунт?'), findsOneWidget);

      //find all elements.
      expect(find.byKey(Key('fieldFirstName')), findsOneWidget);
      expect(find.byKey(Key('fieldLastName')), findsOneWidget);
      expect(find.byKey(Key('fieldRegEmail')), findsOneWidget);
      expect(find.byKey(Key('fieldRegPhone')), findsOneWidget);
      expect(find.text('Отправить'), findsOneWidget);

      //populate all fields.
      await tester.enterText(
          find.byKey(Key('fieldFirstName')), 'testFirstName');
      await tester.enterText(find.byKey(Key('fieldLastName')), 'testLastName');
      await tester.enterText(find.byKey(Key('fieldRegEmail')), 'test@test.ru');
      await tester.enterText(find.byKey(Key('fieldRegPhone')), '1234567');

      //press button.
      await tester.tap(find.text('Отправить'));
      await tester.pump();
      expect(find.text('Вы успешно зарегистрировались'), findsOneWidget);
    });

    testWidgets("Registration wrong fields", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginView(),
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
      ));

      //move to Registration.
      await tester.tap(find.byKey(Key('swichBtn')));
      await tester.pump();
      expect(find.text('Уже есть аккаунт?'), findsOneWidget);

      //find all elements.
      expect(find.byKey(Key('fieldFirstName')), findsOneWidget);
      expect(find.byKey(Key('fieldLastName')), findsOneWidget);
      expect(find.byKey(Key('fieldRegEmail')), findsOneWidget);
      expect(find.byKey(Key('fieldRegPhone')), findsOneWidget);
      expect(find.text('Отправить'), findsOneWidget);

      //empty FirstName
      await populateRegistrationAllFields(tester);
      await tester.enterText(find.byKey(Key('fieldFirstName')), '');
      await testIfRegistrationFormWrong(tester);

      //empty LastName
      await populateRegistrationAllFields(tester);
      await tester.enterText(find.byKey(Key('fieldLastName')), '');
      await testIfRegistrationFormWrong(tester);

      //empty Email
      await populateRegistrationAllFields(tester);
      await tester.enterText(find.byKey(Key('fieldRegEmail')), '');
      await testIfRegistrationFormWrong(tester);

      //empty phone.
      await populateRegistrationAllFields(tester);
      await tester.enterText(find.byKey(Key('fieldRegPhone')), '');
      await testIfRegistrationFormWrong(tester);

      //phone with letters.
      await populateRegistrationAllFields(tester);
      await tester.enterText(find.byKey(Key('fieldRegPhone')), 'sdfsdf');
      await testIfRegistrationFormWrong(tester);
    });
  });
}

Future populateRegistrationAllFields(WidgetTester tester) async {
  await tester.enterText(find.byKey(Key('fieldFirstName')), 'testFirstName');
  await tester.enterText(find.byKey(Key('fieldLastName')), 'testLastName');
  await tester.enterText(find.byKey(Key('fieldRegEmail')), 'test@test.ru');
  await tester.enterText(find.byKey(Key('fieldRegPhone')), '1234567');
}

Future testIfRegistrationFormWrong(WidgetTester tester) async {
  await tester.tap(find.text('Отправить'));
  await tester.pump();
  expect(find.text('Вы успешно зарегистрировались'), findsNothing);
}
