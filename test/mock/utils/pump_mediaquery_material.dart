import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpWidgetWithMediaQueryAndMaterialApp(
    WidgetTester tester, Widget widget,
    {List<NavigatorObserver>? navigatorObserver}) async {
  if (navigatorObserver != null) {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: widget,
          navigatorObservers: navigatorObserver,
        ),
      ),
    );
  } else {
    await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(), child: MaterialApp(home: widget)));
  }
}
