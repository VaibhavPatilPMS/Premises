import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/application/application.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:premises/features/user_management/provider.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _contactEmailCtrl = TextEditingController();
  late UserManagementProvider _userManagementProvider;
  final GlobalKey<FormState> _formKey = GlobalKey();

  //Methods
  @override
  void initState() {
    super.initState();
    _userManagementProvider =
        Provider.of<UserManagementProvider>(context, listen: false);
    _contactEmailCtrl.text = AppData().userDetailsUiModel!.email!;
    _userManagementProvider.contactEmailUpdate =
        AppData().userDetailsUiModel!.email!;
  }

  //Widgets
  Widget _buildScreenWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildUserProfile(context),
                    _buildUserInfo(context),
                    Padding(
                      padding: MarginPadding().largeLeftRight,
                      child: const HorizontalDivider(
                        dividerColor: AppColors.text_grey_g2,
                      ),
                    ),
                    _buildTextField()
                  ],
                ),
              ),
            ),
            _buildSaveBtn()
          ],
        ),
        _progressBar(context),
      ],
    );
  }

  Widget _progressBar(BuildContext context) {
    return AppProgressBar(
      isLoading: context.read<UserManagementProvider>().isLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen.commonScreenWithAppbar(
        context: context,
        scaffoldKey: _scaffoldKey,
        noDefaultPadding: true,
        appbarWidget: CommonAppBar(
            title: AppStrings().profile,
            subTitle: '',
            backgroundColor: AppColors.color_secondary,
            zeroElevation: true),
        screenWidget: _buildScreenWidget(context));
  }

  Widget _buildTextField() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: MarginPadding().largeAll,
        child: Column(
          children: [
            AppText.xsmallGreyG1Regular(
              AppStrings().contact_email_id,
              isAsteriskVisible: true,
            ),
            Spacing().xsmallVertical,
            CustomTextFormField(
              hinttext: AppStrings().contact_email_id,
              textInputType: TextInputType.text,
              controller: _contactEmailCtrl,
              onChanged: (value) {
                _userManagementProvider.onEmailChange(value);
              },
              validator: (value) {
                if (!Validation().isValid(value.toString())) {
                  return AppStrings().valid_contact_email_id;
                } else if (!Validation().isEmailValid(value)) {
                  return AppStrings().valid_contact_email_id;
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(context) {
    return Consumer<UserManagementProvider>(
      builder: (context, userManagementProvider, _) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            color: AppColors.color_secondary,
            borderRadius: BorderRadius.only(
              bottomLeft:
                  Radius.circular(AppSizes().drawerProfileCardRoundCorners),
              bottomRight:
                  Radius.circular(AppSizes().drawerProfileCardRoundCorners),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacing().smallVertical,
              Consumer<UserManagementProvider>(
                builder: (context, userManagementProvider, child) {
                  return Stack(
                    children: [
                      SizedBox(
                        height: ProfileSize().height,
                        width: ProfileSize().width,
                        child: userManagementProvider.userProfilePic!.isEmpty
                            ? ClipOval(
                                child: AppData()
                                            .userDetailsUiModel!
                                            .profilePic !=
                                        null
                                    ? CachedNetworkImage(
                                        imageUrl: AppData()
                                            .userDetailsUiModel!
                                            .profilePic
                                            .toString(),
                                        fit: BoxFit.fill,
                                        httpHeaders:
                                            CachedNetworkImageHeader.headers,
                                      )
                                    : AppIcon(
                                        icon: AppIcons().ic_user_default_image,
                                      ),
                              )
                            : ClipOval(
                                child: Image(
                                  image: randomImageUrl(userManagementProvider
                                      .userProfilePic!.first),
                                  fit: BoxFit.fill,
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: SizedBox(
                            child: AppIcon(
                          icon: AppIcons().ic_solid_camera,
                          iconHeight: IconSize().xmedium,
                          iconWidth: IconSize().xmedium,
                          onClick: () async {
                            CustomCameraAndImagePickerArgs args =
                                CustomCameraAndImagePickerArgs(
                              imageCount: 1,
                              files: _userManagementProvider.userProfilePic!,
                            );
                            dynamic result = await Navigator.pushNamed(context,
                                RouteName.newCustomCameraAndImagePicker,
                                arguments: args);
                            if (result != null) {
                              List<File>? userProfilePic = result as List<File>;
                              _userManagementProvider.updateUserProfile(
                                  contactEmail: null,
                                  context: context,
                                  userProfilePic: userProfilePic.first);
                            }
                          },
                        )),
                      )
                    ],
                  );
                },
              ),
              Spacing().smallVertical,
              AppText.smallWhiteSemiBold(
                '${AppData().userDetailsUiModel!.firstName.toString().toBeginningOfSentence()} ${AppData().userDetailsUiModel!.lastName.toString().toBeginningOfSentence()}',
                isCenter: true,
              ),
              Spacing().xxsmallVertical,
              AppText.xsmallWhiteRegular(
                AppData()
                    .userDetailsUiModel!
                    .designation
                    .toString()
                    .toBeginningOfSentence(),
                isCenter: true,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserInfo(context) {
    return Padding(
      padding: MarginPadding().xlargeAll,
      child: Column(
        children: [
          _buildLable(
              label: AppStrings().lb_current_project,
              content: AppData().userCurrentSelectedProject != null
                  ? AppData().userCurrentSelectedProject!.projectName.toString()
                  : AppStrings().dash),
          Spacing().xsmallVertical,
          // _buildLable(
          //     label: AppStrings().lb_assigned_project,
          //     content: AppData().userCurrentSelectedProject != null
          //         ? AppData().userDetailsUiModel!.userAssignedProjects!
          //         : AppStrings().dash),
          _buildLable(
              label: AppStrings().lb_assigned_project,
              content: AppData().userAssignedProjectsForProfile != null
                  ? AppData().userAssignedProjectsForProfile!
                  : AppStrings().dash),
          Spacing().xsmallVertical,
          _buildLable(
              label: AppStrings().lb_username,
              content: AppData().userDetailsUiModel!.username.toString()),
          Spacing().xsmallVertical,
          _buildLable(
              label: AppStrings().lb_userrole,
              content: AppData().userCurrentSelectedProject != null
                  ? AppData()
                      .userCurrentSelectedProject!
                      .roleName
                      .toString()
                      .toBeginningOfSentence()
                  : AppStrings().dash),
          Spacing().xsmallVertical,
          _buildLable(
              label: AppStrings().lb_contact_number,
              content: AppData().userDetailsUiModel!.phoneNumber.toString()),
        ],
      ),
    );
  }

  Widget _buildLable({required String label, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.xsmallGreyG1Regular(label),
        Spacing().xxsmallVertical,
        AppText.smallGreyMedium(content),
      ],
    );
  }

  Widget _buildSaveBtn() {
    return Consumer<UserManagementProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: MarginPadding().largeAll,
          child: AppButton(
              buttonName: AppStrings().saveBtn,
              onPressed: context
                          .watch<UserManagementProvider>()
                          .isNetworkConnected &&
                      (value.contactEmailUpdate.toString().trim() !=
                          AppData().userDetailsUiModel!.email) &&
                      (value.contactEmailUpdate.toString().trim().isNotEmpty) &&
                      (Validation().isEmailValid(value.contactEmailUpdate!))
                  ? () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (_formKey.currentState!.validate()) {
                        if (_contactEmailCtrl.text.toString().trim() !=
                            AppData().userDetailsUiModel!.email) {
                          value.updateUserProfile(
                            context: context,
                            contactEmail:
                                _contactEmailCtrl.text.toString().trim(),
                            userProfilePic: null,
                          );
                        }
                      }
                    }
                  : null,
              backgroundColor: AppColors.color_primary),
        );
      },
    );
  }
}
