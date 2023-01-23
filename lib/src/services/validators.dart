import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Digite seu email!';
  }
  if (!email.isEmail) return 'Digite um email válido!';
  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Digite uma senha válida!';
  }
  if (password.length < 6) {
    return 'Digite uma senha com pelo menos 6 dígitos';
  }
  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Digite um nome';
  }
  if (name.split(' ').length < 2) {
    return 'Digite seu nome completo!';
  }
  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Digite um celular';
  }

  if (phone.length < 14 || !phone.isPhoneNumber) {
    return 'Digite um celular válido';
  }
  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Digite um cpf';
  }
  if (!cpf.isCpf) {
    return 'Digite um cpf válido';
  }
  return null;
}
