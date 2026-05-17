import 'package:cached_network_image/cached_network_image.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/main_imports.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/resources/resources.dart';

class CustomDashboardAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isDialogVisibled;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  CustomDashboardAppBar(
      {super.key, required this.isDialogVisibled, this.scaffoldKey});

  ProjectDetailsUiModel? selectedProject;
  late DashboardProvider _dashboardProvider;

  @override
  Widget build(BuildContext context) {
    _dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);

    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      toolbarHeight: AppSizes().toolBarHeight,
      elevation: AppSizes().dashboardToolbarElevation,
      shadowColor: AppColors.toolbarShadowColor,
      backgroundColor: AppColors.white,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: MarginPadding().xmedium),
          child: AppIcon(
            icon: AppIcons().ic_menu,
            type: IconAssetType.SVG_ICON,
            onClick: !context.watch<DashboardProvider>().isLoading!
                ? () {
                    scaffoldKey!.currentState!.openEndDrawer();
                  }
                : null,
            iconHeight: IconSize().large,
            iconWidth: IconSize().large,
          ),
        )
      ],
      titleSpacing: MarginPadding().xmedium,
      title:
          Consumer<DashboardProvider>(builder: (context, dashboardProvider, _) {
        selectedProject = dashboardProvider.userSelectedProject;
        return dashboardProvider.projectUiModel!.projects != null &&
                dashboardProvider.projectUiModel!.projects!.isNotEmpty
            ? Row(
                children: [
                  InkWell(
                    onTap: () async {
                      if (!isDialogVisibled) {
                        if (dashboardProvider.projectUiModel!.projects !=
                                null &&
                            dashboardProvider
                                .projectUiModel!.projects!.isNotEmpty) {
                          await showTopModalSheet<int?>(
                            context,
                            _buildRadioButtonList(context),
                          );
                        }
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              AppSizes().defaultCornerRadius),
                          child: selectedProject!.projectImageToDisplay != null
                              ? CachedNetworkImage(
                                  imageUrl:
                                      selectedProject!.projectImageToDisplay!,
                                  httpHeaders: CachedNetworkImageHeader.headers,
                                  fit: BoxFit.fill,
                                  height: 48,
                                  width: 48,
                                )
                              : Image.asset(
                                  AppImages().default_project_image,
                                  height: 48,
                                  width: 48,
                                  fit: BoxFit.fill,
                                ),
                        ),
                        Spacing().smallHorizontal,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: AppText.xxxlargeBrandSecondaryBold(
                                      dashboardProvider.projectUiModel!
                                                      .projects !=
                                                  null &&
                                              dashboardProvider.projectUiModel!
                                                  .projects!.isNotEmpty
                                          ? dashboardProvider
                                              .userSelectedProject!.projectName
                                              .toString()
                                              .toBeginningOfSentence()
                                          : AppStrings().no_projects_found,
                                      textOverflow: TextOverflow.ellipsis),
                                ),
                                Spacing().smallHorizontal,
                                AppIcon(
                                  icon: isDialogVisibled
                                      ? AppIcons().ic_arrow_up_fill
                                      : AppIcons().ic_arrow_down_fill,
                                  type: IconAssetType.SVG_ICON,
                                  iconHeight: IconSize().xsmall,
                                  iconWidth: IconSize().xsmall,
                                ),
                              ],
                            ),
                            AppData().userDetailsUiModel != null
                                ? SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    height: 15,
                                    child: AppText.xsmallGreyG1Medium(
                                      'Hi, ${'${AppData().userDetailsUiModel!.firstName.toString().toBeginningOfSentence()} ${AppData().userDetailsUiModel!.lastName.toString().toBeginningOfSentence()}'}',
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              )
            : Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppSizes().defaultCornerRadius),
                    child: AppIcon(
                      icon: AppIcons().ic_app_logo,
                      type: IconAssetType.SVG_ICON,
                      iconHeight: IconSize().xxxlarge,
                      iconWidth: IconSize().xxxlarge,
                    ),
                  ),
                  Spacing().smallHorizontal,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.xxxlargeBrandSecondaryBold(
                          AppStrings().app_title),
                      Spacing().xxxsmallVertical,
                      AppData().userDetailsUiModel != null
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.60,
                              height: 15,
                              child: AppText.xsmallGreyG1Medium(
                                  'Hi, ${'${AppData().userDetailsUiModel!.firstName.toString().toBeginningOfSentence()} ${AppData().userDetailsUiModel!.lastName.toString().toBeginningOfSentence()}'}'),
                            )
                          : Container(),
                    ],
                  ),
                ],
              );
      }),
    );
  }

  void setSelectedRadioTile(
      {required int val,
      required int index,
      required DashboardProvider dashboardProvider,
      required BuildContext context}) async {
    bool? syncStatus = await dashboardProvider.checkProjectIsSyncOrNot(
        dashboardProvider.projectUiModel!.projects![index]);
    if (!syncStatus!) {
      _showProjectNotSyncDialog(context);
    } else {
      dashboardProvider.selectedProjectIndex = val;
      for (var element in dashboardProvider.projectUiModel!.projects!) {
        element.isCheck = false;
      }
      dashboardProvider.projectUiModel!.projects![index].isCheck = true;
      selectedProject = dashboardProvider.projectUiModel!.projects![index];
      selectedProject!.isCheck = true;
      _dashboardProvider.setSelectedProjectDetails(
          selectedProject, val, scaffoldKey?.currentContext);
    }
  }

  Widget _buildRadioButtonList(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, dashboardProvider, _) {
        return dashboardProvider.projectUiModel!.projects!.isNotEmpty &&
                dashboardProvider.projectUiModel!.projects!.length > 10
            ? Container(
                height: (MediaQuery.of(context).size.height * 0.80),
                decoration: _getDecorationLargeList(),
                child: _getList(dashboardProvider: dashboardProvider),
              )
            : SingleChildScrollView(
                child: Container(
                  decoration: _getDecorationAutoWrap(),
                  child: _getList(dashboardProvider: dashboardProvider),
                ),
              );
      },
    );
  }

  Widget _getList({required DashboardProvider dashboardProvider}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomDashboardAppBar(isDialogVisibled: true, scaffoldKey: scaffoldKey),
        Padding(
          padding: EdgeInsets.only(
              left: MarginPadding().xmedium, top: MarginPadding().xmedium),
          child: AppText.smallBrandSecondaryBold(AppStrings().switch_project),
        ),
        Spacing().xxsmallVertical,
        dashboardProvider.projectUiModel!.projects!.isNotEmpty &&
                dashboardProvider.projectUiModel!.projects!.length > 10
            ? Expanded(
                child: _getScrollBar(dashboardProvider: dashboardProvider),
              )
            : _getScrollBar(dashboardProvider: dashboardProvider),
      ],
    );
  }

  Widget _getScrollBar({required DashboardProvider dashboardProvider}) {
    return Scrollbar(
      interactive: true,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: dashboardProvider.projectUiModel!.projects!.length,
          padding: MarginPadding().largeBottom,
          itemBuilder: (context, index) => Padding(
                padding: MarginPadding().xsmallBottom,
                child: RadioButtonListTileWidget(
                  onChanged: (val) {
                    if (dashboardProvider.projectUiModel!.projects != null &&
                        dashboardProvider
                            .projectUiModel!.projects!.isNotEmpty) {
                      Navigator.of(context).pop(val);
                      setSelectedRadioTile(
                          val: val as int,
                          index: index,
                          dashboardProvider: dashboardProvider,
                          context: context);
                    }
                  },
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.smallGreyMedium(
                            dashboardProvider
                                .projectUiModel!.projects![index].projectName!
                                .toBeginningOfSentence(),
                            textDecoration: dashboardProvider
                                    .projectUiModel!.projects![index].isActive!
                                ? TextDecoration.none
                                : TextDecoration.lineThrough),
                        Spacing().xsmallVertical,
                        if (!dashboardProvider
                            .projectUiModel!.projects![index].isActive!)
                          AppText.xxsmallGreyDarkRegular(
                              AppStrings().deacitivate_project),
                      ]),
                  isCheck: dashboardProvider
                      .projectUiModel!.projects![index].isCheck!,
                  index: index,
                  selectedIndex: dashboardProvider.selectedProjectIndex,
                ),
              )),
    );
  }

  void _showProjectNotSyncDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CommonAlertDialog(
          onPressed: () {
            Navigator.of(context).pop();
          },
          dialogButtonName: AppStrings().close.toUpperCase(),
          dialogMessage: AppStrings().project_data_not_sync,
          dialogTitle: AppStrings().project_not_sync_title,
        );
      },
    );
  }

  _getDecorationAutoWrap() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft:
                Radius.circular(AppSizes().dashboardTopBottomSheetRoundCorners),
            bottomRight: Radius.circular(
                AppSizes().dashboardTopBottomSheetRoundCorners)));
  }

  _getDecorationLargeList() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppSizes().dialogRoundCorners),
            bottomRight: Radius.circular(AppSizes().dialogRoundCorners)));
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSizes().toolBarHeight);
}

class CustomDashboardPlaceHolder extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isDialogVisibled;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const CustomDashboardPlaceHolder(
      {super.key, required this.isDialogVisibled, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes().toolBarHeight,
    );
  }

  // TODO: implement preferredSize
  @override
  Size get preferredSize => Size.fromHeight(AppSizes().toolBarHeight);
}
