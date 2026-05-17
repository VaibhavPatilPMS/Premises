import 'package:premises/main_imports.dart';

import '../resources/resources.dart';
import 'widgets.dart';

class SuccessfulScreen extends StatefulWidget {
  final SuccessfullScreenArgs args;

  const SuccessfulScreen({super.key, required this.args});

  @override
  State<SuccessfulScreen> createState() => _SuccessfulScreenState();
}

class _SuccessfulScreenState extends State<SuccessfulScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List formTemplateModuleList = [
    AppStrings().toolbox_training_screen,
    AppStrings().toolbox_training,
    AppStrings().induction_training,
  ];

  @override
  Widget build(BuildContext context) {
    return CommonScreen.commonScreenWithNoAppbar(
        context: context,
        scaffoldKey: _scaffoldKey,
        buildScreenColor: AppColors.white,
        screenWidget: _buildScreenWidget());
  }

  Widget _buildScreenWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages().bg_successfull,
              fit: BoxFit.fill,
              width: 180,
              height: 180,
            ),
            AppText.xlargeBrandSecondaryBold(
              widget.args.title,
              isCenter: true,
            ),
          ],
        )),
        Padding(
          padding: MarginPadding().mediumTopBottom,
          child: AppButton(
              buttonName: AppStrings().done.toUpperCase(),
              backgroundColor: AppColors.color_primary,
              onPressed: widget.args.onPressed != null
                  ? widget.args.onPressed as void Function()?
                  : () async {
                      // CheckListProvider checkListProvider =
                      //     Provider.of<CheckListProvider>(context,
                      //         listen: false);
                      // if (widget.args.routeName != RouteName.checkListScreen &&
                      //     formTemplateModuleList
                      //         .contains(checkListProvider.moduleName)) {
                      //   await checkListProvider
                      //       .gotoChecklistFormTemplate(context);
                      // }
                      // if (widget.args.isFormTemplate) {
                      //   Navigator.pop(context);
                      // } else {
                        Navigator.of(context).popAndPushNamed(
                          widget.args.routeName!,
                          arguments: widget.args.screenArguments,
                        );
                      // }
                    }),
        ),
      ],
    );
  }
}

class SuccessfullScreenArgs {
  late String title;
  final String?
      routeName; //send routeName as null if don't want to navigate to another screen
  final Object? screenArguments;
  final Function? onPressed;
  final bool isFormTemplate;

  SuccessfullScreenArgs(
      {required this.title,
      this.routeName,
      this.screenArguments,
      required this.onPressed,
      this.isFormTemplate = false});
}
