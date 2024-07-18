import 'package:flutter/material.dart';

class StatusProductIcons {
  static Widget collectedIcon() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      padding: const EdgeInsets.all(5.0),
      child: const Icon(
        Icons.check,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  static Widget notCollectedIcon() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      padding: const EdgeInsets.all(5.0),
      child: const Icon(
        Icons.close,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
