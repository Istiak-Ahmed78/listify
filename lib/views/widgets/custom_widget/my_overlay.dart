import 'package:flutter/material.dart';

class MyOverlay extends StatefulWidget {
  const MyOverlay({Key? key}) : super(key: key);

  @override
  State<MyOverlay> createState() => _MyOverlayState();
}

class _MyOverlayState extends State<MyOverlay> {
  Overlay? overlay;
  OverlayEntry? overlayEntry;
  void showOverlay(BuildContext context) {
    if (overlay != null) {
      final overlayState = Overlay.of(context);
      final overlayEntry = OverlayEntry(builder: (context) {
        return FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.error),
        );
      });
      overlayState!.insert(overlayEntry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
