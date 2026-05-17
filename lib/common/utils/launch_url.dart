import 'dart:io';

import 'package:premises/common/utils/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchURL {
  LaunchURL(String s);

  static launchBrowser(url) {
    final encodedUrl = Uri.encodeFull(url);
    call(encodedUrl);
  }

  static launchPhone(String? no) {
    if (no != null && no.isNotEmpty) {
      call('tel:$no');
    } else {
      return;
    }
  }

  static Future<void> call(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) throw 'Could not launch $url';
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static Future<void> launchEmail(String emailId) async {
    Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailId,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Tell us your feedback',
      }),
    );
    if (!await launchUrl(emailLaunchUri)) throw 'Could not launch $emailId';
  }

  static Future<void> openvideoLink(String url) async {
    final Uri uri = Uri.parse(url);

    if (_isYoutubeLink(uri.toString()) || _isDriveLink(uri.toString())) {
      // Always open in external browser
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception("Could not launch $uri");
      }
    } else {
      // Default behavior (optional: open inside app or browser)
      if (!await launchUrl(uri)) {
        throw Exception("Could not launch $uri");
      }
    }
  }

  static bool _isYoutubeLink(String url) {
    return url.contains("youtube.com") || url.contains("youtu.be");
  }

  static bool _isDriveLink(String url) {
    return url.contains("drive.google.com");
  }

  static Future<void> launchwhatsapp(String phoneNumber) async {
    var contact = phoneNumber;
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
        if (!await launchUrl(Uri.parse(iosUrl)))
          throw 'Could not launch $contact';
      } else {
        if (!await launchUrl(Uri.parse(androidUrl)))
          throw 'Could not launch $contact';
      }
    } on Exception {
      CustomLogger.logPrint("Whatsapp not installed");
      if (!await launchUrl(Uri.parse('https://web.whatsapp.com/')))
        throw 'Could not launch $contact';
    }
  }
}
