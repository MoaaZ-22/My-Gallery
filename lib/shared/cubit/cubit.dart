// ignore_for_file: avoid_print, use_full_hex_values_for_flutter_colors
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

  io.File? galleryImage;
  io.File? coverImage;
  var picker = ImagePicker();
  
  void getGalleryImages()
  {
    emit(GetGalleryImagesLoadingState());
    
    DioHelper.getData(url: GET_GALLERY_IMAGES, accessToken: token)
    .then((value)
    {
      imagesModel = ImagesModel.fromJson(value.data);
      print(imagesModel!.message!);
      print(imagesModel!.data!.images!);
      emit(GetGalleryImagesSuccessState(imagesModel));
    }
    )
    .catchError((error)
    {
      print('${error.toString()} ----------------------------------------------------------- 1');
      emit(GetGalleryImagesErrorState(error.toString()));
    }
    );
  }

  Future<void> pickProfileImage() async {
    final XFile? pickedProfileFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedProfileFile != null) {
      galleryImage = io.File(pickedProfileFile.path);

      emit(GalleryImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(GalleryImagePickedErrorState());
    }
  }

}

