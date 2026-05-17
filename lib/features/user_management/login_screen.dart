import 'user_management.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:premises/app_config.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:premises/application/application.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/resources.dart';


class LoginScreen extends StatefulWidget {
  final String? appVersion;

  const LoginScreen({super.key, this.appVersion});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _userNameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  late UserManagementProvider _userManagementProvider;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      //Dev
      _userNameCtrl.text = "samadhan123";
      _passwordCtrl.text = ":j&vKA8P";
    }

    _userManagementProvider = Provider.of<UserManagementProvider>(
      context,
      listen: false,
    );
    _userManagementProvider.checkStoragePermission(context);
  }

  Widget _buildScreenWidget(BuildContext context) {
    return Stack(
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
                    _buildLoginForm(),
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
        Spacing().xxlargeVertical,
        AppText.xxxlargeBrandSecondaryBold(
          AppStrings().welcome,
          isCenter: true,
        ),
        Spacing().smallVertical,
        AppText.smallGreyG1Regular(
          AppStrings().login_to_continue,
          isCenter: true,
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
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
                return AppStrings().error_valid_user_id;
              }
              return null;
            },
          ),
          Spacing().smallVertical,
          AppText.xsmallGreyG1Regular(
            AppStrings().password,
            isAsteriskVisible: true,
          ),
          Spacing().xsmallVertical,
          CustomTextFormField(
            hinttext: AppStrings().hint_enter_password,
            obscureText: !context
                .watch<UserManagementProvider>()
                .isPasswordVisible!,
            onIconPressed: () {
              _userManagementProvider.setPasswordVisibility();
            },
            suffixIcon:
                !context.watch<UserManagementProvider>().isPasswordVisible!
                ? Icons.visibility_off
                : Icons.visibility,
            textInputType: TextInputType.text,
            controller: _passwordCtrl,
            suffixIconColor: AppColors.text_grey_g1,
            validator: (value) {
              if (!Validation().isValid(value.toString())) {
                return AppStrings().error_valid_password;
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
                  Navigator.of(context).pushNamed(
                    RouteName.forgotPasswordScreen,
                    arguments: LoginScreenArguments(
                      appVersion: widget.appVersion,
                    ),
                  );
                },
                child: AppText.xsmallGreyG1Regular(
                  AppStrings().forget_password,
                  isAsteriskVisible: false,
                ),
              ),
            ],
          ),
          Spacing().xlargeVertical,
          AppButton(
            buttonName: AppStrings().login.toUpperCase(),
            backgroundColor: AppColors.color_primary,
            onPressed: () {
              //  mixpanel.track('login_button_clicked', properties: {'username': _userNameCtrl.text.toString().trim()});
              _userLogin(context);
            },
          ),
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
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 1.0,
                    width: 100.0,
                    color: AppColors.text_grey_g1,
                  ),
                ),
                AppText.xsmallGreyG1Regular("OR"),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 1.0,
                    width: 100.0,
                    color: AppColors.text_grey_g1,
                  ),
                ),
              ],
            ),
          ),
          Spacing().smallVertical,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextButton(
                width: 200,
                buttonName: AppStrings().i_am_a_visitor,
                buttonTextColor: AppColors.color_primary,
                backgroundColor: Colors.white,
                onPressed: () {
                  // Navigator.of(context).pushNamed(
                  //   RouteName.visitorEmailOtpScreen,
                  // );
                  _userManagementProvider.getOTPVerifiedStatus(
                    context: context,
                  );
                },
              ),
              if (AppData().isFreemiumSupported ?? false) ...{
                const Spacer(),
                AnimatedGradientBorder(
                  borderSize: 2.5,
                  glowSize: 0,
                  gradientColors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    AppColors.color_primary,
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    padding: MarginPadding().xsmallAll,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: AppColors.white,
                    ),
                    child: InkWell(
                      onTap: () {
                        _userManagementProvider.isTermsAndCondtionsAgree =
                            false;
                        _userManagementProvider.isPrivacyAndPolicyAgree = false;
                        // Navigator.of(context).pushNamed(
                        //   RouteName.selfLoginScreen,
                        // );
                        MixpanelService().exploreAppButtonClickEvent();
                        _showTermsAndConditionDialog();
                      },
                      child: Text(
                        AppStrings().take_look.toUpperCase(),
                        style: TextStyle(
                          color: AppColors.color_primary,
                          fontSize: TextSize().small,
                          fontWeight: FontWeight.w600,
                          height: AppSizes().letterHeight,
                          fontFamily: FontFamily.fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
              },
            ],
          ),
          Spacing().largeVertical,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.xsmallGreyG1Regular(
                '${AppStrings().version}${widget.appVersion!} ${Environment.environmentName}',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.xxsmallGreyDarkRegular(AppStrings().created_with_care),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _progressBar(BuildContext context) {
    return AppProgressBar(
      isLoading: context.watch<UserManagementProvider>().isLoading,
    );
  }

  void _showTermsAndConditionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogCheckbox(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(RouteName.selfLoginScreen);
          },
          mixpanelService: MixpanelService(),
          userManagementProvider: Provider.of<UserManagementProvider>(
            context,
            listen: false,
          ),
          dialogButtonName: AppStrings().consent.toString().toUpperCase(),
          dialogTitle: AppStrings().explore_app,
          onPressedClosedIcon: () => {Navigator.of(context).pop()},
        );
      },
    );
  }

  void _userLogin(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    // Navigator.pushNamed(context, RouteName.verifyMobileNumberScreen);
    if (_formKey.currentState!.validate()) {
      _userManagementProvider.userLogin(
        userName: _userNameCtrl.text.toString().trim(),
        password: _passwordCtrl.text.toString().trim(),
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen.commonScreenWithNoAppbar(
      context: context,
      scaffoldKey: _scaffoldKey,
      //bottomWidget: _buildBottomDetails(),
      screenWidget: _buildScreenWidget(context),
    );
  }
}

class LoginScreenArguments {
  String? appVersion;

  LoginScreenArguments({this.appVersion});
}
