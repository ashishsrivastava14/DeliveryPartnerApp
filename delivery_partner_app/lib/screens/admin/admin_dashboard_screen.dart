import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../controllers/admin_controller.dart';

class AdminDashboardScreen extends StatelessWidget {
  AdminDashboardScreen({super.key});

  final AdminController controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Admin Dashboard', style: GoogleFonts.poppins(fontSize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => controller.selectedNavIndex.value = 5,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Cards
            GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                _KpiCard(
                  title: 'Active Partners',
                  value: '${controller.activePartnersCount}',
                  icon: Icons.people,
                  color: AppColors.primary,
                  trend: '+12%',
                ),
                _KpiCard(
                  title: 'Orders Today',
                  value: '${controller.totalOrdersToday}',
                  icon: Icons.receipt_long,
                  color: AppColors.accent,
                  trend: '+8%',
                ),
                _KpiCard(
                  title: 'Avg Delivery',
                  value: '${controller.avgDeliveryTime}m',
                  icon: Icons.timer,
                  color: AppColors.info,
                  trend: '-5%',
                ),
                _KpiCard(
                  title: 'Earnings Paid',
                  value: '₹1.85L',
                  icon: Icons.payments,
                  color: AppColors.success,
                  trend: '+15%',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Charts Row
            Text('Daily Orders This Week',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 12),
            Card(
              color: AppColors.cardDark,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 80,
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final days = controller.weekDays;
                              if (value.toInt() < days.length) {
                                return Text(days[value.toInt()],
                                    style: GoogleFonts.dmSans(
                                        fontSize: 11, color: Colors.white54));
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return Text('${value.toInt()}',
                                  style: GoogleFonts.dmSans(
                                      fontSize: 10, color: Colors.white38));
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 20,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: Colors.white.withValues(alpha: 0.05),
                          strokeWidth: 1,
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: List.generate(7, (i) {
                        return BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: controller.dailyOrders[i],
                              color: AppColors.primary,
                              width: 18,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Earnings Trend
            Text('Earnings Trend',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 12),
            Card(
              color: AppColors.cardDark,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 1000,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: Colors.white.withValues(alpha: 0.05),
                          strokeWidth: 1,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() < controller.weekDays.length) {
                                return Text(controller.weekDays[value.toInt()],
                                    style: GoogleFonts.dmSans(
                                        fontSize: 11, color: Colors.white54));
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text('₹${(value / 1000).toStringAsFixed(1)}k',
                                  style: GoogleFonts.dmSans(
                                      fontSize: 10, color: Colors.white38));
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(7, (i) {
                            return FlSpot(i.toDouble(), controller.earningsTrend[i]);
                          }),
                          isCurved: true,
                          color: AppColors.accent,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, bar, index) =>
                                FlDotCirclePainter(
                              radius: 4,
                              color: AppColors.accent,
                              strokeWidth: 2,
                              strokeColor: AppColors.cardDark,
                            ),
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppColors.accent.withValues(alpha: 0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Recent Activity
            Text('Recent Activity',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 12),
            ..._recentActivities.map((activity) => Card(
                  color: AppColors.cardDark,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: activity['color'] as Color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(activity['icon'] as IconData,
                          color: Colors.white, size: 20),
                    ),
                    title: Text(activity['title'] as String,
                        style: GoogleFonts.dmSans(
                            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
                    subtitle: Text(activity['time'] as String,
                        style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white54)),
                  ),
                )),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  final _recentActivities = [
    {'title': 'New partner Vikram Singh registered', 'time': '5 min ago', 'icon': Icons.person_add, 'color': AppColors.primary},
    {'title': 'Order ORD-10236 assigned to Amit Sharma', 'time': '15 min ago', 'icon': Icons.assignment, 'color': AppColors.accent},
    {'title': 'Payout of ₹5,000 requested by Amit', 'time': '2 hours ago', 'icon': Icons.payments, 'color': AppColors.info},
    {'title': 'Order ORD-10234 delivered successfully', 'time': '1 hour ago', 'icon': Icons.check_circle, 'color': AppColors.success},
    {'title': 'Deepak Verma account suspended', 'time': '3 hours ago', 'icon': Icons.block, 'color': AppColors.error},
  ];
}

class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String trend;

  const _KpiCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.trend,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardDark,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: trend.startsWith('+')
                        ? AppColors.success.withValues(alpha: 0.2)
                        : AppColors.info.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    trend,
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: trend.startsWith('+') ? AppColors.success : AppColors.info,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(value,
                style: GoogleFonts.poppins(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(title,
                style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}
