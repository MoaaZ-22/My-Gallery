import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ImagesCard extends StatelessWidget {
  const ImagesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13.5.h,
      width: 30.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage('https://img.freepik.com/free-photo/beautiful-scenery-green-valley-near-alp-mountains-austria-cloudy-sky_181624-6979.jpg?size=626&ext=jpg')
          )
      ),
    );
  }
}
