import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_gallery/modules/Login_Screen/login_screen.dart';
import '../network/local/cache_helper.dart';

String? token = '';

File? galleryImage;

void pushReplacementNavigate(context, dynamic widget) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void signOut(context)
{
  CacheHelper.removeUserData(key: 'token').then((value)
  {
    if (value!)
    {
      pushReplacementNavigate(context , const LoginScreen());
    }
  });
}