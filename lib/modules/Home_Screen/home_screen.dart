import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/modules/Home_Screen/images_card.dart';
import 'package:my_gallery/shared/cubit/cubit.dart';
import 'package:my_gallery/shared/cubit/states.dart';
import 'package:sizer/sizer.dart';
import '../../shared/components/components.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/gellary.png')
              )
          ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.20,
              width: double.infinity,
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 3.9.w),
                        child: RichText(
                          text: TextSpan(
                            text: 'Welcome, \n',
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(height: 0.15.h, ),
                            children: const [
                              TextSpan(
                                text: 'Mina',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      CustomPaint(
                        size: Size(MediaQuery.of(context).size.width*0.53,(MediaQuery.of(context).size.height*0.20).toDouble()),
                        painter: RPSCustomPainter(),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 4.5.h,
                    right: 3.3.h,
                    child: CachedNetworkImage(
                      alignment: Alignment.center,
                      imageUrl: 'https://scontent-mrs2-1.xx.fbcdn.net/v/t39.30808-6/295478377_1266326634105151_609110673496022304_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=T4jCTpDV2KMAX_GRFOw&_nc_ht=scontent-mrs2-1.xx&oh=00_AfAJAGI-JaZKhlN8cMKyFU2pYOz4oddrlzVzavsF4e2KIg&oe=6369CA5C',
                      imageBuilder: (context, imageProvider) => SizedBox(
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage: imageProvider,
                        ),
                      ),
                      placeholder: (context , url) => Align(child: circularProIndicator(width: 20, height: 20)),
                      errorWidget: (context, url, error) => const Align(child: Icon(Icons.error_outline, color: Colors.red,),),
                    ),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ReusableHomeButton(text: 'Log out', image: 'assets/images/logout.svg',
                onPressed: (){},
                ),
                ReusableHomeButton(text: 'Upload', image: 'assets/images/upload.svg',
                onPressed: ()
                {
                  showDialog(
                    barrierColor: Colors.transparent,
                      context: context,
                      builder: (context) =>
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 25.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                              child: Container(
                                height: 35.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Colors.white60, Colors.white10]
                                    ),
                                    borderRadius: BorderRadius.circular(32),
                                    border: Border.all(width: 2, color: Colors.white54)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    const ReusableGalleryButton(
                                      text: 'Gallery',
                                      image: 'assets/images/FromGallery.png',
                                    ),
                                    SizedBox(height: 6.h,),
                                    const ReusableGalleryButton(
                                      text: 'Camera',
                                      image: 'assets/images/FromCamera.png',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                  );
                },
                )
              ],
            ),
            Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.only(left: 4.w ,right: 4.w, top: 3.h, bottom: 3.h),
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1.5.h,
                    crossAxisSpacing: 5.w,
                    childAspectRatio: 0.15.h,
                  ),
                  itemCount: 30,
                  itemBuilder: (context, index) => const ImagesCard()),
            )
          ],
        ),
        );
      },
    );
  }
}
