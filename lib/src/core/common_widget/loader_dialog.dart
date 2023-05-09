import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class LoaderDialog {
  static void show({
    required BuildContext context,
  }) {
    // Future.delayed(Duration.zero, () {
      showDialog(
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(.2),
        context: context,
        builder: (context) => WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child:  Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Container(
                  height: 75,
                  width: 75,
                  decoration:  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    // });
  }

  static void hide({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}
