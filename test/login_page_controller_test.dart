import 'package:flutter_test/flutter_test.dart';
import 'package:fakestore_explorer/login/controllers/login_page_controller.dart';
import 'package:flutter/material.dart';

void main() {
  test('login returns early when form is invalid and leaves isLogin true (current behavior)', () async {
    final controller = LoginPageController();

    // garante estado inicial
    expect(controller.isLogin?.value, false);

    // formKey sem currentState -> validação falhará
    controller.formKey = GlobalKey<FormState>();

    await controller.login();

    // Atualmente o código seta isLogin = true antes de validar e não redefine em caso de validação inválida.
    // Este teste detecta esse comportamento (considerado bug) — refatore login() para resetar isLogin ao retornar.
    expect(controller.isLogin?.value, true);
  });

  // Nota: para testar chamadas ao FirebaseAuth (signInWithEmailAndPassword) é recomendável refatorar
  // LoginPageController para aceitar uma instância opcional de FirebaseAuth via construtor:
  //
  //   class LoginPageController extends GetxController {
  //     final FirebaseAuth _auth;
  //     LoginPageController({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;
  //     ...
  //   }
  //
  // Com isso você pode injetar um MockFirebaseAuth / firebase_auth_mocks em testes unitários.
}