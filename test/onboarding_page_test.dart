import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oech_app/onboarding/data/repository/data_repository.dart';
import 'package:oech_app/onboarding/presentation/pages/onboarding_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final data = await DataRepository().getOnboarding();
  final firstData = data.data[0];
  final secondData = data.data[1];
  final thirdData = data.data[2];

  group("Тестирование экрана Onboarding", () {
    test("Изображения и текста из очереди извлекаются правильно", () async {
      expect(firstData.title, "Quick Delivery At Your\nDoorstep");
      expect(firstData.subtitle,
          "Enjoy quick pick-up and delivery to\nyour destination");
      expect(firstData.image, "assets/images/onb1.png");

      expect(secondData.title, "Flexible Payment");
      expect(secondData.subtitle,
          "Different modes of payment either\nbefore and after delivery without stress");
      expect(secondData.image, "assets/images/onb2.png");

      expect(thirdData.title, "Real-time Tracking");
      expect(thirdData.subtitle,
          "Track your packages/items from the\ncomfort of your home till final destination");
      expect(thirdData.image, "assets/images/onb3.png");
    });
    testWidgets("Корректное извлечение из очереди", (tester) async {
      final pageView = find.byType(PageView);

      await tester.runAsync(() => tester.pumpWidget(const ProviderScope(
              child: MaterialApp(
            home: Scaffold(
              body: OnboardingPage(),
            ),
          ))));

      await tester.pumpAndSettle();
      expect(find.text(firstData.title), findsOneWidget);
      expect(find.text(firstData.subtitle), findsOneWidget);
      expect(find.image(AssetImage(firstData.image)), findsOneWidget);
      await tester.dragUntilVisible(
          find.text(secondData.title), pageView, const Offset(-250, 0));
      await tester.pumpAndSettle();
      expect(find.text(secondData.title), findsOneWidget);
      expect(find.text(secondData.subtitle), findsOneWidget);
      expect(find.image(AssetImage(secondData.image)), findsOneWidget);
      await tester.dragUntilVisible(
          find.text(thirdData.title), pageView, const Offset(-250, 0));
      await tester.pumpAndSettle();
      expect(find.text(thirdData.title), findsOneWidget);
      expect(find.text(thirdData.subtitle), findsOneWidget);
      expect(find.image(AssetImage(thirdData.image)), findsOneWidget);
    });
    testWidgets(
        "В случае когда в очереди несколько картинок, устанавливается правильная надпись на кнопке",
        (tester) async {
          final pageView = find.byType(PageView);

          await tester.runAsync(() => tester.pumpWidget(const ProviderScope(
              child: MaterialApp(
                home: Scaffold(
                  body: OnboardingPage(),
                ),
              ))));

          await tester.pumpAndSettle();
          expect(find.widgetWithText(ElevatedButton, "Next"), findsOneWidget);
          await tester.dragUntilVisible(
              find.text(secondData.title), pageView, const Offset(-250, 0));
          expect(find.widgetWithText(ElevatedButton, "Next"), findsWidgets);
        });
    testWidgets(
        "Случай, когда в очереди осталось только одно изображение, надпись на кнопке должна измениться на Sign up",
            (tester) async {
          final pageView = find.byType(PageView);

          await tester.runAsync(() => tester.pumpWidget(const ProviderScope(
              child: MaterialApp(
                home: Scaffold(
                  body: OnboardingPage(),
                ),
              ))));

          await tester.pumpAndSettle();
          await tester.dragUntilVisible(
              find.text(secondData.title), pageView, const Offset(-250, 0));
          await tester.pumpAndSettle();
          await tester.dragUntilVisible(
              find.text(thirdData.title), pageView, const Offset(-250, 0));
          await tester.pumpAndSettle();
          expect(find.widgetWithText(ElevatedButton, "Sign Up"), findsOneWidget);
        });
    testWidgets("Если очередь пустая и нажата кнопка Регистрация, то переходит на экран регистрации", (tester) async {
      final pageView = find.byType(PageView);
      final signupButton = find.widgetWithText(ElevatedButton, "Sign Up");

      await tester.runAsync(() => tester.pumpWidget(const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: OnboardingPage(),
            ),
          ))));

      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
          find.text(secondData.title), pageView, const Offset(-250, 0));
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
          find.text(thirdData.title), pageView, const Offset(-250, 0));
      await tester.pumpAndSettle();
      await tester.tap(signupButton);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key("signupPage")), findsOneWidget);
    });
    testWidgets("Если очередь пустая и нажата кнопка Вход, то переходит на экран входа", (tester) async {
      final pageView = find.byType(PageView);
      final signinButton = find.widgetWithText(TextButton, "Sign in");

      await tester.runAsync(() => tester.pumpWidget(const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: OnboardingPage(),
            ),
          ))));

      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
          find.text(secondData.title), pageView, const Offset(-250, 0));
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
          find.text(thirdData.title), pageView, const Offset(-250, 0));
      await tester.pumpAndSettle();
      await tester.tap(signinButton);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key("signinPage")), findsOneWidget);
    });
    testWidgets("Наличие вызова метода сохранения флага об успешном прохождении приветствия пользователем", (tester) async {
      final pageView = find.byType(PageView);
      final signupButton = find.widgetWithText(ElevatedButton, "Sign Up");

      const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        return ".";
      });

      await tester.runAsync(() async {
        var dir = await getTemporaryDirectory();
        final File file = File("${dir.path}/onbData.json");

        await tester.pumpWidget(const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: OnboardingPage(),
              ),
            )));
        await tester.pumpAndSettle();
        await tester.dragUntilVisible(
            find.text(secondData.title), pageView, const Offset(-250, 0));
        await tester.pumpAndSettle();
        await tester.dragUntilVisible(
            find.text(thirdData.title), pageView, const Offset(-250, 0));
        await tester.pumpAndSettle();
        await tester.tap(signupButton);
        await tester.pumpAndSettle();
        expect(file.existsSync(), true);
      });
    });
  });
}
