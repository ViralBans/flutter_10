import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_10/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('Test Full App', () {
    testWidgets('Test Login Form', (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle();

      // Определение элементов формы Login
      final fieldEmail = find.byKey(const Key('fieldEmail')); // Поле "Email"
      final fieldPhone = find.byKey(const Key('fieldPhone')); // Поле "Phone"
      final buttonSubmit = find.text('Отправить'); // Кнопка "Отправить"

      //Проверка существующих элементов формы Login
      expect(fieldEmail, findsOneWidget);
      expect(fieldPhone, findsOneWidget);
      expect(buttonSubmit, findsOneWidget);
      expect(find.text('Добро пожаловать'), findsNothing);

      // Проверка пустых значений в полях
      await widgetTester.tap(buttonSubmit);
      await widgetTester.pumpAndSettle();
      expect(find.text('Введите email'), findsOneWidget);
      expect(find.text('Введите телефон'), findsOneWidget);

      // Проверка некорректного поля "Email"
      await widgetTester.enterText(fieldEmail, 'test@test');
      await widgetTester.tap(buttonSubmit);
      await widgetTester.pumpAndSettle();
      expect(find.text('Поле email заполнено не корректно'), findsOneWidget);

      // Проверка поля "Phone" на наличие только цифр
      await widgetTester.enterText(fieldPhone, '8800test');
      await widgetTester.tap(buttonSubmit);
      await widgetTester.pumpAndSettle();
      expect(find.text('8800'), findsOneWidget);

      // Проверка валидного заполнения полей
      await widgetTester.enterText(fieldEmail, 'test@test.ru');
      await widgetTester.enterText(fieldPhone, '88005553535');

      // Проверка успешного входа
      await widgetTester.tap(buttonSubmit);
      await widgetTester.pump();
      expect(find.text('Добро пожаловать'), findsOneWidget);
    });

    testWidgets('Test Register Form', (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle();

      // Переход на форму регистрации
      final buttonSwitcher = find.byKey(const Key('buttonSwitcher')); // Кнопка "Войти/Регистрация"
      expect(buttonSwitcher, findsOneWidget);
      await widgetTester.tap(buttonSwitcher);
      await widgetTester.pumpAndSettle();

      // Определение элементов формы Register
      final fieldFirstName = find.byKey(const Key('fieldFirstName')); // Поле "First Name"
      final fieldLastName = find.byKey(const Key('fieldLastName')); // Поле "Last Name"
      final fieldEmail = find.byKey(const Key('fieldEmail')); // Поле "Email"
      final fieldPhone = find.byKey(const Key('fieldPhone')); // Поле "Phone"
      final buttonSubmit = find.text('Отправить'); // Кнопка "Отправить"

      //Проверка существующих элементов формы Register
      expect(fieldFirstName, findsOneWidget);
      expect(fieldLastName, findsOneWidget);
      expect(fieldEmail, findsOneWidget);
      expect(fieldPhone, findsOneWidget);
      expect(buttonSubmit, findsOneWidget);
      expect(find.text('Вы успешно зарегистрировались'), findsNothing);

      // Проверка пустых значений в полях firstName и lastName
      await widgetTester.tap(buttonSubmit);
      await widgetTester.pumpAndSettle();
      expect(find.text('Введите имя'), findsOneWidget);
      expect(find.text('Введите фамилию'), findsOneWidget);

      // Проверка поля "Phone" на наличие только цифр
      await widgetTester.enterText(fieldPhone, '8800test');
      await widgetTester.tap(buttonSubmit);
      await widgetTester.pumpAndSettle();
      expect(find.text('8800'), findsOneWidget);

      // Проверка валидного заполнения полей
      await widgetTester.enterText(fieldFirstName, 'Sergey');
      await widgetTester.enterText(fieldLastName, 'Tyurin');
      await widgetTester.enterText(fieldPhone, '88005553535');
      await widgetTester.enterText(fieldEmail, 'test@test.ru');

      // Проверка успешной регистрации
      await widgetTester.tap(buttonSubmit);
      await widgetTester.pumpAndSettle();
      expect(find.text('Вы успешно зарегистрировались'), findsOneWidget);
    });
  });
}