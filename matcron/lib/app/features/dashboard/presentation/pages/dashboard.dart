import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/dashboard/presentation/bloc/remote_dashboard_bloc.dart';
import 'package:matcron/app/features/dashboard/presentation/bloc/remote_dashboard_state.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/components/bottom_bar/controllers/notch_bottom_bar_controller.dart';

class DashboardPage extends StatelessWidget {
  final NotchBottomBarController? controller;

  const DashboardPage({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteDashboardBloc>(
      create: (context) => sl(),
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<RemoteDashboardBloc, RemoteDashboardState>(
      builder: (_, state) {
        if (state is RemoteDashboardInitial) {
          // call the getdashboardinfo, but initalize everything at 0
          return Container(
            color: HexColor("#E5E5E5"),
            child: Center(
              /// adding GestureDetector
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  controller?.jumpTo(2);
                },
                child: const Text('Dashboard Page'),
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
