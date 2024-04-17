import 'package:flutter/material.dart';

class SuccessSnackBar extends SnackBar {
  SuccessSnackBar({
    Key? key,
    required String message,
  }) : super(
    key: key,
    content: Text(
      message,
      style: const TextStyle(fontSize: 16),
    ),
    backgroundColor: Colors.green,
  );
}

class ErrorSnackBar extends SnackBar {
  ErrorSnackBar({
    Key? key,
    required String message,
  }) : super(
    key: key,
    content: Text(
      message,
      style: const TextStyle(fontSize: 16),
    ),
    backgroundColor: Colors.redAccent,
  );
}
