import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/utils/profile_utils.dart';
import 'package:app_bin_mobile/src/features/account/profile/presentation/widgets/menu_options.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profile = ProfileUtils.userProfile(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Flexible(
                child: Center(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: profile?.profilePhoto != null
                              ? NetworkImage(profile!.profilePhoto!)
                              : null,
                          radius: 50,
                          child: profile?.profilePhoto != null
                              ? null
                              : const Icon(Icons.person, size: 50),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: '${profile?.firstName} ${profile?.lastName}',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const MenuOptions(),
            ],
          ),
        ),
      ),
    );
  }
}
