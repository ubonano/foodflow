class AppValidators {
  static String? email(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, ingrese un correo electrónico';
    } else if (value != null &&
        value.isNotEmpty &&
        !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$")
            .hasMatch(value)) {
      return 'Por favor, ingrese un correo electrónico válido';
    }
    return null;
  }

  static String? displayName(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, ingrese un nombre completo';
    }
    return null;
  }

  static String? password(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, ingrese una contraseña';
    } else if (value != null && value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  static String? confirmPassword(String? value, String? password,
      {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, confirme la contraseña';
    } else if (value != password) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  static String? date(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, ingrese una fecha';
    } else if (value != null && value.isNotEmpty) {
      try {
        DateTime.parse(value);
      } catch (e) {
        return 'Por favor, ingrese una fecha válida (AAAA-MM-DD)';
      }
    }
    return null;
  }

  static String? amount(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, ingrese un monto';
    } else if (value != null && value.isNotEmpty) {
      try {
        double.parse(value);
      } catch (e) {
        return 'Por favor, ingrese un monto válido';
      }
    }
    return null;
  }

  static String? idNumber(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, ingrese un número de identificación';
    }
    return null;
  }

  static String? name(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, ingrese un nombre';
    }
    return null;
  }

  static String? lastName(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, ingrese un apellido';
    }
    return null;
  }

  static String? phone(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, ingrese un teléfono';
    }
    return null;
  }

  static String? address(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, ingrese una dirección';
    }
    return null;
  }

  static String? tableNumber(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, ingrese un número de mesa';
    } else if (value != null && int.tryParse(value) == null) {
      return 'Por favor, ingrese un número de mesa válido';
    }
    return null;
  }

  static String? numberOfGuests(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, ingrese la cantidad de comensales';
    } else if (value != null && int.tryParse(value) == null) {
      return 'Por favor, ingrese una cantidad válida de comensales';
    }
    return null;
  }

  static String? waiterName(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, ingrese el nombre del mesero';
    }
    return null;
  }

  static bool _isEmptyOrNull(String? value, bool required) {
    return required && (value == null || value.isEmpty);
  }
}
