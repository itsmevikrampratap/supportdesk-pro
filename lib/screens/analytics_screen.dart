import 'package:flutter/material.dart';
import '../widgets/custom_charts.dart';
import '../widgets/metric_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Operations Analytics Hub")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Corporate Performance Insights", style: theme.textTheme.headlineMedium),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                int count = constraints.maxWidth < 600 ? 1 : 3;
                return GridView.count(
                  crossAxisCount: count,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.6,
                  children: const [
                    MetricCard(
                      title: "Mean Time to Resolve (MTTR)",
                      value: "2.4 hrs",
                      icon: Icons.timer_outlined,
                      color: Colors.green,
                      trend: "-12.5%",
                      isTrendPositive: false,
                    ),
                    MetricCard(
                      title: "SLA Compliant Ratio",
                      value: "97.4%",
                      icon: Icons.verified_user_outlined,
                      color: Colors.blue,
                      trend: "+1.2%",
                      isTrendPositive: true,
                    ),
                    MetricCard(
                      title: "First Contact Resolution",
                      value: "68.2%",
                      icon: Icons.flash_on,
                      color: Colors.orange,
                      trend: "+4.1%",
                      isTrendPositive: true,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: TicketTrendChart()),
                const SizedBox(width: 16),
                if (MediaQuery.of(context).size.width > 800)
                  const Expanded(child: ResolutionDistributionChart()),
              ],
            )
          ],
        ),
      ),
    );
  }
}