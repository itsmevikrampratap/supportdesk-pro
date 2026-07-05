import 'package:flutter/material.dart';

class TicketTrendChart extends StatelessWidget {
  const TicketTrendChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    final ticketCounts = [15, 22, 28, 19, 32, 12, 9];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        border: Border.all(color: theme.colorScheme.onSurface.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ticket Incoming Trend (Weekly)", style: theme.textTheme.titleLarge),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(days.length, (idx) {
                final normalizedHeight = (ticketCounts[idx] / 35) * 160;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("${ticketCounts[idx]}", style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11)),
                    const SizedBox(height: 4),
                    Container(
                      width: 32,
                      height: normalizedHeight,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(idx == 4 ? 0.9 : 0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(days[idx], style: theme.textTheme.bodyMedium),
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

extension on ShapeBorder? {
  apply({required BorderSide side}) {}
}

class ResolutionDistributionChart extends StatelessWidget {
  const ResolutionDistributionChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = [
      {"label": "Resolved First Call", "value": 45, "color": Colors.green},
      {"label": "Under SLA Duration", "value": 35, "color": Colors.blue},
      {"label": "SLA Expired", "value": 15, "color": Colors.red},
      {"label": "Escalated Outward", "value": 5, "color": Colors.amber},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        border: Border.all(color: theme.colorScheme.onSurface.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Resolution Performance Breakdown", style: theme.textTheme.titleLarge),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 140,
                  child: CustomPaint(
                    painter: DistributionPiePainter(data: data),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.map((d) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Container(width: 12, height: 12, color: d['color'] as Color),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "${d['label']} (${d['value']}%)",
                              style: theme.textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class DistributionPiePainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  DistributionPiePainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24;

    final rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 3.2);
    double startAngle = -3.14 / 2;

    for (var element in data) {
      final sweepAngle = ((element['value'] as int) / 100) * 2 * 3.14159;
      paint.color = element['color'] as Color;
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}