import 'dart:developer';

import 'package:fakestore_explorer/utils/my_snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {

  // Criando 
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final userController = TextEditingController(text: 'user_test@franqstore.com');
  final passwordController = TextEditingController(text: 'usertestfranqstore');

  get isAuthenticated => _auth.currentUser == null;
  get userEmail => _auth.currentUser?.email;

  RxBool? isLogin = false.obs;

  Future<void> login() async {
    // Muda o estado da variável observável para true, indicando que o login está em andamento
    isLogin?.value = true;

    // Caso o formulário não seja válido, retorna sem fazer nada
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      return;
    }
    try {
      // Tenta fazer o login com email e senha fornecidos
      await _auth.signInWithEmailAndPassword(
        email: userController.text,
        password: passwordController.text,
      );

      // Volta o estado da variável observável para false, indicando que o login foi concluído
      isLogin?.value = false;
    } on FirebaseAuthException catch (e) {
      // Caso o erro durante o login seja de usuário não encontrado ou senha incorreta,
      // exibe uma notificação apropriada
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        MySnackbars.errorSnackBar('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // Caso a senha esteja incorreta, exibe uma notificação apropriada
        log('Wrong password provided for that user.');
        MySnackbars.errorSnackBar('Wrong password provided for that user.');
      } else {
        log(e.message.toString());
        // Para outros erros, exibe a mensagem de erro retornada
        MySnackbars.errorSnackBar(e.message ?? 'Unknown error.');
      }
      isLogin?.value = false;
    }
  }

  Future<void> logout() async {
    try {
      // 1. CHAMA O MÉTODO SIGN OUT DO FIREBASE
      await _auth.signOut();
      
      // O stream de autenticação (authStateChanges) será disparado, 
      // e o AuthController fará o redirecionamento automaticamente
      
      // Leva o usuário de volta para a tela de login e limpa toda a pilha.
      Get.offAllNamed('/login'); 
      
      // Retorna uma notificação de sucesso
      MySnackbars.successSnackBar('Session ended successfully.');
      
    } on FirebaseAuthException catch (e) {
      log('Error logging out: ${e.message}');
      // Retorna uma notificação de erro
      MySnackbars.errorSnackBar('Unable to exit session.');
    } catch (e) {
      log('Unknown error while logging out: $e');
      // Retorna uma notificação de erro
      MySnackbars.errorSnackBar('An unknown error occurred.');
    }
  }

}