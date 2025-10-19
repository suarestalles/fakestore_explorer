import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Rx para manter o usuário logado (User? é null se não estiver logado)
  // O 'null' inicial garante que não há usuário até que o stream confirme.
  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    
    // 🎯 CHAVE: Conectar o stream do Firebase ao Rx do GetX 🎯
    // Toda vez que o estado de autenticação mudar, o 'firebaseUser' será atualizado.
    firebaseUser.bindStream(_auth.authStateChanges());
    
    // Opcional: Adicionar lógica de redirecionamento (útil para Single-Page App)
    ever(firebaseUser, _initialScreenRedirect);
  }

  // Lógica de redirecionamento baseada no estado do usuário
  void _initialScreenRedirect(User? user) {
    if (user == null) {
      // Usuário não logado, enviar para a tela de Login
      // Usamos 'offAllNamed' para limpar a pilha de navegação
      Get.offAllNamed('/login'); 
    } else {
      // Usuário logado, enviar para a tela principal (Listagem de Produtos)
      Get.offAllNamed('/products');
    }
  }

  // ... (Seu signIn, signUp, signOut functions aqui) ...
}