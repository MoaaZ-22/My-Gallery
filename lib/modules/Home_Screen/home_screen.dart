import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/shared/components/const.dart';
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
      listener: (context, state) {
        if(state is GalleryImagePickedSuccessState)
          {
              Navigator.pop(context);
          }
        else if (state is GalleryImagePickedErrorState)
          {
            snackBar(text: 'No image selected, Pls try Again', backgroundColor: Colors.red, seconds: 2, context: context, barBehavior: SnackBarBehavior.floating);
          }
        else if(state is CameraImagePickedSuccessState)
        {
          Navigator.pop(context);
        }
        else if (state is CameraImagePickedErrorState)
        {
          snackBar(text: 'No image taken, Pls try Again', backgroundColor: Colors.red, seconds: 2, context: context, barBehavior: SnackBarBehavior.floating);
        }
        else if (state is UploadGalleryImageSuccessState)
          {
            pickedImage?.delete();
          }
      },
      builder: (context, state)
      {
        return Scaffold(
          body: Container(
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
                                    text: 'MoaaZ',
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
                          imageUrl: 'https://scontent-hbe1-1.xx.fbcdn.net/v/t39.30808-6/295478377_1266326634105151_609110673496022304_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=T4jCTpDV2KMAX_GRFOw&_nc_ht=scontent-hbe1-1.xx&oh=00_AfBhPpK39XAeKBN_qNLkiZnMTnbjJ3e_9RWvRpO04CLzUg&oe=6369CA5C',
                          imageBuilder: (context, imageProvider) => Container(
                            height: 7.h,
                            width: 15.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider
                                )
                            ),
                          ),
                          placeholder: (context , url) => SizedBox(
                              height: 7.h,
                              width: 15.w,
                              child: circularProIndicator(width: 20, height: 20)),
                          errorWidget: (context, url, error) => SizedBox(
                              height: 7.h,
                              width: 15.w,
                              child: const Icon(Icons.error_outline, color: Colors.red,)),
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
                      onPressed: (){
                        signOut(context);
                      },
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
                                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
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
                                              ReusableGalleryButton(
                                                text: 'Gallery',
                                                image: 'assets/images/FromGallery.png',
                                                onPressed: ()
                                                {
                                                  AppCubit.get(context).pickGalleryImage();
                                                },
                                              ),
                                              SizedBox(height: 6.h,),
                                              ReusableGalleryButton(
                                                text: 'Camera',
                                                image: 'assets/images/FromCamera.png',
                                                onPressed: (){
                                                  AppCubit.get(context).pickCameraImage();
                                                },
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
                ConditionalBuilder(condition: AppCubit.get(context).imagesModel != null,
                    builder: (context) => AppCubit.get(context).imagesModel!.data!.images!.isEmpty ?
                    Container(
                        height: 60.h,
                        alignment: AlignmentDirectional.center,
                        child: Text('There are no pictures to display', style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey, fontSize: 16),))
                        :
                    GridView.count(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(left: 4.w ,right: 4.w, top: 3.h, bottom: 3.h),
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 3,
                      mainAxisSpacing: 1.5.h,
                      crossAxisSpacing: 5.w,
                      childAspectRatio: 0.15.h,
                      children: List.generate(
                          AppCubit.get(context).imagesModel!.data!.images!.length,
                              (index) => CachedNetworkImage(
                            imageUrl: AppCubit.get(context).imagesModel!.data!.images![index],
                            imageBuilder: (context, imageProvider) => Container(
                              height: 13.5.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: imageProvider
                                  )
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              alignment: AlignmentDirectional.center,
                              height: 13.5.h,
                              width: 30.w,
                              child: circularProIndicator(height: 20, width: 20),
                            ),
                            errorWidget: (context, url, error) => Container(
                              alignment: AlignmentDirectional.center,
                              height: 13.5.h,
                              width: 30.w,
                              child: const Icon(Icons.error,color: Colors.red,),
                            ),
                          )),
                    ),
                    fallback: (context) => Container(
                        height: 50.h,
                        alignment: AlignmentDirectional.center,
                        child: circularProIndicator(height: 40, width: 40)),),
              ],
            ),
          ),
        );
      },
    );
  }
}
