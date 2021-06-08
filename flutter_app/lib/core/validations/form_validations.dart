import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/localization/app_localization.dart';
import 'package:flutter_app/resources/string_keys.dart';
import 'package:validators/validators.dart';

enum PasswordType { unidentified, pin, password }

class FormFieldValidatorDiceGame {
  AppLocalizations _localizations;

  FormFieldValidatorDiceGame(this._localizations);

  void dispose() {
    _localizations = null;
  }

  final nameRegularExpresion = RegExp(r'^[a-zöüßä-]+$', caseSensitive: false);

  final _digitRegularExpression = RegExp(r'^[0-9]');
  final Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  String validateFirstName(String value,BuildContext context) {
    if (StringUtils.isNullOrEmpty(value)) {
      return translate(context,StringKeys.errorRegistrationFirstNameEmpty);
    }

    var errorText = '';

    if (value.length < 2 || value.length > 15) {
      errorText = errorText +
          translate(context,StringKeys.errorRegistrationFirstNameRange) +
          '\n';
    }

    if (_startsWithSpecialChar(value)) {
      errorText = errorText +
          translate(context,StringKeys.errorRegistrationFirstNameSpecChar) +
          '\n';
      return errorText.isEmpty ? null : errorText;
    }

    value = _removeSpecialCharFromInput(value);

    if (!nameRegularExpresion.hasMatch(value)) {
      errorText = errorText +
          translate(context,StringKeys.errorRegistrationFirstNameSpecChar);
    }

    return errorText.isEmpty ? null : errorText;
  }

  String validateUsername(String value,BuildContext context) {
    if (StringUtils.isNullOrEmpty(value)) {
      return translate(context,StringKeys.errorUsernameEmpty);
    }

    var errorText = '';
    RegExp regex = new RegExp( pattern );
    if (!value.contains(regex)) {
      errorText = errorText +
          translate(context,StringKeys.usernameShouldBeAValidEmail);
    }

    if (value.startsWith(_digitRegularExpression)) {
      errorText = errorText +
          translate(context,StringKeys.errorUserStartsLetter);
    }

    return errorText.isEmpty ? null : errorText;
  }

  String validateEmail(String value,BuildContext context) {
    if (StringUtils.isNullOrEmpty(value)) {
      return translate(context,StringKeys.inValidEmailError);
    }

    var errorText = '';
    RegExp regex = new RegExp( pattern );
    if (!value.contains(regex)) {
      errorText = errorText +
          translate(context,StringKeys.inValidEmailError);
    }

    if (value.startsWith(_digitRegularExpression)) {
      errorText = errorText +
          translate(context,StringKeys.inValidEmailError);
    }

    return errorText.isEmpty ? null : errorText;
  }

  String validatePassword(String value,BuildContext context) {
    if (StringUtils.isNullOrEmpty(value)) {
      return translate(context,StringKeys.errorPasswordIsEmpty);
    }

    if (value.length > 50) {
      return translate(context,StringKeys.passwordTooLong);
    }

    return null;
  }

  bool _startsWithSpecialChar(String value) {
    return isIn(value[0].toLowerCase(), ['-', '\'']);
  }

  String _removeSpecialCharFromInput(String value) {
    return value.split(" ").join("").split("\'").join("");
  }

  static String removeSpacesFromInput(String value) {
    return value.split(" ").join("");
  }
}