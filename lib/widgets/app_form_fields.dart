import 'package:flutter/material.dart';
import '../utils/app_validators.dart';

class _AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onFieldSubmitted;

  const _AppTextField({
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enabled,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class AppFormFields {
  static Widget email(
    TextEditingController controller, {
    bool enabled = true,
    void Function(String)? onFieldSubmitted,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'Email',
      keyboardType: TextInputType.emailAddress,
      validator: AppValidators.email,
      enabled: enabled,
    );
  }

  static Widget password(TextEditingController controller,
      {void Function(String)? onFieldSubmitted}) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'Contraseña',
      obscureText: true,
      validator: AppValidators.password,
    );
  }

  static Widget passwordConfirmation(
    TextEditingController controller,
    TextEditingController passwordController, {
    void Function(String)? onFieldSubmitted,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'Confirmar contraseña',
      obscureText: true,
      validator: (value) =>
          AppValidators.confirmPassword(value, passwordController.text),
    );
  }

  static Widget date(
    TextEditingController controller, {
    bool enabled = true,
    void Function(String)? onFieldSubmitted,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'Fecha',
      keyboardType: TextInputType.datetime,
      enabled: enabled,
      validator: AppValidators.date,
    );
  }

  static Widget amount(
    TextEditingController controller, {
    bool enabled = true,
    void Function(String)? onFieldSubmitted,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'Monto',
      keyboardType: TextInputType.number,
      validator: AppValidators.amount,
      enabled: enabled,
    );
  }

  static Widget name(
    TextEditingController controller, {
    void Function(String)? onFieldSubmitted,
    bool enabled = true,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'Nombre',
      validator: AppValidators.name,
      enabled: enabled,
    );
  }

  static Widget lastName(
    TextEditingController controller, {
    bool enabled = true,
    void Function(String)? onFieldSubmitted,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'Apellido',
      validator: AppValidators.lastName,
      enabled: enabled,
    );
  }

  static Widget idNumber(
    TextEditingController controller, {
    bool enabled = true,
    void Function(String)? onFieldSubmitted,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'Número de identificación',
      validator: AppValidators.idNumber,
      enabled: enabled,
    );
  }

  static Widget phone(
    TextEditingController controller, {
    bool enabled = true,
    void Function(String)? onFieldSubmitted,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'Teléfono',
      keyboardType: TextInputType.phone,
      validator: AppValidators.phone,
      enabled: enabled,
    );
  }

  static Widget address(
    TextEditingController controller, {
    bool enabled = true,
    void Function(String)? onFieldSubmitted,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'Dirección',
      keyboardType: TextInputType.streetAddress,
      validator: AppValidators.address,
      enabled: enabled,
    );
  }

  static Widget isActiveSwitch(bool isActive, void Function(bool)? onChanged) {
    return Row(
      children: [
        const Text('Activo'),
        Switch(
          value: isActive,
          onChanged: onChanged,
        ),
      ],
    );
  }

  static Widget tableNumber(
    TextEditingController controller, {
    bool enabled = true,
    void Function(String)? onFieldSubmitted,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'Número de mesa',
      keyboardType: TextInputType.number,
      validator: AppValidators.tableNumber,
      enabled: enabled,
    );
  }

  static Widget numberOfGuests(
    TextEditingController controller, {
    bool enabled = true,
    void Function(String)? onFieldSubmitted,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'Cantidad de comensales',
      keyboardType: TextInputType.number,
      validator: AppValidators.numberOfGuests,
      enabled: enabled,
    );
  }

  static Widget waiterName(
    TextEditingController controller, {
    bool enabled = true,
    void Function(String)? onFieldSubmitted,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'Nombre del mesero',
      validator: AppValidators.waiterName,
      enabled: enabled,
    );
  }
}
