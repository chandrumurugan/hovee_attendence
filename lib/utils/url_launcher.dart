import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class URLLauncherHelper {
  /// Launches a URL in the browser. Displays an error message if it fails.
  static Future<void> launchInBrowser(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Opens in the browser
      );
    } else {
      // Show error dialog if URL cannot be launched
      _showErrorDialog(context, "Could not launch the URL: $url");
    }
  }

  /// Private method to show an error dialog
  static void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
