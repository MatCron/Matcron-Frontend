import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:matcron/app/features/dashboard/presentation/bloc/remote_dashboard_bloc.dart';
import 'package:matcron/app/features/dashboard/presentation/bloc/remote_dashboard_state.dart';
import 'package:matcron/app/injection_container.dart';
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
    final theme = Theme.of(context);
    return BlocBuilder<RemoteDashboardBloc, RemoteDashboardState>(
      builder: (_, state) {
        if (state is RemoteDashboardInitial) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  ...buildStatCards(),
                  const SizedBox(height: 20),
                  Text("Mattress Lifecycle",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary)),
                  _chartStack(context),
                  const SizedBox(height: 20),
                  Text("Mattress Maintenance",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary)),
                  _maintenanceChart(context),
                  const SizedBox(height: 20),
              
                  Text("Request Wash",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary)),
                  const ListTile(
                    title: Text("Louth Hospital has requested wash for 27 Mattress"),
                    trailing: Icon(Icons.pending_actions),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _chartStack(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      height: 200,
      child: _createLifecycleChart(context),
    );
  }

  Widget _maintenanceChart(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      height: 200,
      child: _createMaintenancePieChart(context),
    );
  }

  List<Widget> buildStatCards() => [
        StatCard(
          title: "Active",
          count: "308",
          icon: Icons.hotel,
          imagePath: "assets/images/bed3.jpg",
        ),
        StatCard(
          title: "Transferred Out",
          count: "308",
          icon: Icons.transfer_within_a_station,
          imagePath: "assets/images/mattress1.jpg",
        ),
        StatCard(
          title: "End Lifecycle",
          count: "112",
          icon: Icons.delete,
          imagePath: "assets/images/assign_page.png",
        ),
        StatCard(
          title: "Review Required",
          count: "112",
          icon: Icons.reviews,
          imagePath: "assets/images/bed-1.jpg",
        ),
      ];

  Widget _createLifecycleChart(BuildContext context) {
    final theme = Theme.of(context);
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 2),
      tween: Tween(begin: 0, end: 1),
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.onSecondary,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 300,
              gridData: FlGridData(show: false),
              titlesData: _buildTitlesData(context),
              barTouchData: BarTouchData(enabled: false),
              borderData: FlBorderData(show: false),
              barGroups: [
                _stackedBarGroup(0, 100, 150, value, context),
                _stackedBarGroup(1, 140, 110, value,context),
                _stackedBarGroup(2, 80, 50, value,context),
                _stackedBarGroup(3, 60, 40, value,context),
              ],
            ),
          ),
        );
      },
    );
  }

  BarChartGroupData _stackedBarGroup(int x, double lower, double upper, double value,BuildContext context) {
    final theme = Theme.of(context);
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: (lower + upper) * value,
          width: 24,
          borderRadius: BorderRadius.circular(6),
          rodStackItems: [
            BarChartRodStackItem(0, lower * value, theme.primaryColor),
            BarChartRodStackItem(lower * value, (lower + upper) * value, Colors.deepPurple.shade100),
          ],
        ),
      ],
    );
  }

  FlTitlesData _buildTitlesData(BuildContext context) {
    final theme = Theme.of(context);
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) => Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _getWeekDay(value),
              style:  TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          reservedSize: 32,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  String _getWeekDay(double value) {
    switch (value.toInt()) {
      case 0:
        return 'Active';
      case 1:
        return 'Transferred';
      case 2:
        return 'Decomission';
      case 3:
        return 'Review';
      default:
        return '';
    }
  }

  Widget _createMaintenancePieChart(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSecondary,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(enabled: true),
          centerSpaceRadius: 40,
          startDegreeOffset: -90,
          sectionsSpace: 0,
          sections: [
            PieChartSectionData(
              color: Colors.deepPurple.shade100,
              value: 30,
              title: 'Flip',
              radius: 60,
              titleStyle:  TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.surface,
              ),
            ),
            PieChartSectionData(
              color: theme.primaryColor,
              value: 40,
              title: 'Rotate',
              radius: 60,
              titleStyle:  TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.surface,
              ),
            ),
            PieChartSectionData(
              color: Colors.deepPurple.shade400,



              value: 30,
              title: 'Wash',
              radius: 60,
              titleStyle:  TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color:theme.colorScheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }


}

class StatCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final String imagePath;

  const StatCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        child: ListTile(
          title: Text(title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text(count, style: const TextStyle(color: Colors.white70)),
          leading: Icon(icon, color: Colors.white),
        ),
      ),
    );
}
}
