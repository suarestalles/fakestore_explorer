import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class MyTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final Function onChanged;
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final List<FormFieldValidator<String>>? validators;
  const MyTextFormField(this.controller, this.onChanged, this.labelText, this.icon, {super.key, this.obscureText = false, this.validators,});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Controlador do campo de texto
      controller: widget.controller,
      // Texto exibido como pontos para campos de senha
      obscureText: widget.obscureText,
      // Funções de validação passadas como parâmetro
      validator: Validatorless.multiple(widget.validators ?? []),
      // Decoração do campo de texto
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: 16,
        ),
        hintText: widget.labelText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        prefixIcon: Icon(
          widget.icon,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
      // Chama a função onChanged passada como parâmetro quando o valor do campo muda
      onChanged: (_) async => await widget.onChanged(),
    );
  }
}