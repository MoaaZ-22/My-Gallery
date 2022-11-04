import 'package:my_gallery/models/images_model.dart';

abstract class AppStates {}

class InitialAppState extends AppStates {}

class GetGalleryImagesLoadingState extends AppStates{}

class GetGalleryImagesSuccessState extends AppStates{

  final ImagesModel? imagesModel;

  GetGalleryImagesSuccessState(this.imagesModel);
}

class GetGalleryImagesErrorState extends AppStates{

  final String? error;

  GetGalleryImagesErrorState(this.error);
}

class ProfileImagePickedSuccessState extends AppStates{}

class ProfileImagePickedErrorState extends AppStates{}

class GalleryImagePickedSuccessState extends AppStates{}

class GalleryImagePickedErrorState extends AppStates{}




