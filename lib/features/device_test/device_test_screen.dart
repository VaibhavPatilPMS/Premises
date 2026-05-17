import 'device_test.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/widgets/widgets.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/application/application.dart';
import 'package:premises/common/base/base_state_class.dart';


import '../../common/resources/resources.dart';
import 'package:connectivity_plus_platform_interface/src/enums.dart';


class DeviceTestScreenPage extends StatefulWidget {
  const DeviceTestScreenPage({super.key});

  @override
  State<DeviceTestScreenPage> createState() => _DeviceTestScreenState();
}

class _DeviceTestScreenState extends BaseStateClass<DeviceTestScreenPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late DeviceTestProvider _deviceHealthCheckProvider;
  List<ConnectivityResult>? connectivityResult = [ConnectivityResult.none];
  String? connectionType;
  int megaByte = 1024 * 1024 * 1024;

  //final internetSpeedTest = FlutterInternetSpeedTest()..enableLog();

  //Methods
  @override
  void initState() {
    _deviceHealthCheckProvider =
        Provider.of<DeviceTestProvider>(context, listen: false);
    _deviceHealthCheckProvider.isLoading = true;
    _deviceHealthCheckProvider.checkAppPermissions(context);
    _deviceHealthCheckProvider.initPlatformState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _deviceHealthCheckProvider.checkLocationPermission();
    });
    super.initState();
  }

  //Widgets
  Widget _buildScreenWidget(BuildContext context) {
    return Consumer<DeviceTestProvider>(
        builder: (context, snapshot, DeviceHealthCheckScreenState) {
      return Stack(
        children: <Widget>[
          Column(children: [
            Spacing().mediumVertical,
            AppText.smallGreyRegular(
                'Please wait while we inspect your device. This will bring you the device parameters.',
                isCenter: true),
            Spacing().xsmallVertical,
            AppText.xsmallGreyMedium(
                AppData().lastCheckupOn != null
                    ? 'Last Check-up on: ${AppData().lastCheckupOn}'
                    : '',
                isCenter: true),
            const HorizontalDivider(),
            _buildLocationDetails(context),
            const HorizontalDivider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.xsmallGreyG1Regular('Installed App Version'),
                        AppText.xsmallGreyMedium(
                            snapshot.deviceData['App Version'])
                      ],
                    ),
                    const HorizontalDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.xsmallGreyG1Regular('Brand'),
                        AppText.xsmallGreyMedium(snapshot.deviceData['Brand'])
                      ],
                    ),
                    Spacing().xsmallVertical,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.xsmallGreyG1Regular('Device'),
                        AppText.xsmallGreyMedium(snapshot.deviceData['Device'])
                      ],
                    ),
                    Spacing().xsmallVertical,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.xsmallGreyG1Regular('Manufacturer'),
                        AppText.xsmallGreyMedium(
                            snapshot.deviceData['Manufacturer'])
                      ],
                    ),
                    Spacing().xsmallVertical,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.xsmallGreyG1Regular('Model'),
                        AppText.xsmallGreyMedium(snapshot.deviceData['Model'])
                      ],
                    ),
                    Spacing().xsmallVertical,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.xsmallGreyG1Regular('Android OS Version'),
                        AppText.xsmallGreyMedium(
                            snapshot.deviceData['Android OS Version'])
                      ],
                    ),
                    const HorizontalDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.xsmallGreyG1Regular('Connection Type'),
                        AppText.xsmallGreyMedium(
                          connectionType,
                          textOverflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    const HorizontalDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.xsmallGreyG1Regular('Total Storage Space'),
                        AppText.xsmallGreyMedium(
                            '${snapshot.deviceData['Total Storage Space in GB']} GB')
                      ],
                    ),
                    Spacing().xsmallVertical,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.xsmallGreyG1Regular('Total Free Space'),
                        (snapshot.deviceData['Total Free Space in GB'] !=
                                    null &&
                                snapshot.deviceData['Total Free Space in GB'] <=
                                    1)
                            ? AppText.idCardValidInvalidText(
                                '${snapshot.deviceData['Total Free Space in GB']} GB',
                                color: false,
                              )
                            : AppText.xsmallGreyMedium(
                                '${snapshot.deviceData['Total Free Space in GB']} GB')
                      ],
                    ),
                    if (snapshot.deviceData['Total Free Space in GB'] != null &&
                        snapshot.deviceData['Total Free Space in GB'] <= 1)
                      AppText.xsmallCustomSemiBold(
                          '(Memory is Not Enough, please clear)',
                          color: AppColors.app_color_red),
                    Spacing().xsmallVertical,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.xsmallGreyG1Regular('Total Used Space'),
                        AppText.xsmallGreyMedium(
                            '${snapshot.deviceData['Total Used Space in GB']} GB')
                      ],
                    ),
                    Spacing().xsmallVertical,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.xsmallGreyG1Regular('Total physical memory'),
                        AppText.xsmallGreyMedium(
                            '${snapshot.deviceData['Total physical memory in GB']} GB')
                      ],
                    ),
                    Spacing().xsmallVertical,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.xsmallGreyG1Regular('Free physical memory'),
                        (snapshot.deviceData['Free physical memory in GB'] !=
                                    null &&
                                snapshot.deviceData[
                                        'Free physical memory in GB'] <=
                                    0.5)
                            ? AppText.idCardValidInvalidText(
                                '${snapshot.deviceData['Free physical memory in GB']} GB',
                                color: false,
                              )
                            : AppText.xsmallGreyMedium(
                                '${snapshot.deviceData['Free physical memory in GB']} GB')
                      ],
                    ),
                    if (snapshot.deviceData['Free physical memory in GB'] !=
                            null &&
                        snapshot.deviceData['Free physical memory in GB'] <=
                            0.5)
                      AppText.xsmallCustomSemiBold(
                          '(Memory is Not Enough, please clear)',
                          color: AppColors.app_color_red),
                    const HorizontalDivider(),
                    _permissionStatus(context),
                    const HorizontalDivider(),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  snapshot.status,
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                Spacing().xsmallVertical,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppText.xsmallGreyMedium(
                          'Download Speed',
                        ),
                        if (snapshot.downloadSpeed > 0) ...{
                          Text(
                            'Download Speed: ${snapshot.downloadSpeed.toStringAsFixed(2)} Mbps',
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        }
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppText.xsmallGreyMedium(
                          'Upload Speed',
                        ),
                        if (snapshot.uploadSpeed > 0) ...{
                          Text(
                            'Upload Speed: ${snapshot.uploadSpeed.toStringAsFixed(2)} Mbps',
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        }
                      ],
                    ),
                  ],
                ),
                if (!snapshot.isTestingSpeed) ...{
                  Spacing().xsmallVertical,
                  AppBorderedButton(
                      width: 150,
                      buttonName: AppStrings().start_testing,
                      onPressed: () async {
                        _deviceHealthCheckProvider.resetDownloadTestData();
                        context.read<DeviceTestProvider>().runSpeedTest();
                      }),
                  Spacing().largeVertical,
                } else ...{
                  const CircularProgressIndicator(
                      color: AppColors.color_primary),
                  Spacing().xsmallVertical,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton.icon(
                      onPressed: () =>
                          _deviceHealthCheckProvider.resetDownloadTestData(),
                      icon: const Icon(Icons.cancel_rounded,
                          color: AppColors.color_primary),
                      label: const Text('Cancel',
                          style: TextStyle(color: AppColors.color_primary)),
                    ),
                  )
                },
              ],
            ),
          ]),
          _progressBar(context),
        ],
      );
    });
  }

  Widget _buildLocationDetails(BuildContext? context) {
    return Consumer<DeviceTestProvider>(
      builder: (context, value, child) {
        return value.userLocationDetails != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.xsmallGreyG1Regular(
                    AppStrings().dateAndLocationOfSubmission,
                  ),
                  Spacing().xsmallVertical,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppIcon(
                        iconHeight: 18.0,
                        iconWidth: 18.0,
                        icon: AppIcons().ic_date_time,
                      ),
                      Spacing().xxsmallHorizontal,
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: AppText.xsmallGreyMedium(DateTimeUtil()
                            .getDateWithMonthYearAndTimeWithAMPM(
                                DateTime.now().toString())),
                      ),
                    ],
                  ),
                  Spacing().xsmallVertical,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppIcon(
                        iconHeight: 18.0,
                        iconWidth: 18.0,
                        icon: AppIcons().ic_location,
                      ),
                      Spacing().xxsmallHorizontal,
                      value.userLocationDetails != null
                          ? Flexible(
                              fit: FlexFit.loose,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (value.userLocationDetails!.latitude !=
                                              null &&
                                          value.userLocationDetails!
                                                  .longitude !=
                                              null &&
                                          value.userLocationDetails!.altitude !=
                                              null)
                                      ? AppText.xsmallGreyMedium(
                                          'Lat: ${value.userLocationDetails!.latitude.toString()}, '
                                          'Long: ${value.userLocationDetails!.longitude.toString()}, '
                                          'Altitude: ${value.userLocationDetails!.altitude!.toStringAsFixed(2)}m')
                                      : AppText.xsmallRedMedium(AppStrings()
                                          .device_not_able_to_fetch_location),
                                  Spacing().xsmallVertical,
                                  value.userLocationDetails!.userAddress != null
                                      ? AppText.xsmallGreyMedium(value
                                          .userLocationDetails!.userAddress
                                          .toString()
                                          .toBeginningOfSentence())
                                      : AppText.xsmallRedMedium(
                                          AppStrings().error_location),
                                ],
                              ))
                          : AppText.xsmallRedMedium(
                              AppStrings().device_not_able_to_fetch_location),
                    ],
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.xsmallGreyG1Regular(
                    AppStrings().dateAndLocationOfSubmission,
                  ),
                  Spacing().xsmallVertical,
                  AppText.xsmallGreyMedium(
                      AppStrings().device_not_able_to_fetch_location)
                ],
              );
      },
    );
  }

  Widget _permissionStatus(BuildContext? context) {
    return Consumer<DeviceTestProvider>(
      builder: (context, value, child) {
        return value.permissionStatusModel != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.xsmallGreyG1Regular(
                    AppStrings().permissionStatus,
                  ),
                  Spacing().xsmallVertical,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.xsmallGreyG1Regular('Location'),
                      AppText.xsmallGreyMedium(_getPermissionValue(
                          value.permissionStatusModel?.isLocation)),
                    ],
                  ),
                  Spacing().xsmallVertical,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.xsmallGreyG1Regular('Location Service'),
                      AppText.xsmallGreyMedium(_getPermissionValue(
                          value.permissionStatusModel?.isLocationServiceOn)),
                    ],
                  ),
                  Spacing().xsmallVertical,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.xsmallGreyG1Regular('Storage'),
                      AppText.xsmallGreyMedium(_getPermissionValue(
                          value.permissionStatusModel?.isStorage)),
                    ],
                  ),
                ],
              )
            : Container();
      },
    );
  }

  _getPermissionValue(bool? value) {
    if (value != null) {
      return value ? 'Yes' : 'No';
    } else {
      return 'No';
    }
  }

  Widget _progressBar(BuildContext context) {
    return const AppProgressBar();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen.commonScreenWithAppbar(
        context: context,
        scaffoldKey: _scaffoldKey,
        appbarWidget:
            CommonAppBar(title: AppStrings().device_test, subTitle: ''),
        buildScreenColor: AppColors.white,
        screenWidget: _buildScreenWidget(context));
  }

  @override
  void connectivityChanged(bool isDeviceConnected, String? source) {
    // TODO: implement connectivityChanged
  }

  @override
  void isConnectedToLowNetwork(bool isLowNetwork) {
    if (isLowNetwork) {
      CustomMaterialBanner.showLowInternetConnectionBanner(context: context);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).clearMaterialBanners();
      }
    }
  }
}
