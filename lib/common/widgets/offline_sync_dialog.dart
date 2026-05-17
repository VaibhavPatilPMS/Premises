import 'package:flutter/material.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';

class OfflineSyncDialog extends StatelessWidget {
  final Function? onSyncButtonPressed;
  final Function? onCloseButtonPressed;

  const OfflineSyncDialog({super.key,
    required this.onSyncButtonPressed,required this.onCloseButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          AlertDialog(
            content: SingleChildScrollView(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, color: Colors.black, height: 1.5,fontFamily: FontFamily.fontFamily),
                  children: [
                    const TextSpan(
                      text: 'To use this app in offline mode, please follow these steps:\n\n',
                      style: TextStyle(fontWeight: FontWeight.bold,fontFamily: FontFamily.fontFamily),
                    ),
                    const TextSpan(
                      text:
                      'Open the Side Navigation Drawer, go to Menu > Sync Project Data, and tap on the Sync Project Data button.\n\n',
                      style: TextStyle(fontFamily: FontFamily.fontFamily)

                    ),
                    const TextSpan(
                      text: 'Note:\n',
                      style: TextStyle(fontWeight: FontWeight.bold,fontFamily: FontFamily.fontFamily),
                    ),
                    const TextSpan(text: '- Only the ',style: TextStyle(fontFamily: FontFamily.fontFamily)),
                    const TextSpan(
                      text: 'currently selected project',
                      style: TextStyle(fontWeight: FontWeight.bold,fontFamily: FontFamily.fontFamily),
                    ),
                    const TextSpan(text: ' data will be synced.\n\n',style: TextStyle(fontFamily: FontFamily.fontFamily)),
                    const TextSpan(text: '- Make sure you have a ',style: TextStyle(fontFamily: FontFamily.fontFamily)),
                    const TextSpan(
                      text: 'stable internet connection',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: ' while syncing the data.',style: TextStyle(fontFamily: FontFamily.fontFamily)),
                    const TextSpan(
                      text: '\n\n- You can use only the following modules in offline mode:',
                      style: TextStyle(fontFamily: FontFamily.fontFamily),
                    ),
                    const TextSpan(
                      text: '\nInduction Training, Toolbox Training, Work Permit, and Checklists.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: '\n\n- After syncing, you’ll be able to use the app in '),
                    const TextSpan(
                      text: 'offline mode.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.color_primary,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(AppSizes().butttonRoundedCorners),
                    )),
                onPressed: () {
                  if (onCloseButtonPressed != null) {
                    onCloseButtonPressed!();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Okay'),
              ),
              // TextButton(
              //   style: TextButton.styleFrom(
              //       foregroundColor: AppColors.text_grey_dark,
              //       shape: RoundedRectangleBorder(
              //         borderRadius:
              //         BorderRadius.circular(AppSizes().butttonRoundedCorners),
              //       )),
              //   onPressed: () {
              //     if (onSyncButtonPressed != null) {
              //       onSyncButtonPressed!();
              //     } else {
              //       Navigator.of(context).pop();
              //     }
              //   },
              //   child: const Text('Sync Now'),
              // ),
            ],
          )
        ]
    );
  }
}
