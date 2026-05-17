import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:provider/provider.dart';
import 'package:premises/application/app_data.dart';
import 'package:premises/features/user_management/provider.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _currentpasswordCtrl = TextEditingController();
  final TextEditingController _newpasswordCtrl = TextEditingController();
  final TextEditingController _confirmedpasswordCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late UserManagementProvider _userManagementProvider;

  final tooltipController = JustTheController();

  //Methods
  @override
  void initState() {
    super.initState();
    _userManagementProvider =
        Provider.of<UserManagementProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      tooltipController.showTooltip(immediately: true);
    });
  }

  //Widgets
  Widget _buildScreenWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Spacing().smallVertical,
            Expanded(
                child:
                    SingleChildScrollView(child: _buildChangePasswordForm())),
            _buildChangePasswordBtn(context)
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
        appbarWidget: CommonAppBar(
          title: AppStrings().change_password,
          subTitle: '',
          actions: [
            JustTheTooltip(
              shadow: const Shadow(blurRadius: 8.0),
              controller: tooltipController,
              backgroundColor: AppColors.derived_color_one,
              elevation: 4.0,
              showDuration: const Duration(seconds: 1),
              content: Wrap(
                children: [
                  Padding(
                    padding: MarginPadding().smallAll,
                    child: AppText.xsmallBrandPrimarySemiBold(
                        AppStrings().enter_valid_password),
                  )
                ],
              ),
              child: Container(
                height: 45,
                width: 45,
                padding: MarginPadding().xxxsmallAll,
                // decoration: BoxDecoration(
                //   // borderRadius: BorderRadius.all(
                //   //   Radius.circular(AppSizes().xxxsmall),
                //   // ),
                //   // border: Border.all(
                //   //   color: AppColors.color_primary,
                //   //   width: AppSizes().dropDownBorderWidth,
                //   // ),
                //   //color: AppColors.derived_color_one,
                // ),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      tooltipController.showTooltip();
                    },
                    child: AppIcon(
                      icon: AppIcons().ic_info,
                      type: IconAssetType.SVG_ICON,
                      iconWidth: 20.0,
                      iconHeight: 20.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        buildScreenColor: AppColors.white,
        screenWidget: _buildScreenWidget(context));
  }

  Widget _buildChangePasswordForm() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          Spacing().smallVertical,
          AppText.xsmallGreyG1Regular(
            AppStrings().enter_current_pwd,
            isAsteriskVisible: true,
          ),
          Spacing().xsmallVertical,
          CustomTextFormField(
            hinttext: AppStrings().enter_current_pwd,
            textInputType: TextInputType.text,
            obscureText: !context
                .watch<UserManagementProvider>()
                .isCurrentPasswordVisible!,
            onIconPressed: () {
              _userManagementProvider.setCurrentPasswordVisibility();
            },
            suffixIcon: !context
                    .watch<UserManagementProvider>()
                    .isCurrentPasswordVisible!
                ? Icons.visibility_off
                : Icons.visibility,
            suffixIconColor: AppColors.text_grey_g1,
            controller: _currentpasswordCtrl,
            validator: (value) {
              if (!Validation().isValid(value.toString())) {
                return AppStrings().enter_valid_current_pwd;
              }
              return null;
            },
          ),
          Spacing().smallVertical,
          AppText.xsmallGreyG1Regular(
            AppStrings().enter_new_pwd,
            isAsteriskVisible: true,
          ),
          Spacing().xsmallVertical,
          CustomTextFormField(
            hinttext: AppStrings().enter_new_pwd,
            textInputType: TextInputType.text,
            obscureText:
                !context.watch<UserManagementProvider>().isNewPasswordVisible!,
            controller: _newpasswordCtrl,
            onIconPressed: () {
              _userManagementProvider.setNewPasswordVisibility();
            },
            suffixIcon:
                !context.watch<UserManagementProvider>().isNewPasswordVisible!
                    ? Icons.visibility_off
                    : Icons.visibility,
            suffixIconColor: AppColors.text_grey_g1,
            validator: (value) {
              if (!Validation().isValid(value.toString())) {
                return AppStrings().enter_valid_new_password;
              } else if (!Validation().isValidPassword(value)) {
                return AppStrings().enter_valid_password;
              } else if (_newpasswordCtrl.text.trim().toString() ==
                  _currentpasswordCtrl.text.trim().toString()) {
                return AppStrings().newpass_currentpass_not_same;
              } else if (_newpasswordCtrl.text.toString() ==
                  AppData().userDetailsUiModel!.username) {
                return AppStrings().password_same_as_user_name;
              }
              return null;
            },
          ),
          Spacing().smallVertical,
          AppText.xsmallGreyG1Regular(
            AppStrings().confirm_new_pwd,
            isAsteriskVisible: true,
          ),
          Spacing().xsmallVertical,
          CustomTextFormField(
            hinttext: AppStrings().confirm_new_pwd,
            textInputType: TextInputType.text,
            obscureText: !context
                .watch<UserManagementProvider>()
                .isConfirmPasswordVisible!,
            onIconPressed: () {
              _userManagementProvider.setConfirmPasswordVisibility();
            },
            suffixIcon: !context
                    .watch<UserManagementProvider>()
                    .isConfirmPasswordVisible!
                ? Icons.visibility_off
                : Icons.visibility,
            controller: _confirmedpasswordCtrl,
            suffixIconColor: AppColors.text_grey_g1,
            validator: (value) {
              if (!Validation().isValid(value.toString())) {
                return AppStrings().confirm_valid_new_pwd;
              } else if (!Validation().isValidPassword(value)) {
                return AppStrings().enter_valid_password;
              } else if (_confirmedpasswordCtrl.text.trim().toString() !=
                  _newpasswordCtrl.text.trim().toString()) {
                return AppStrings().confirmpass_newpass_same;
              } else if (_currentpasswordCtrl.text.toString() ==
                  _confirmedpasswordCtrl.text.toString()) {
                return AppStrings().confirmpass_currentpass_not_same;
              } else if (_currentpasswordCtrl.text.toString() ==
                  AppData().userDetailsUiModel!.username) {
                return AppStrings().password_same_as_user_name;
              }
              return null;
            },
          ),
          Spacing().smallVertical,
        ],
      ),
    );
  }

  Widget _buildChangePasswordBtn(context) {
    return Padding(
        padding: MarginPadding().mediumBottom,
        child: AppButton(
          buttonName: AppStrings().changePasswordbtn,
          backgroundColor: AppColors.color_primary,
          onPressed: () {
            _changepassword(context);
          },
        ));
  }

  void _changepassword(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      _userManagementProvider.changePassword(
          currentpassword: _currentpasswordCtrl.text.toString().trim(),
          newpassword: _newpasswordCtrl.text.toString().trim(),
          confirmedpassword: _confirmedpasswordCtrl.text.toString().trim(),
          context: context);
    }
  }
}
