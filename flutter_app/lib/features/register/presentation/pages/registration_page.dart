import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/core/validations/form_validations.dart';
import 'package:flutter_app/features/login/presentation/pages/login_page.dart';
import 'package:flutter_app/features/register/model/registration_request_model.dart';
import 'package:flutter_app/features/register/presentation/bloc/bloc.dart';
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
import 'package:flutter_app/resources/widgets/snack_bar_message.dart';
import 'package:flutter_app/resources/widgets/textfield_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterationPage extends StatefulWidget {
  RegisterationPage({Key key}) : super(key: key);

  @override
  _RegisterationPageState createState() => _RegisterationPageState();
}

class _RegisterationPageState extends State<RegisterationPage> {
  bool landingDone = false;
  RegistrationBloc _registrationBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _landingDone = false;
  bool _isLoading = true;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  FocusNode userNameFocus = FocusNode();
  FocusNode firstNameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  final formKey = new GlobalKey<FormState>();
  FormFieldValidatorDiceGame _fieldValidator=
  FormFieldValidatorDiceGame(null);
  String _userName = "";
  String _password = "";
  String _firstName = "";

  @override
  void initState() {
    _registrationBloc = di<RegistrationBloc>();
    _registrationBloc.add(RegistrationPageReadyEvent());
    super.initState();
  }

  @override
  void dispose() {
    _registrationBloc.close();
    userNameController.dispose();
    firstNameController.dispose();
    passwordController.dispose();
    userNameFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _registrationBloc,
      listener: (context, state) {
        if (state is RegistrationPageReadyState) {
          print(state.landingDone);
          print(state.isLoading);
          _landingDone = state.landingDone;
        }else if(state is UserRegistrationSuccessState){
          SnackBarMessageWidget(state.message,_scaffoldKey).buildSnackBar();
        }else if(state is UserRegistrationFailedState){
          SnackBarMessageWidget(state.errorMessageKey,_scaffoldKey).buildSnackBar();
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            key: _scaffoldKey,
              children: <Widget>[
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

  _getRegisterButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MarginKeys.zeroMargin,
        bottom: MarginKeys.topBottomMarginToButton,
      ),
      child: DefaultButton(
        label: translate(context, StringKeys.register),
        onPressed: () {
          _clearAllFocus();
          validateAndSave();
        },
      ),
    );
  }

  _getLoginButton(BuildContext context) {
    return DefaultHyperLinkButton(
      label: translate(context, StringKeys.alreadyHaveAccountLogin),
      onPressed: () async {
        _clearAllFocus();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (c) => AppLoginPage()), (route) => false);
        formKey.currentState.reset();
      },
    );
  }

  _getRegisterationInputFields(BuildContext context) {
    return InputFieldsContainer(
        bodyContent: _getInputFieldBodyContent(context));
  }

  _getInputFieldBodyContent(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            _getFirstNameInputField(context),
            _getSeparator(context),
            _getUserNameInputField(context),
            _getSeparator(context),
            _getPasswordInputField(context)
          ],
        ));
  }

  _getFirstNameInputField(BuildContext context) {
    return TextFieldWidgets(
      inputStyle: firstNameFocus.hasFocus
          ? TextStyles.inputFieldLabelTextStyle
          : TextStyles.inputFieldLabelTextStyle,
      focusNode: firstNameFocus,
      whitelistingTextInputFormatter:
      WhitelistingTextInputFormatter(RegExp('[^\\s]')),
      labelStyle: firstNameFocus.hasFocus
          ? TextStyles.inputFieldLabelTextStyle
          : TextStyles.inputFieldLabelTextStyle,
      inputPlaceHolder:
      translate(context, StringKeys.firstName),
      controller: firstNameController,
      validator: (value) {
        return _fieldValidator.validateFirstName(value, context);
      },
      onSaved: (value) {
        return _firstName = value;
      },
      isVisible: false,
      inputType: TextInputType.name,
    );
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
      UserModel  userModel = UserModel(
        email: userNameController.text,
        password: passwordController.text,
        name: firstNameController.text,
        numberOfGame: 0,
        totalPoints: 0,
      );
      _registrationBloc.add(RegistrationStart(userModel));
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
          _getRegisterationInputFields(context),
          _getRegisterButton(context),
          _getLoginButton(context),
        ],
      ),
    );
  }
}