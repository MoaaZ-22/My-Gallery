import 'package:my_gallery/models/login_model.dart';

abstract class LoginStates {}
class InitialLoginState extends LoginStates {}

// Show Password In Login Screen
class ShowPasswordLoginScreen extends LoginStates{}

class ShowCorrectEmailLoginScreen extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState({required this.error});
}