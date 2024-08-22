import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  final bool success;

  AuthResult({required this.success});
}

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<String?> login({required String email, required String senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Usuário não encontrado';
      } else if (e.code == 'wrong-password') {
        return 'Senha incorreta';
      }
      return e.code;
    } catch (e) {
      return 'Erro desconhecido ao fazer login: $e';
    }
  }

  Future<String?> register({required String email, required String senha, required String nome}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: senha);
      User? user = userCredential.user;

      if (user != null) {
        // Atualiza o nome de exibição do usuário
        await user.updateProfile(displayName: nome);

        // Salva o nome, email e uid no Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'nome': nome,
          'email': email,
          'uid': user.uid,
        });

        return null; // Retorna null em caso de sucesso
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'O email já está em uso!';
      }
      return e.code;
    } catch (e) {
      return 'Erro desconhecido ao registrar usuário: $e';
    }
  }

  Future<String?> redefinicaoSenha({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Usuário não encontrado';
      }
      return e.code;
    } catch (e) {
      return 'Erro desconhecido ao redefinir senha: $e';
    }
  }
}
