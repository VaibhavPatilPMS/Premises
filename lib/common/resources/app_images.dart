import 'resources.dart';

class AppImages {
  static final AppImages _image = AppImages._internal();

  AppImages._internal();

  factory AppImages() => _image;

  image(key) => "assets/images/$key";

  //App Customizations
  get bg_splash => AppCustomizationImages().bg_splash;

  //App Images
  get bg_successfull => image("successfull_gif.gif");

  get default_profile_image => image("default_profile_image.png");

  get default_project_image => image("building.png");

  get default_VAST_Logo => image("VAST_Logo.png");

  get fullLengthAvatar => image("full_length_avatar.png");

  get placeholder_profile_image_square =>
      image("placeholder_profile_picture.png");
}
