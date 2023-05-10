import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:flutter/material.dart';

class BlockScreen extends StatefulWidget {
  static const String routeName = '/block';
  const BlockScreen({super.key});

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "App Bin",
        ),
      ),
    );
  }
}
