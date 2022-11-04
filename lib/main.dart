import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/shared/bloc_observer.dart';
import 'package:my_gallery/shared/components/const.dart';
import 'package:my_gallery/shared/cubit/cubit.dart';
import 'package:my_gallery/shared/network/local/cache_helper.dart';
import 'package:my_gallery/shared/network/remote/dio_helper.dart';
import 'package:sizer/sizer.dart';
import 'modules/Home_Screen/home_screen.dart';
import 'modules/Login_Screen/login_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  token = CacheHelper.getDataIntoShPre(key: 'token');

  late Widget widget;

    if(token != null)
    {
      widget = const HomeScreen();
    }
    else
    {
      widget = const LoginScreen();
    }

  Bloc.observer = MyGalleryBlocObserver();
  runApp(MyGallery(startWidget: widget,));

}
class MyGallery extends StatelessWidget {
  final Widget startWidget;
  const MyGallery({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:
        [
          BlocProvider(create: (context) => AppCubit()..getGalleryImages())
        ],
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: startWidget,
              theme: ThemeData(
                  textTheme: const TextTheme(
                    bodyText1: TextStyle(fontSize: 30, fontFamily: 'SegoeUIBold', color: Colors.black),
                    bodyText2: TextStyle(fontSize: 32, color: Colors.black, fontWeight: FontWeight.w400),
                  )
              ),
            );
          }),
        );
  }
}

