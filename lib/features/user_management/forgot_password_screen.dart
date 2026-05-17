import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/application.dart';
import '../../common/widgets/widgets.dart';
import '../../common/resources/resources.dart';
import '../../common/utils/utils.dart';
import 'user_management.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final String? appVersion;

  const ForgetPasswordScreen({super.key, this.appVersion});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _userNameCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late UserManagementProvider _userManagementProvider;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      //emailController.text='safetyofficer@gmail.com';
      //emailController.text='engamit@gmail.com';
      _userNameCtrl.text = 'engineer@gmail.com';
      //_userNameCtrl.text='manager@gmail.com';
    }
    _userManagementProvider =
        Provider.of<UserManagementProvider>(context, listen: false);
  }

  Widget _buildScreenWidget(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_userManagementProvider.isPasswordVisible!) {
          _userManagementProvider.setPasswordVisibility();
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pop();
        }
      },
      // onWillPop: () async {
      //   if (_userManagementProvider.isPasswordVisible!) {
      //     _userManagementProvider.setPasswordVisibility();
      //   }
      //   return true;
      // },
      child: Stack(
        children: <Widget>[
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Spacing().xxlargeVertical,
                      _buildHeader(),
                      Spacing().xxlargeVertical,
                      _buildForgetPasswordForm(),
                      Spacing().xxxxxlargeVertical,
                      AppButton(
                          buttonName: AppStrings()
                              .email_temporary_password
                              .toUpperCase(),
                          backgroundColor: AppColors.color_primary,
                          onPressed: context
                                  .watch<UserManagementProvider>()
                                  .isNetworkConnected
                              ? () async {
                                  _forgetPassword(context);
                                }
                              : null),
                      Spacing().xxlargeVertical,
                      _buildBottomDetails(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _progressBar(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacing().xxlargeVertical,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppIcon(
              icon: AppIcons().ic_app_logo,
              type: IconAssetType.SVG_ICON,
              iconHeight: IconSize().xxxlarge,
              iconWidth: IconSize().xxxlarge,
            ),
            Spacing().smallHorizontal,
            AppText.xxxlargeGreySemiBold(AppStrings().splash_title),
          ],
        ),
        Spacing().xxxlargeVertical,
        AppText.smallGreyG1Regular(
          AppStrings().reset_password,
          isCenter: true,
        ),
      ],
    );
  }

  Widget _buildForgetPasswordForm() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          AppText.xsmallGreyG1Regular(
            AppStrings().user_id,
            isAsteriskVisible: true,
          ),
          Spacing().xsmallVertical,
          CustomTextFormField(
            hinttext: AppStrings().enter_user_name,
            textInputType: TextInputType.text,
            controller: _userNameCtrl,
            validator: (value) {
              if (!Validation().isValid(value.toString())) {
                return AppStrings().error_valid_user_name;
              }
              return null;
            },
          ),
          Spacing().smallVertical,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  if (_userManagementProvider.isPasswordVisible!) {
                    _userManagementProvider.setPasswordVisibility();
                  }
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteName.userLoginScreen, (route) => false,
                      arguments:
                          LoginScreenArguments(appVersion: widget.appVersion));
                },
                child: AppText.xsmallGreyG1Regular(
                  AppStrings().back_to_login,
                  isAsteriskVisible: false,
                ),
              ),
            ],
          ),
          Spacing().xlargeVertical,
        ],
      ),
    );
  }

  Widget _buildBottomDetails() {
    return Padding(
      padding: MarginPadding().mediumBottom,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.xsmallGreyG1Regular(
                AppStrings().version + widget.appVersion!,
              ),
              Spacing().xxxsmallHorizontal,
              CustomVerticalDivider(height: AppSizes().xsmall),
              Spacing().xxxsmallHorizontal,
              InkWell(
                onTap: () {
                  LaunchURL.launchBrowser(AppStrings().support_url);
                },
                child: AppText.xsmallGreyG1Regular(
                  AppStrings().support,
                  textDecoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          Spacing().xxlargeVertical,
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            AppText.xxsmallGreyDarkRegular(
              AppStrings().created_with_care,
            ),
            Spacing().xxsmallHorizontal,
            InkWell(
              onTap: () {
                LaunchURL.launchBrowser(AppStrings().safety_app_url);
              },
              child: AppText.xxsmallSemiBold(
                AppStrings().created_with_care_by_safety_app,
                textDecoration: TextDecoration.underline,
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _progressBar(BuildContext context) {
    return AppProgressBar(
      isLoading: context.watch<UserManagementProvider>().isLoading,
    );
  }

  void _forgetPassword(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      _userManagementProvider.forgetPassword(
          context: context,
          userName: _userNameCtrl.text.toString().trim(),
          appVersion: widget.appVersion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen.commonScreenWithNoAppbar(
        context: context,
        scaffoldKey: _scaffoldKey,
        //bottomWidget: _buildBottomDetails(),
        screenWidget: _buildScreenWidget(context));
  }
}
