import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final userController = TextEditingController(text: 'user_test@franqstore.com');
  final passwordController = TextEditingController(text: 'usertestfranqstore');

  get isAuthenticated => _auth.currentUser == null;
  get userEmail => _auth.currentUser?.email;

  Future<void> login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: userController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        Get.snackbar('ERROR', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        Get.snackbar('ERROR', 'Wrong password provided for that user.');
      } else {
        log(e.message.toString());
        Get.snackbar(
          'ERROR',
          e.message ?? 'Unknown error.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Future<void> logout() async {
    try {
      // 1. CHAMA O MÉTODO SIGN OUT DO FIREBASE
      await _auth.signOut();
      
      // O stream de autenticação (authStateChanges) será disparado, 
      // e o AuthController fará o redirecionamento automaticamente
      // (Se você usou o método `ever` que eu sugeri anteriormente).
      
      // 2. REDIRECIONAMENTO MANUAL (para garantir, se você não usa o `ever`)
      // Leva o usuário de volta para a tela de login e limpa toda a pilha.
      Get.offAllNamed('/login'); 
      
      Get.snackbar(
        'Sucesso', 
        'Sessão encerrada com sucesso.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white
      );
      
    } on FirebaseAuthException catch (e) {
      log('Erro ao fazer logout: ${e.message}');
      Get.snackbar(
        'ERRO', 
        'Não foi possível sair da sessão.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white
      );
    } catch (e) {
      log('Erro desconhecido ao fazer logout: $e');
      Get.snackbar(
        'ERRO', 
        'Ocorreu um erro desconhecido.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white
      );
    }
  }

}