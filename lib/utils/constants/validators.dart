class TValidator {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Nome é obrigatório';

    if (value.length < 3) return 'Nome deve conter ao menos 3 caracteres';

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email é obrigatório';

    // Regex for email verification
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) return 'Email inválido';

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Senha é obrigatória';

    if (value.length < 6) return 'Senha deve conter 6 caracteres';

    if (!value.contains(RegExp(r'[0-9]'))) return 'Senha deve conter pelo menos 1 número';

    if (!value.contains(RegExp(r'[!@#$%^&*,.?":{}|<>]')))
      return 'Senha deve conter pelo menos 1 caractere especial';

    return null;
  }
}
