import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/modules/Login_Screen/Login_Cubit/cubit.dart';
import 'package:my_gallery/modules/Login_Screen/Login_Cubit/states.dart';
import 'package:my_gallery/shared/components/components.dart';
import '../../shared/components/const.dart';
import '../../shared/network/local/cache_helper.dart';
import '../Home_Screen/home_screen.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginKey = GlobalKey<FormState>();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
    child: BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state)
      {
          if(state is LoginSuccessState)
            {
              {
                CacheHelper.saveData(key: 'token', value: state.loginModel.token).then((value) =>
                {

                  token = CacheHelper.getDataIntoShPre(key: 'token'),
                  LoginCubit.get(context).emailController.clear(),
                  LoginCubit.get(context).passwordController.clear(),
                  pushReplacementNavigate(context, const HomeScreen())
                });
              }
            }
          else if (state is LoginErrorState)
          {
            snackBar(
                context: context,
                backgroundColor: Colors.red,
                barBehavior: SnackBarBehavior.floating,
                seconds: 4, text: 'Email or Password incorrect !'
            );
          }
      },
      builder: (context, state)
      {
        var loginCubit = LoginCubit.get(context);
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/log in.png')
            ),),
            child: Align(
              alignment: AlignmentDirectional.center,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll){
                  overScroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: ReusableGlassWidget(height: 345, margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2,left: 30,right: 30,
                  ),
                      child: Form(
                        key: loginKey,
                        child: Column(
                          children: [
                            Text('LOG IN' ,style: Theme.of(context).textTheme.bodyText1?.copyWith(color: const Color(0xff4A4A4A)),),
                            const SizedBox(height: 30,),
                            ReusableTextFormField(
                              obscureText: false,
                              hintText: 'User Name',
                              controller: loginCubit.emailController,
                              validator: (value) => loginCubit.emailValidation(value),
                            ),
                            const SizedBox(height: 25,),
                            ReusableTextFormField(
                              obscureText: true,
                              hintText: 'Password',
                              controller: loginCubit.passwordController,
                              validator: (value) => loginCubit.passwordValidation(value),
                            ),
                            const Spacer(),
                            ConditionalBuilder(
                              condition: state is! LoginSuccessState,
                              builder: (context) => MaterialButton(
                                minWidth: 282.42,
                                onPressed: ()
                                {
                                  if(loginKey.currentState!.validate())
                                  {
                                    loginCubit.userLogin(email: loginCubit.emailController.text, password: loginCubit.passwordController.text);
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                color: const Color(0xff7BB3FF),
                                height: 46.11,
                                child: Text('SUBMIT' ,style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18, color: Colors.white),),
                              ),
                              fallback: (context) =>SizedBox(
                                height: 46.11,
                                child: circularProIndicator(width: 40, height: 40),
                              ),
                            ),
                            const SizedBox(height: 15,)
                          ],
                        ),
                      )
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
    );
  }
}
