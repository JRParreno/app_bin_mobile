import 'package:app_bin_mobile/gen/assets.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/block/presentation/widget/usage_limit/usage_limit.dart';
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
          text: "Life's better without scrolling",
        ),
      ),
      body: Column(
        children: [
          Expanded(child: Assets.json.socialMediaInfluencer.lottie()),
          const Expanded(child: UsageLimit()),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Colors.green,
      //   child: const Icon(Icons.logout),
      // ),
    );
  }
}
