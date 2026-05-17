import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoder;
import 'package:geolocator/geolocator.dart';
import 'package:premises/application/app_data.dart';
import 'package:premises/common/utils/utils.dart';

import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/resources.dart';

class LocationUtils {
  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final List<_PositionItem> _positionItems = <_PositionItem>[];

  Future<dynamic> getLocationDetails({String? moduleName}) async {
    final context = navigatorKey.currentState!.overlay!.context;
    final hasPermission = await _handlePermission(context, moduleName);

    if (!hasPermission) {
      return;
    }

    if (AppData().userLocationDetails != null) {
      UserLocationDetails? userLocationDetails = AppData().userLocationDetails;
      return userLocationDetails;
    } else {
      try {
        final currentPosition = await _geolocatorPlatform.getCurrentPosition(
            locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.high,
                timeLimit: Duration(seconds: 30)));

        UserLocationDetails? userLocationDetails = UserLocationDetails();
        await _setLocationData(currentPosition);
        return userLocationDetails;
      } catch (e) {
        try {
          final currentPosition = await _geolocatorPlatform.getCurrentPosition(
              locationSettings: const LocationSettings(
                  accuracy: LocationAccuracy.low,
                  timeLimit: Duration(seconds: 10)));

          UserLocationDetails? userLocationDetails = UserLocationDetails();
          await _setLocationData(currentPosition);
          return userLocationDetails;
        } catch (e) {
          final lastKnownPosition = await _geolocatorPlatform
              .getLastKnownPosition(forceLocationManager: true);
          if (lastKnownPosition != null) {
            UserLocationDetails? userLocationDetails = UserLocationDetails();
            await _setLocationData(lastKnownPosition);
            return userLocationDetails;
          } else {
            if (e.toString().isNotEmpty) {
              _showLocationErrorDialog(context, e.toString());
            } else {
              _showLocationServiceUnavailableDialog(context);
            }
            _updatePositionList(
              _PositionItemType.log,
              'No last known position available',
            );
          }
        }
      }
    }
  }

  _setLocationData(Position geoLocationPosition) async {
    UserLocationDetails? userLocationDetails = UserLocationDetails();
    userLocationDetails.latitude = geoLocationPosition.latitude;
    userLocationDetails.longitude = geoLocationPosition.longitude;
    userLocationDetails.heading = geoLocationPosition.heading;
    userLocationDetails.headingAccuracy = geoLocationPosition.accuracy;
    userLocationDetails.altitude = geoLocationPosition.altitude;
    userLocationDetails.userAddress = await getAddress(
        lat: geoLocationPosition.latitude,
        altitude: geoLocationPosition.altitude,
        lang: geoLocationPosition.longitude);
    CustomLogger.printKV('Known Location', geoLocationPosition);
    AppData().userLocationDetails = userLocationDetails;
    _updatePositionList(
      _PositionItemType.position,
      geoLocationPosition.toString(),
    );
    return userLocationDetails;
  }

  Future<bool> _handlePermission(
      BuildContext? context, String? moduleName) async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        _updatePositionList(
          _PositionItemType.log,
          _kPermissionDeniedMessage,
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      _showPermissionDeniedDialog(context!, moduleName);

      _updatePositionList(
        _PositionItemType.log,
        _kPermissionDeniedForeverMessage,
      );

      return false;
    }

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      _showTurnOnLocationServiceDialog(context!);
      _updatePositionList(
        _PositionItemType.log,
        _kLocationServicesDisabledMessage,
      );

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _updatePositionList(
      _PositionItemType.log,
      _kPermissionGrantedMessage,
    );
    return true;
  }

  void _updatePositionList(_PositionItemType type, String displayValue) {
    _positionItems.add(_PositionItem(type, displayValue));
  }

  static Future<String?> getAddress(
      {required double? lat,
      required double? lang,
      required double? altitude}) async {
    try {
      if (lat != null && lang != null && altitude != null) {
        List<geocoder.Placemark> placemarks =
            await geocoder.placemarkFromCoordinates(lat, lang);
        if (placemarks.isNotEmpty) {
          geocoder.Placemark placemark = placemarks[0];
          List<String> addressList = [];
          StringBuffer buffer = StringBuffer();
          addressList.add(placemark.name ?? '');
          addressList.add(placemark.street ?? '');
          addressList.add(placemark.locality ?? '');
          addressList.add(placemark.subLocality ?? '');
          addressList.add(placemark.postalCode ?? '');
          addressList.add(placemark.administrativeArea ?? '');
          addressList.add(placemark.subAdministrativeArea ?? '');
          addressList.add(placemark.country ?? '');
          addressList.add('${altitude.toStringAsFixed(2)}m');

          for (int i = 0; i < addressList.length; i++) {
            var element = addressList[i];
            if (element.isNotEmpty) {
              if (i == addressList.length - 1) {
                buffer.write(element);
              } else {
                buffer.write('$element, ');
              }
            }
          }

          String userFinalAddress = buffer.toString();
          CustomLogger.printKV('user_address', userFinalAddress);
          return userFinalAddress;
        } else {
          //return AppStrings().error_location;
          return null;
        }
      } else {
        UserLocationDetails? userLocationDetails =
            await LocationUtils().getLocationDetails();
        if (userLocationDetails != null) {
          if (userLocationDetails.userAddress != null) {
            return userLocationDetails.userAddress;
          } else {
            //return AppStrings().error_location;
            return null;
          }
        } else {
          //return AppStrings().error_location;
          return null;
        }
      }
    } catch (error) {
      //return AppStrings().error_location + error.toString();
      return null;
    }
  }

  void _openLocationSettings() async {
    final opened = await _geolocatorPlatform.openLocationSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Location Settings';
    } else {
      displayValue = 'Error opening Location Settings';
    }

    _updatePositionList(
      _PositionItemType.log,
      displayValue,
    );
  }

  _showLocationErrorDialog(BuildContext context, String? exception) {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return CommonAlertDialog(
          onPressed: () {
            Navigator.of(dialogContext).pop();
            getLocationDetails();
          },
          onPressedClosedIcon: () {
            Navigator.of(dialogContext).pop();
            if (Platform.isAndroid) {
              //getLocationDetails();
            }
          },
          dialogButtonName: AppStrings().retry,
          dialogMessage:
              '${AppStrings().location_service_error}\n${exception.toString()}',
          dialogTitle: AppStrings().unable_to_fetch_location,
        );
      },
    );
  }

  _showLocationServiceUnavailableDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return CommonAlertDialog(
          onPressed: () {
            Navigator.of(dialogContext).pop();
            getLocationDetails();
          },
          onPressedClosedIcon: () {
            Navigator.of(dialogContext).pop();
            if (Platform.isAndroid) {
              //getLocationDetails();
            }
          },
          dialogButtonName: AppStrings().retry,
          dialogMessage: AppStrings().location_service_unavailable,
          dialogTitle: AppStrings().device_not_able_to_fetch_location,
        );
      },
    );
  }

  _showPermissionDeniedDialog(BuildContext context, String? moduleName) {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return CommonAlertDialog(
          onPressed: () {
            Navigator.of(dialogContext).pop();
            _openLocationSettings();
          },
          onPressedClosedIcon: () {
            Navigator.of(dialogContext).pop();
            if (Platform.isAndroid) {
              getLocationDetails();
            }
          },
          showCloseButton: true,
          dialogButtonName: AppStrings().open_settings,
          dialogMessage:
              '${AppStrings().location_permission}\n${getModulewiseLocationPermissionMessage(moduleName)}',
          dialogTitle: AppStrings().location_permission_title,
        );
      },
    );
  }

  String getModulewiseLocationPermissionMessage(String? moduleName) {
    String message = '';
    if (moduleName == AppStrings().work_permit) {
      message = AppStrings().work_permit_location_permission;
    } else if (moduleName == AppStrings().checklist) {
      message = AppStrings().checklist_location_permission;
    } else if (moduleName == AppStrings().toolbox_training) {
      message = AppStrings().tbt_location_permission;
    } else if (moduleName == AppStrings().safety_actionable) {
      message = AppStrings().safety_observation_location_permission;
    } else if (moduleName == AppStrings().incident_report) {
      message = AppStrings().incident_location_permission;
    } else if (moduleName == AppStrings().induction_training) {
      message = AppStrings().tbt_location_permission;
    } else if (moduleName == AppStrings().violation_notice) {
      message = AppStrings().violation_notice_location_permission;
    } else if (moduleName == AppStrings().captured_attendance) {
      message = AppStrings().attendance_location_permission;
    } else {
      message = AppStrings().generic_location_permission;
    }
    return message;
  }

  String getModulewiseLocationAndGPSPermissionMessage(String? moduleName) {
    return 'Location permission or GPS is required to submit $moduleName.';
  }

  _showTurnOnLocationServiceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return CommonAlertDialog(
          onPressed: () {
            Navigator.of(dialogContext).pop();
            _openLocationSettings();
          },
          onPressedClosedIcon: () {
            Navigator.of(dialogContext).pop();
            if (Platform.isAndroid) {
              //getLocationDetails();
            }
          },
          dialogButtonName: AppStrings().open_settings,
          dialogMessage: AppStrings().location_service_unavailable,
          dialogTitle: AppStrings().location_permission_turn_on,
        );
      },
    );
  }
}

class UserLocationDetails {
  double? latitude;
  double? longitude;
  double? altitude;
  double? heading;
  double? headingAccuracy;
  String? userAddress;

  UserLocationDetails(
      {this.latitude,
      this.longitude,
      this.altitude,
      this.heading,
      this.headingAccuracy,
      this.userAddress});
}

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
