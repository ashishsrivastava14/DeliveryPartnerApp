import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../mock/mock_orders.dart';

class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({super.key});

  @override
  State<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen> {
  DateTimeRange _selectedRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 7)),
    end: DateTime.now(),
  );

  String _selectedReportType = 'Orders';
  bool _reportGenerated = false;

  final List<String> _reportTypes = ['Orders', 'Earnings', 'Partners', 'Zones'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Reports & Analytics', style: GoogleFonts.poppins(fontSize: 18)),
      ),
      body: AppBackground(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Report Config Card
            Card(
              color: AppColors.cardDark,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Generate Report',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                    const SizedBox(height: 16),

                    // Report Type
                    Text('Report Type',
                        style: GoogleFonts.dmSans(
                            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: _reportTypes.map((type) {
                        final selected = _selectedReportType == type;
                        return ChoiceChip(
                          label: Text(type, style: GoogleFonts.dmSans(
                              color: selected ? Colors.white : Colors.white70, fontSize: 13)),
                          selected: selected,
                          selectedColor: AppColors.primary,
                          backgroundColor: AppColors.surfaceDark,
                          onSelected: (_) => setState(() {
                            _selectedReportType = type;
                            _reportGenerated = false;
                          }),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // Date Range
                    Text('Date Range',
                        style: GoogleFonts.dmSans(
                            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        final range = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2024),
                          lastDate: DateTime.now(),
                          initialDateRange: _selectedRange,
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.dark().copyWith(
                                colorScheme: const ColorScheme.dark(
                                  primary: AppColors.primary,
                                  surface: AppColors.surfaceDark,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (range != null) {
                          setState(() {
                            _selectedRange = range;
                            _reportGenerated = false;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.date_range, color: AppColors.primary, size: 20),
                            const SizedBox(width: 12),
                            Text(
                              '${_formatDate(_selectedRange.start)} - ${_formatDate(_selectedRange.end)}',
                              style: GoogleFonts.dmSans(fontSize: 14, color: Colors.white),
                            ),
                            const Spacer(),
                            const Icon(Icons.edit_calendar, color: Colors.white38, size: 18),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              setState(() => _reportGenerated = true);
                            },
                            icon: const Icon(Icons.analytics),
                            label: const Text('Generate'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _reportGenerated
                                ? () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Report exported as CSV!'),
                                        backgroundColor: AppColors.success,
                                      ),
                                    );
                                  }
                                : null,
                            icon: const Icon(Icons.download),
                            label: Text('Export', style: GoogleFonts.dmSans()),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              side: BorderSide(
                                  color: _reportGenerated ? AppColors.primary : Colors.white24),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            if (_reportGenerated) ...[
              const SizedBox(height: 24),

              // Summary Stats
              Text('Summary',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              const SizedBox(height: 12),
              _buildSummaryTable(),

              const SizedBox(height: 24),

              // Chart
              Text('Trend Chart',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              const SizedBox(height: 12),
              Card(
                color: AppColors.cardDark,
                child: SizedBox(
                  height: 240,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          getDrawingHorizontalLine: (_) =>
                              const FlLine(color: Colors.white10, strokeWidth: 1),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (val, _) => Text(
                                val.toInt().toString(),
                                style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white38),
                              ),
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (val, _) {
                                final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                                if (val.toInt() < labels.length) {
                                  return Text(labels[val.toInt()],
                                      style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white38));
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 42),
                              FlSpot(1, 55),
                              FlSpot(2, 38),
                              FlSpot(3, 62),
                              FlSpot(4, 48),
                              FlSpot(5, 71),
                              FlSpot(6, 58),
                            ],
                            isCurved: true,
                            color: AppColors.primary,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: AppColors.primary.withValues(alpha: 0.15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Detailed Table
              Text('Detail Breakdown',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              const SizedBox(height: 12),
              _buildDetailTable(),
            ],
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildSummaryTable() {
    final metrics = _getSummaryMetrics();
    return Card(
      color: AppColors.cardDark,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
          },
          children: metrics.entries.map((e) {
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(e.key,
                      style: GoogleFonts.dmSans(fontSize: 14, color: Colors.white70)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(e.value,
                      style: GoogleFonts.dmSans(
                          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Map<String, String> _getSummaryMetrics() {
    switch (_selectedReportType) {
      case 'Orders':
        return {
          'Total Orders': '${MockOrders.allOrders.length * 12}',
          'Delivered': '${(MockOrders.allOrders.length * 12 * 0.85).toInt()}',
          'Cancelled': '${(MockOrders.allOrders.length * 12 * 0.05).toInt()}',
          'Avg. Delivery Time': '18 min',
          'Avg. Order Value': '₹325',
        };
      case 'Earnings':
        return {
          'Total Revenue': '₹3395',
          'Avg. Daily': '₹485',
          'Incentives Paid': '₹73',
          'Platform Fee': '₹170',
          'Net Payouts': '₹3225',
        };
      case 'Partners':
        return {
          'Total Partners': '134',
          'Active Today': '78',
          'New Sign-ups': '12',
          'Avg. Rating': '4.3',
          'Avg. Orders/Partner': '8.2',
        };
      case 'Zones':
        return {
          'Active Zones': '6',
          'Total Zones': '8',
          'Hotspot Zone': 'Koramangala HSR',
          'Lowest Activity': 'Electronic City',
          'Avg. Partners/Zone': '16.7',
        };
      default:
        return {};
    }
  }

  Widget _buildDetailTable() {
    return Card(
      color: AppColors.cardDark,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingTextStyle: GoogleFonts.dmSans(
              fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary),
          dataTextStyle: GoogleFonts.dmSans(fontSize: 13, color: Colors.white70),
          columns: _getColumns(),
          rows: _getRows(),
        ),
      ),
    );
  }

  List<DataColumn> _getColumns() {
    switch (_selectedReportType) {
      case 'Orders':
        return const [
          DataColumn(label: Text('Day')),
          DataColumn(label: Text('Orders')),
          DataColumn(label: Text('Delivered')),
          DataColumn(label: Text('Avg Time')),
        ];
      case 'Earnings':
        return const [
          DataColumn(label: Text('Day')),
          DataColumn(label: Text('Revenue')),
          DataColumn(label: Text('Incentives')),
          DataColumn(label: Text('Net')),
        ];
      case 'Partners':
        return const [
          DataColumn(label: Text('Day')),
          DataColumn(label: Text('Online')),
          DataColumn(label: Text('New')),
          DataColumn(label: Text('Avg Rating')),
        ];
      default:
        return const [
          DataColumn(label: Text('Zone')),
          DataColumn(label: Text('Orders')),
          DataColumn(label: Text('Partners')),
          DataColumn(label: Text('Status')),
        ];
    }
  }

  List<DataRow> _getRows() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    switch (_selectedReportType) {
      case 'Orders':
        return days.asMap().entries.map((e) {
          final orders = [42, 55, 38, 62, 48, 71, 58][e.key];
          return DataRow(cells: [
            DataCell(Text(e.value)),
            DataCell(Text('$orders')),
            DataCell(Text('${(orders * 0.9).toInt()}')),
            DataCell(Text('${15 + e.key} min')),
          ]);
        }).toList();
      case 'Earnings':
        return days.asMap().entries.map((e) {
          final rev = [4200, 5500, 3800, 6200, 4800, 7100, 5800][e.key];
          return DataRow(cells: [
            DataCell(Text(e.value)),
            DataCell(Text('₹$rev')),
            DataCell(Text('₹${(rev * 0.15).toInt()}')),
            DataCell(Text('₹${(rev * 0.85).toInt()}')),
          ]);
        }).toList();
      case 'Partners':
        return days.asMap().entries.map((e) {
          final online = [78, 82, 71, 85, 76, 90, 80][e.key];
          return DataRow(cells: [
            DataCell(Text(e.value)),
            DataCell(Text('$online')),
            DataCell(Text('${1 + e.key % 3}')),
            DataCell(Text((4.0 + e.key * 0.05).toStringAsFixed(1))),
          ]);
        }).toList();
      default:
        final zones = ['Koramangala', 'HSR Layout', 'Indiranagar', 'Whitefield', 'Jayanagar'];
        return zones.asMap().entries.map((e) {
          return DataRow(cells: [
            DataCell(Text(e.value)),
            DataCell(Text('${120 + e.key * 15}')),
            DataCell(Text('${18 + e.key * 2}')),
            DataCell(Text(e.key < 4 ? 'Active' : 'Inactive')),
          ]);
        }).toList();
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
