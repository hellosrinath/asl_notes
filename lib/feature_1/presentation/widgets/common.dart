import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

void snackBarError({
  String? msg,
  GlobalKey<ScaffoldState>? scaffoldState,
  required BuildContext context,
}) {
/*  scaffoldState!.currentState!.showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$msg"),
          const Icon(FontAwesome.exclamation_triangle)
        ],
      ),
    ),
  );*/
  if (scaffoldState!.currentState != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$msg"),
            const Icon(FontAwesome.exclamation_triangle)
          ],
        ),
      ),
    );
  }
}
