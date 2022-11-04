// ignore_for_file: avoid_print, use_full_hex_values_for_flutter_colors
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/models/images_model.dart';
import 'package:my_gallery/shared/components/const.dart';
import 'package:my_gallery/shared/cubit/states.dart';
import 'package:my_gallery/shared/network/remote/dio_helper.dart';
import '../network/end_points.dart';
import 'dart:io' as io;


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  ImagesModel? imagesModel;

  var picker = ImagePicker();
  
  void getGalleryImages()
  {
    emit(GetGalleryImagesLoadingState());
    
    DioHelper.getData(url: 'my-gallery', accessToken: token)
    .then((value)
    {
      print(token);
      imagesModel = ImagesModel.fromJson(value.data);
      print(imagesModel!.message!);
      print(imagesModel!.data!.images![0]);
      emit(GetGalleryImagesSuccessState(imagesModel));
    }
    )
    .catchError((error)
    {
      print('${error.toString()} ------------------------------------ 1');
      emit(GetGalleryImagesErrorState(error.toString()));
    }
    );
  }

  Future<void> pickGalleryImage() async {
    final XFile? pickedProfileFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedProfileFile != null) {
      pickedImage = io.File(pickedProfileFile.path);
      uploadImage(pickedFile: pickedImage);
      print('$pickedImage ---------------------------------------- 2');
      emit(GalleryImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(GalleryImagePickedErrorState());
    }
  }

  Future<void> pickCameraImage() async {
    final XFile? pickedProfileFile =
    await picker.pickImage(source: ImageSource.camera);

    if (pickedProfileFile != null) {
      pickedImage = io.File(pickedProfileFile.path);
      uploadImage(pickedFile: pickedImage);
      print('$pickedImage ---------------------------------------- 2');
      emit(CameraImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(CameraImagePickedErrorState());
    }
  }


  void uploadImage({io.File? pickedFile}) {
    print("object");
    DioHelper.postImage(
        url: UPLOAD,
        token: token,
        data: FormData.fromMap(
            {"img": MultipartFile.fromFileSync(pickedFile!.path)}))
        .then((value) {
      emit(UploadGalleryImageSuccessState());
      getGalleryImages();
    }).catchError((error) {
      if (error is DioError) {
        print(error.response);
      }
      emit(UploadGalleryImageErrorState());
    });
  }

}

