import 'package:fakestore_explorer/login/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fakestore_explorer/login/controllers/login_page_controller.dart';
// import 'package:fakestore_explorer/login/login_page.dart';

class MockLoginController extends Mock implements LoginPageController {}

void main() {
  setUpAll(() {
    Get.testMode = true;
  });

  testWidgets('LoginPage renders fields and calls controller.login on tap', (tester) async {
    final mockCtrl = MockLoginController();

    when(() => mockCtrl.formKey).thenReturn(GlobalKey<FormState>());
    when(() => mockCtrl.userController).thenReturn(TextEditingController());
    when(() => mockCtrl.passwordController).thenReturn(TextEditingController());
    when(() => mockCtrl.isLogin).thenReturn(false.obs);
    when(() => mockCtrl.login()).thenAnswer((_) async {});

    Get.put<LoginPageController>(mockCtrl);

    await tester.pumpWidget(GetMaterialApp(home: Scaffold(body: LoginPage())));
    await tester.pumpAndSettle();

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    verify(() => mockCtrl.login()).called(1);
  });
}