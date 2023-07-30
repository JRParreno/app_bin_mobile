import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/utils/profile_utils.dart';
import 'package:app_bin_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:app_bin_mobile/src/features/account/profile/presentation/screens/update_profile_picture_screen.dart';
import 'package:app_bin_mobile/src/features/account/profile/presentation/widgets/menu_options.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Profile? profile;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => initProfile());
    super.initState();
  }

  void initProfile() {
    setState(() {
      profile = ProfileUtils.userProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 115,
                          width: 115,
                          child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
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
                                Positioned(
                                    bottom: 0,
                                    right: -25,
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen:
                                              const UpdateProfilePcitureScreen(),
                                          withNavBar:
                                              false, // OPTIONAL VALUE. True by default.
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                        ).whenComplete(() => initProfile());
                                      },
                                      elevation: 2.0,
                                      fillColor: ColorName.primary,
                                      padding: const EdgeInsets.all(8.0),
                                      shape: const CircleBorder(),
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                      ),
                                    )),
                              ]),
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
              MenuOptions(
                ctx: context,
                onCallBack: initProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
