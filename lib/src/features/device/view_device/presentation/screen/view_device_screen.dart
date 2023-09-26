import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:app_bin_mobile/src/features/device/add_device/presentation/screen/add_device_screen.dart';
import 'package:app_bin_mobile/src/features/device/view_device/presentation/bloc/pair_device_user_bloc.dart';
import 'package:app_bin_mobile/src/features/device/view_device/presentation/widgets/pair_device_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ViewDeviceScreen extends StatefulWidget {
  static const String routeName = '/view-device-screen';

  const ViewDeviceScreen({super.key});

  @override
  State<ViewDeviceScreen> createState() => _ViewDeviceScreenState();
}

class _ViewDeviceScreenState extends State<ViewDeviceScreen> {
  @override
  void initState() {
    super.initState();
    initialValueBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "Device(s)"),
      body: BlocBuilder<PairDeviceUserBloc, PairDeviceUserState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PairDeviceUserLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                Future.delayed(const Duration(milliseconds: 500), () {
                  initialValueBloc();
                });
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.pairDevies.length,
                itemBuilder: (context, index) {
                  final item = state.pairDevies[index];

                  return PairDeviceCard(pairDevice: item);
                },
              ),
            );
          }

          if (state is EmptyState) {
            return Container(
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: "No Device found",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomBtn(
                      label: 'Refresh',
                      onTap: () {
                        initialValueBloc();
                      },
                    )
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const AddDeviceScreen(),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void initialValueBloc() {
    BlocProvider.of<PairDeviceUserBloc>(context).add(FetchPairDeviceEvent());
  }
}
