import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class ReusableGlassWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final double? height;
  const ReusableGlassWidget({Key? key, required this.child, this.margin, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      height: height,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white60, Colors.white10]
                ),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(width: 1, color: Colors.white30)
            ),
            child: child
          ),
        ),
      ),
    );
  }
}

class ReusableTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  const ReusableTextFormField({Key? key, this.hintText, this.controller, required this.obscureText, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 16, fontFamily: 'SegoeUIBold'),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 3),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontFamily: 'SegoeUIBold',
          fontSize: 12,
          height: 0.3
        ),
        hintStyle: const TextStyle(fontFamily: 'SegoeUIBold', fontSize: 16, color: Color(0xff988F8C)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none
        ),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 1, color: Colors.red,)
        ),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 1, color: Colors.red,)
        ),
      ),
    );
  }
}

Widget circularProIndicator({required double? height, required double? width}) =>  Center(
  child: SizedBox(
    height: height,
    width: width,
    child: const CircularProgressIndicator(
      color: Color(0xff7BB3FF),
      strokeWidth: 4,
    ),
  ),
);

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    {
      context,
      required Color? backgroundColor,
      required SnackBarBehavior? barBehavior,
      required int? seconds,
      required String? text,
    })
{
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: backgroundColor,
          elevation: 5,
          behavior: barBehavior,
           duration: Duration(seconds: seconds!),
    content: Text(text!,
    textAlign: TextAlign.center,
    style: const TextStyle(fontSize: 14,fontFamily: 'SegoeUIBold'),)));
}

class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint0 = Paint()
      ..color = const Color(0xffDDCDFF)
      ..style = PaintingStyle.fill

      ..strokeWidth = 1.0;


    Path path0 = Path();
    canvas.drawShadow(path0, Colors.grey, 10, false);
    path0.moveTo(size.width,0);
    path0.quadraticBezierTo(size.width*0.4373594,0,size.width*0.2498125,0);
    path0.quadraticBezierTo(size.width*0.4609250,size.height*0.0670400,size.width*0.4534375,size.height*0.3590000);
    path0.quadraticBezierTo(size.width*0.4421125,size.height*0.6097600,size.width*0.5625000,size.height*0.7000000);
    path0.cubicTo(size.width*0.6223500,size.height*0.7419800,size.width*0.7016875,size.height*0.7467800,size.width*0.7485625,size.height*0.7405000);
    path0.cubicTo(size.width*0.8933125,size.height*0.7201400,size.width*0.9372625,size.height*0.8174800,size.width*0.9518250,size.height*0.8394600);
    path0.cubicTo(size.width*0.9828375,size.height*0.8935200,size.width*1.0039625,size.height*0.9705600,size.width,size.height);
    path0.quadraticBezierTo(size.width*1.0003875,size.height*0.9766800,size.width,0);
    path0.close();

    canvas.drawPath(path0, paint0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

class ReusableHomeButton extends StatelessWidget {
  final String? image;
  final String? text;
  final void Function()? onPressed;
  const ReusableHomeButton({Key? key, this.image, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: onPressed,
      color: Colors.white,
      height: 5.5.h,
      minWidth: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          SvgPicture.asset(image!),
          SizedBox(width: 3.w),
          Text(text!, style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16.sp),)
        ],
      ),
    );
  }
}

class ReusableGalleryButton extends StatelessWidget {
  final String? image;
  final String? text;
  const ReusableGalleryButton({Key? key, this.image, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.h,
      width: 55.w,
      child: MaterialButton(
        elevation: 0,
        onPressed: (){},
        color: Colors.white,
        splashColor: const Color(0xffEFD8F9),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image!),
            const SizedBox(width: 5,),
            Text(text!, style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 22.sp),)
          ],
        ),
      ),
    );
  }
}




