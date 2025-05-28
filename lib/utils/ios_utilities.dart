import 'package:flutter/cupertino.dart';

/// Classe com widgets e utilidades específicas para iOS
class IOSUtilities {

  /// Retorna um botão estilo iOS
  static Widget buildIOSButton({
    required String text,
    required VoidCallback onPressed,
    Color color = const Color(0xFF003366),
    bool filled = false,
  }) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: filled ? color : null,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: filled ? CupertinoColors.white : color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Retorna um alerta estilo iOS
  static Future<void> showIOSAlert({
    required BuildContext context,
    required String title,
    required String message,
    String okButtonText = 'OK',
    VoidCallback? onOkPressed,
  }) async {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text(okButtonText),
            onPressed: () {
              Navigator.of(context).pop();
              if (onOkPressed != null) {
                onOkPressed();
              }
            },
          ),
        ],
      ),
    );
  }

  /// Retorna um seletor de data estilo iOS
  static Future<DateTime?> showIOSDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    DateTime? selectedDate = initialDate;
    
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: initialDate,
            minimumDate: firstDate,
            maximumDate: lastDate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime newDate) {
              selectedDate = newDate;
            },
          ),
        ),
      ),
    );
    
    return selectedDate;
  }
}
