// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Login form main stream tests', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    final fieldEmail = find.byValueKey('fieldEmail');
    final fieldPhone = find.byValueKey('fieldPhone');
    final fieldBtn = find.text('Отправить');

    test('Login Email field', () async {
      await driver.tap(fieldEmail);
      await driver.waitFor(find.text(''));
      await driver.enterText('test@test.ru');
      await driver.waitFor(find.text('test@test.ru'));
    });

    test('Login Phone field', () async {
      await driver.tap(fieldPhone);
      await driver.waitFor(find.text(''));
      await driver.enterText('1234567');
      await driver.waitFor(find.text('1234567'));
    });

    test('Login tap btn', () async {
      await driver.tap(fieldBtn);
    });

    test('Login test OK', () async {
      final success = find.text('Добро пожаловать');
      expect(await driver.getText(success), 'Добро пожаловать');
    });
  });

  group('Rigisteration form tests', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    final swichBtn = find.byValueKey('swichBtn');
    final fieldFirstName = find.byValueKey('fieldFirstName');
    final fieldLastName = find.byValueKey('fieldLastName');
    final fieldRegEmail = find.byValueKey('fieldRegEmail');
    final fieldRegPhone = find.byValueKey('fieldRegPhone');
    final fieldBtn = find.text('Отправить');

    test('Rigisteration tap btn', () async {
      await driver.tap(swichBtn);
    });

    test('Rigisteration FirstName field', () async {
      await driver.tap(fieldFirstName);
      await driver.waitFor(find.text(''));
      await driver.enterText('FirstName');
      await driver.waitFor(find.text('FirstName'));
    });

    test('Rigisteration fieldLastName field', () async {
      await driver.tap(fieldLastName);
      await driver.waitFor(find.text(''));
      await driver.enterText('LastName');
      await driver.waitFor(find.text('LastName'));
    });

    test('Rigisteration Email field', () async {
      await driver.tap(fieldRegEmail);
      await driver.waitFor(find.text(''));
      await driver.enterText('test@test.ru');
      await driver.waitFor(find.text('test@test.ru'));
    });

    test('Rigisteration Phone field', () async {
      await driver.tap(fieldRegPhone);
      await driver.waitFor(find.text(''));
      await driver.enterText('1234567');
      await driver.waitFor(find.text('1234567'));
    });

    test('Rigisteration tap btn', () async {
      await driver.tap(fieldBtn);
    });

    test('Rigisteration test OK', () async {
      final success = find.text('Вы успешно зарегистрировались');
      expect(await driver.getText(success), 'Вы успешно зарегистрировались');
    });
  });
}
