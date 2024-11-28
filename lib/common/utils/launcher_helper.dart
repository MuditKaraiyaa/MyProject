import 'package:url_launcher/url_launcher.dart';

class URLLauncherHelper {
  /// Launches WhatsApp with the provided mobile number and a default message.
  static void launchWhatsapp({required String mobile}) async {
    final Uri uri = Uri.parse("whatsapp://send?phone=$mobile&text=hello");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not launch $uri');
    }
  }

  /// Launches the default email app with the provided email address.
  static void launchEmail({required String email}) async {
    Uri uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not launch $uri');
    }
  }

  /// Launches the default phone app with the provided mobile number.
  static void launchMobile({required String mobile}) async {
    Uri uri = Uri(scheme: 'tel', path: mobile);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not launch $uri');
    }
  }
}
