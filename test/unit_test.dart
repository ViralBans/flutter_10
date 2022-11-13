import 'package:flutter/material.dart';
import 'package:flutter_10/views/login_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginView(),
      ),
    );

    //Проверка существующих элементов формы Login
    expect(find.byKey(const Key('fieldEmail')), findsOneWidget);
    expect(find.byKey(const Key('fieldPhone')), findsOneWidget);
    expect(find.text('Отправить'), findsOneWidget);
    expect(find.text('Добро пожаловать'), findsNothing);

    // Проверка пустых значений в полях
    await tester.tap(find.text('Отправить'));
    await tester.pump();
    expect(find.text('Введите email'), findsOneWidget);
    expect(find.text('Введите телефон'), findsOneWidget);

    // Проверка некорректного поля "Email"
    await tester.enterText(find.byKey(const Key('fieldEmail')), 'test@test');
    await tester.tap(find.text('Отправить'));
    await tester.pump();
    expect(find.text('Поле email заполнено не корректно'), findsOneWidget);

    // Проверка поля "Phone" на наличие только цифр
    await tester.enterText(find.byKey(const Key('fieldPhone')), '8800test');
    await tester.tap(find.text('Отправить'));
    await tester.pump();
    expect(find.text('8800'), findsOneWidget);

    // Проверка валидного заполнения полей
    await tester.enterText(find.byKey(const Key('fieldEmail')), 'test@test.ru');
    expect(find.text('test@test.ru'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('fieldPhone')), '88005553535');
    expect(find.text('88005553535'), findsOneWidget);

    // Проверка успешного входа
    await tester.tap(find.text('Отправить'));
    await tester.pump();
    expect(find.text('Добро пожаловать'), findsOneWidget);

    // Переход в форму регистрации
    expect(find.byKey(const Key('buttonSwitcher')), findsOneWidget);
    await tester.tap(find.byKey(const Key('buttonSwitcher')));
    await tester.pump();

    //Проверка существующих элементов формы Register
    expect(find.byKey(const Key('fieldFirstName')), findsOneWidget);
    expect(find.byKey(const Key('fieldLastName')), findsOneWidget);
    expect(find.byKey(const Key('fieldEmail')), findsOneWidget);
    expect(find.byKey(const Key('fieldPhone')), findsOneWidget);
    expect(find.text('Отправить'), findsOneWidget);
    expect(find.text('Вы успешно зарегистрировались'), findsNothing);

    // Проверка пустых значений в полях firstName и lastName
    await tester.tap(find.text('Отправить'));
    await tester.pump();
    expect(find.text('Введите имя'), findsOneWidget);
    expect(find.text('Введите фамилию'), findsOneWidget);

    // Проверка поля "Phone" на наличие только цифр
    await tester.enterText(find.byKey(const Key('fieldPhone')), '8800test');
    await tester.tap(find.text('Отправить'));
    await tester.pump();
    expect(find.text('8800'), findsOneWidget);

    // Проверка валидного заполнения полей
    await tester.enterText(find.byKey(const Key('fieldFirstName')), 'Sergey');
    expect(find.text('Sergey'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('fieldLastName')), 'Tyurin');
    expect(find.text('Tyurin'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('fieldPhone')), '88005553535');
    expect(find.text('88005553535'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('fieldEmail')), 'test@test.ru');
    expect(find.text('test@test.ru'), findsOneWidget);

    // Проверка успешной регистрации
    await tester.tap(find.text('Отправить'));
    await tester.pump();
    expect(find.text('Вы успешно зарегистрировались'), findsOneWidget);
  });
}
