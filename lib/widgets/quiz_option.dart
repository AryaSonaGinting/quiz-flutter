import 'package:flutter/material.dart';

class QuizOption extends StatelessWidget {
  const QuizOption({
    super.key,
    required this.label,
    required this.text,
    required this.selected,
    required this.onTap,
    required this.letter,
  });

  final String label;
  final String text;
  final bool selected;
  final VoidCallback onTap;
  final String letter;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: selected
          ? scheme.primary.withValues(alpha: 0.12)
          : Theme.of(context).cardTheme.color,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? scheme.primary : scheme.outlineVariant,
              width: selected ? 1.8 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? scheme.primary : scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  letter,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: selected ? scheme.onPrimary : scheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
              if (selected) Icon(Icons.check_circle_rounded, color: scheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
