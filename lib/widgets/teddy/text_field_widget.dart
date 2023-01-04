import 'package:flutter/material.dart';
import 'package:messenger/enums/text_field_design.dart';
import 'package:messenger/enums/text_field_rule.dart';
import 'package:messenger/utilities/imports.dart';

class TextFieldWidget extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final GestureTapCallback? onTap;
  final Function()? onEditingComplete;
  final String? Function(String? input)? validator;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextFieldRule? textFieldRule;
  final TextFieldDesign textFieldDesign;

  const TextFieldWidget({
    this.labelText,
    this.hintText,
    this.onTap,
    this.onEditingComplete,
    this.focusNode,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.textFieldRule,
    this.validator,
    this.textFieldDesign = TextFieldDesign.normal,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _showPassword = false;

  Widget? _suffixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if (widget.obscureText) {
      if (!_showPassword) {
        return InkWell(
          onTap: () {
            setState(() {
              _showPassword = true;
            });
          },
          child: const Icon(Icons.visibility),
        );
      } else {
        return InkWell(
          onTap: () {
            setState(() {
              _showPassword = false;
            });
          },
          child: const Icon(Icons.visibility_off),
        );
      }
    }
    return null;
  }

  String? _validateLength(AppLocalizations? strings, String? input) {
    var minLength = widget.textFieldRule?.rule.minLength;
    if (minLength == null) return null;
    if (input!.length >= minLength) return null;
    return "${strings?.lengthError} $minLength ${strings?.characters}";
  }

  String? _validateRegex(AppLocalizations? strings, String? input) {
    var regexRule = widget.textFieldRule?.rule.regexRule;
    if (regexRule == null) return null;
    RegExp regex = RegExp(regexRule);
    if (regex.hasMatch(input ?? "")) return null;
    switch (widget.textFieldRule) {
      case null:
        return null;
      case TextFieldRule.email:
        return strings?.regexErrorEmail ?? "";
      case TextFieldRule.password:
        return strings?.regexErrorPassword ?? "";
    }
  }

  String? _validator(BuildContext context, String? input) {
    if (widget.textFieldRule == null) return null;
    var strings = AppLocalizations.of(context);
    if (input == null || input.isEmpty == true) {
      return strings?.fieldCanNotBeEmpty ?? "";
    }
    var lengthPass = _validateLength(strings, input);
    var regexPass = _validateRegex(strings, input);
    var validator = widget.validator?.call(input);
    if (lengthPass != null) {
      return lengthPass;
    } else if (regexPass != null) {
      return regexPass;
    } else if (validator != null) {
      return validator;
    } else {
      return null;
    }
  }

  InputBorder get border {
    switch (widget.textFieldDesign) {
      case TextFieldDesign.normal:
        return const OutlineInputBorder();
      case TextFieldDesign.borderLess:
        return InputBorder.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: widget.obscureText && !_showPassword,
      maxLength: widget.textFieldRule?.rule.maxLength,
      validator: (value) {
        return _validator(context, value);
      },
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _suffixIcon(),
        hintText: widget.hintText,
        border: border,
      ),
    );
  }
}
