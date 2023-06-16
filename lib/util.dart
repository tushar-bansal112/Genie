import 'package:flutter/material.dart';

class Utils {

  SnackBar errorMessage (String message) {
      return SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content:  Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      backgroundColor: Colors.redAccent,
      padding: const EdgeInsets.all(20),
      duration: const Duration (seconds: 3),
      action: SnackBarAction(
        label: 'Done',
        textColor: Colors.blue,
        onPressed: () {},
      ),
    );
  }
}