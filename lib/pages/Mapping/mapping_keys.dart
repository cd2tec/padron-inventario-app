import 'dart:async';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galactic_hotkeys/galactic_hotkeys_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MappingKeys(),
    );
  }
}
@RoutePage()
class MappingKeys extends StatefulWidget {
  const MappingKeys({Key? key}) : super(key: key);

  @override
  _MappingKeysState createState() => _MappingKeysState();
}

class _MappingKeysState extends State<MappingKeys> {
  String? _latestPressedKey;
  Timer? _delayToClearPressedKey;

  @override
  void dispose() {
    _delayToClearPressedKey?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapping Keys'),
      ),
      body: Focus(
        autofocus: true,
        onKey: (node, event) {
          if (event is RawKeyDownEvent) {
            setState(() {
              _latestPressedKey = event.logicalKey.keyLabel;
            });

            _delayToClearPressedKey?.cancel();
            _delayToClearPressedKey = Timer(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  _latestPressedKey = null;
                });
              }
            });
          }
          return KeyEventResult.handled;
        },
        child: ListView(
          children: [
            if (_latestPressedKey != null)
              ListTile(
                title: Text(
                  _latestPressedKey!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
