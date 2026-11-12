import 'package:flutter/material.dart';

class ProgressHeader extends StatelessWidget {
  const ProgressHeader({
    super.key,
    required this.current,
    required this.total,
    required this.answered,
  });

  final int current;
  final int total;
  final int answered;

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : current / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('PERTANYAAN ${current.toString().padLeft(2, '0')}',
                style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.1)),
            Text('$answered dari $total dijawab',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
        ),
      ],
    );
  }
}
