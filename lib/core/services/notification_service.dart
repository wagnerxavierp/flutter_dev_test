import 'package:flutter/material.dart';

enum NotificationType { success, error, warning, info }

class NotificationService {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    NotificationType type = NotificationType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    Color backgroundColor;
    IconData icon;

    switch (type) {
      case NotificationType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case NotificationType.error:
        backgroundColor = Colors.red;
        icon = Icons.error;
        break;
      case NotificationType.warning:
        backgroundColor = Colors.orange;
        icon = Icons.warning;
        break;
      case NotificationType.info:
        backgroundColor = Colors.blue;
        icon = Icons.info;
        break;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          duration: duration,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
  }
}
