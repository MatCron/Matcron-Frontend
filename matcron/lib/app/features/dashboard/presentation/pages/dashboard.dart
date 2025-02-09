import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:matcron/app/features/dashboard/presentation/bloc/remote_dashboard_bloc.dart';
import 'package:matcron/app/features/dashboard/presentation/bloc/remote_dashboard_state.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/core/components/bottom_bar/controllers/notch_bottom_bar_controller.dart';

class DashboardPage extends StatelessWidget {
  final NotchBottomBarController? controller;

  // Use super constructor parameter for 'key'
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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  ...buildStatCards(),
                  const SizedBox(height: 20),
                  Text("Mattress Lifecycle", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  _chartStack(context),
                  const SizedBox(height: 20),
                  Text("Mattress Maintenance", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  _maintenanceChart(context),
                  const SizedBox(height: 20),
                  Text("Request Wash", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ListTile(
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
      child: Stack(
        children: [
          _createLifecycleChart(),
          _createTrendLineChart(),
        ],
      ),
    );
  }

  Widget _maintenanceChart(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      height: 200,
      child: _createMaintenancePieChart(),
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

  Widget _createLifecycleChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 300,
        backgroundColor: Colors.white, // Set the background color to white
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey[800],
            tooltipPadding: const EdgeInsets.all(8),
            tooltipMargin: 8,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay = _getWeekDay(group.x.toDouble());
              return BarTooltipItem(
                '$weekDay: ${rod.y.toInt()} mattresses',
                TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        titlesData: _buildTitlesData(),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey[300]!, width: 2),
        ),
        barGroups: _buildBarGroups(),
      ),
    );
  }

  Widget _createTrendLineChart() {
    return Positioned.fill(
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 300),
                FlSpot(1, 225),
                FlSpot(2, 190),
                FlSpot(3, 150),
              ],
              isCurved: true,
              colors: [Colors.black],
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            )
          ],
        ),
      ),
    );
  }

  Widget _createMaintenancePieChart() {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (pieTouchResponse) {},
          enabled: true,
        ),
        centerSpaceRadius: 40,
        sectionsSpace: 0,
        startDegreeOffset: -90,
        sections: [
          PieChartSectionData(
            color: Colors.blue[100]!,
            value: 30,
            title: 'Flip (30)',
            radius: 60,
            titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.blue[300]!,
            value: 40,
            title: 'Rotate (40)',
            radius: 60,
            titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.blue[600]!,
            value: 30,
            title: 'Wash (30)',
            radius: 60,
            titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  String _getWeekDay(double value) {
    switch (value.toInt()) {
      case 0: return 'Active';
      case 1: return 'Transferred';
      case 2: return 'End Life';
      case 3: return 'Review';
      default: return '';
    }
  }

  FlTitlesData _buildTitlesData() => FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      getTextStyles: (_) => const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
      margin: 12,
      getTitles: (value) => _getWeekDay(value),
    ),
    leftTitles: SideTitles(showTitles: false),
  );

  List<BarChartGroupData> _buildBarGroups() => [
    BarChartGroupData(x: 0, barRods: [BarChartRodData(y: 300, width: 18, colors: [Colors.green])]),
    BarChartGroupData(x: 1, barRods: [BarChartRodData(y: 150, width: 18, colors: [Colors.blue])]),
    BarChartGroupData(x: 2, barRods: [BarChartRodData(y: 80, width: 18, colors: [Colors.red])]),
    BarChartGroupData(x: 3, barRods: [BarChartRodData(y: 100, width: 18, colors: [Colors.yellow])]),
  ];
}

class StatCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final String imagePath;

  const StatCard({super.key, required this.title, required this.count, required this.icon, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        child: ListTile(
          title: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text(count, style: TextStyle(color: Colors.white70)),
          leading: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
