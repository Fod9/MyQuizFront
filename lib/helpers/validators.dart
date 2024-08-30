class Validator {
  static String? validateName(String value) {
    RegExp regex = RegExp(r'^[A-Za-z\-]+$');
    if (value.isNotEmpty) {
      if (!regex.hasMatch(value)) {
        return 'Veuillez entrer une valeur valide';
      }
    } else {
      return 'Veuillez entrer une valeur';
    }
    return null;
  }

  static String? validateEmail(String value) {
    RegExp regex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value.isNotEmpty) {
      if (!regex.hasMatch(value)) {
        return 'Veuillez entrer une adresse e-mail valide';
      }
    } else {
      return 'Veuillez entrer une adresse e-mail';
    }
    return null;
  }

  static String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Veuillez entrer un nom d\'utilisateur';
    } else if (!RegExp(r'^[a-zA-Z0-9_-]{1,20}$').hasMatch(value)) {
      return 'Ton pseudo ne doit pas faire plus de 20 caractères et ne peut contenir que des lettres, des chiffres, des - ou des _';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Veuillez choisir un mot de passe';
    } else if (!RegExp(r'^.{8,}$').hasMatch(value)) {
      return 'Votre mot de passe doit faire au minimum 8 caractères';
    }
    return null;
  }

  static String? comparePasswords(String value, String initialValue) {
    if (value.isEmpty) {
      return 'Veuillez choisir un mot de passe';
    } else if (value != initialValue) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }
}