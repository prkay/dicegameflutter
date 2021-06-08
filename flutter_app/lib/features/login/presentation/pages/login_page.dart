import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/core/validations/form_validations.dart';
import 'package:flutter_app/features/login/presentation/bloc/bloc.dart';
import 'package:flutter_app/features/register/presentation/pages/registration_page.dart';
import 'package:flutter_app/injection/injection_container.dart';
import 'package:flutter_app/localization/app_localization.dart';
import 'package:flutter_app/resources/dice_game_colors.dart';
import 'package:flutter_app/resources/margin_keys.dart';
import 'package:flutter_app/resources/string_keys.dart';
import 'package:flutter_app/resources/styles/text_styles.dart';
import 'package:flutter_app/resources/widgets/default_button.dart';
import 'package:flutter_app/resources/widgets/hyperlink_widget.dart';
import 'package:flutter_app/resources/widgets/input_field_widget.dart';
import 'package:flutter_app/resources/widgets/progress_loader_widget.dart';
import 'package:flutter_app/resources/widgets/textfield_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLoginPage extends StatefulWidget {
  AppLoginPage({Key key}) : super(key: key);

  @override
  _AppLoginPageState createState() => _AppLoginPageState();
}

class _AppLoginPageState extends State<AppLoginPage> {
  bool landingDone = false;
  LoginBloc _loginBloc;
  var _landingDone = false;
  bool _isLoading = true;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode userNameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  final formKey = new GlobalKey<FormState>();
  FormFieldValidatorDiceGame _fieldValidator=
  FormFieldValidatorDiceGame(null);
  String _userName = "";
  String _password = "";

  @override
  void initState() {
    _loginBloc = di<LoginBloc>();
    _loginBloc.add(LoginPageReadyEvent());
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();
    userNameController.dispose();
    passwordController.dispose();
    userNameFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is LoginPageReadyState) {
          print(state.landingDone);
          print(state.isLoading);
          _landingDone = state.landingDone;
        }
      },
      builder: (context, state) {
        return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(children: <Widget>[
                GestureDetector(
                  onTap: () => _clearAllFocus(),
                  child: ProgressHUD(
                      inAsyncCall: state.isLoading,
                      child: Container(
                        color: DiceGameAppColors.primaryBodyColor,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: SafeArea(child: _getBodyContent(context)),
                        ),
                      )),
                ),
              ]),
            );
      },
    );
  }

  _getLoginButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MarginKeys.zeroMargin,
        bottom: MarginKeys.topBottomMarginToButton,
      ),
      child: DefaultButton(
        label: translate(context, StringKeys.loginWithAccount),
        onPressed: () {
          _clearAllFocus();
          validateAndSave();
          // toDo perform login function here
        },
      ),
    );
  }

  _getRegisterButton(BuildContext context) {
    return DefaultHyperLinkButton(
      label: translate(context, StringKeys.registerNewAccount),
      onPressed: () async {
        _clearAllFocus();
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterationPage(),
          ),
        );
        formKey.currentState.reset();
      },
    );
  }

  _getLoginInputFields(BuildContext context) {
    return InputFieldsContainer(
        bodyContent: _getInputFieldBodyContent(context));
  }

  _getInputFieldBodyContent(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            _getUserNameInputField(context),
            _getSeparator(context),
            _getPasswordInputField(context)
          ],
        ));
  }

  _getUserNameInputField(BuildContext context) {
    return TextFieldWidgets(
      inputStyle: userNameFocus.hasFocus
          ? TextStyles.inputFieldLabelTextStyle
          : TextStyles.inputFieldLabelTextStyle,
      focusNode: userNameFocus,
      whitelistingTextInputFormatter:
      WhitelistingTextInputFormatter(RegExp('[^\\s]')),
      labelStyle: userNameFocus.hasFocus
          ? TextStyles.inputFieldLabelTextStyle
          : TextStyles.inputFieldLabelTextStyle,
      inputPlaceHolder:
      translate(context, StringKeys.usernameTextFieldLabelText),
      controller: userNameController,
      validator: (value) {
        return _fieldValidator.validateEmail(value, context);
      },
      onSaved: (value) {
        return _userName = value;
      },
      isVisible: false,
      inputType: TextInputType.emailAddress,
    );
  }

  _getPasswordInputField(BuildContext context) {
    return TextFieldWidgets(
      inputStyle: passwordFocus.hasFocus
          ? TextStyles.inputFieldLabelTextStyle
          : TextStyles.inputFieldLabelTextStyle,
      focusNode: passwordFocus,
      whitelistingTextInputFormatter:
      WhitelistingTextInputFormatter(RegExp('[^\\s]')),
      labelStyle: passwordFocus.hasFocus
          ? TextStyles.inputFieldLabelTextStyle
          : TextStyles.inputFieldLabelTextStyle,
      inputPlaceHolder:
      translate(context, StringKeys.passwordTextFieldLabelText),
      controller: passwordController,
      validator: (value) {
        return _fieldValidator.validatePassword(value, context);
      },
      onSaved: (value) {
        return _password = value;
      },
      isVisible: true,
      inputType: TextInputType.visiblePassword,
    );
  }

  void validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
    }
  }

  _clearAllFocus() {
    userNameFocus.unfocus();
    passwordFocus.unfocus();
  }

  _getSeparator(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MarginKeys.zeroMargin),
      color: DiceGameAppColors.inputFieldSeparatorColor,
      height: DimensionKeys.heightOfInputFieldSeparator,
    );
  }

  _getBodyContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MarginKeys.commonVerticallMarginForScreenContent,
          left: MarginKeys.commonHorizontalMarginForScreenContent,
          right: MarginKeys.commonHorizontalMarginForScreenContent),
      child: Column(
        children: [
          _getLoginInputFields(context),
          _getLoginButton(context),
          _getRegisterButton(context),
        ],
      ),
    );
  }
}