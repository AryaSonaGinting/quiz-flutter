import 'package:flutter/material.dart';
import '../state/quiz_session.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_header.dart';
import '../widgets/quiz_option.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.session,
    required this.isDark,
    required this.onToggleTheme,
  });

  final QuizSession session;
  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final QuizSession _session;

  @override
  void initState() {
    super.initState();
    _session = widget.session..addListener(_refresh);
  }

  @override
  void dispose() {
    _session.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  void _finish() {
    if (!_session.allAnswered) {
      final missing = _session.questions.length - _session.answeredCount;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Masih ada $missing pertanyaan yang belum dijawab.')),
      );
      return;
    }
    _session.finish();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          session: _session,
          isDark: widget.isDark,
          onToggleTheme: widget.onToggleTheme,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final wide = size.width >= 760;
    final question = _session.currentQuestion;
    final scheme = Theme.of(context).colorScheme;
    final horizontal = size.width >= 900 ? size.width * .15 : size.width >= 600 ? 48.0 : 20.0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Kembali',
          icon: const Icon(Icons.close_rounded),
          onPressed: () => _showExitDialog(context),
        ),
        title: const Text('KUIS BERLANGSUNG', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
        actions: [
          IconButton(
            tooltip: widget.isDark ? 'Light mode' : 'Dark mode',
            onPressed: widget.onToggleTheme,
            icon: Icon(widget.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(horizontal, 20, horizontal, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProgressHeader(
                  current: _session.currentIndex + 1,
                  total: _session.questions.length,
                  answered: _session.answeredCount,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: scheme.primary.withValues(alpha: .12),
                      foregroundColor: scheme.primary,
                      child: const Icon(Icons.person_rounded),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text('Semangat, ${_session.playerName}!',
                          style: const TextStyle(fontWeight: FontWeight.w800)),
                    ),
                    Chip(label: Text(question.category)),
                  ],
                ),
                const SizedBox(height: 22),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  child: Padding(
                    padding: EdgeInsets.all(wide ? 30 : 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pilih satu jawaban yang paling tepat.',
                            style: TextStyle(color: scheme.onSurfaceVariant)),
                        const SizedBox(height: 12),
                        Text(
                          question.text,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ...List.generate(question.options.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: QuizOption(
                      letter: String.fromCharCode(65 + index),
                      label: 'Pilihan ${index + 1}',
                      text: question.options[index],
                      selected: _session.selectedAnswer == index,
                      onTap: () => _session.selectAnswer(index),
                    ),
                  );
                }),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        label: 'Sebelumnya',
                        icon: Icons.arrow_back_rounded,
                        isOutlined: true,
                        onPressed: _session.currentIndex == 0 ? null : _session.previous,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PrimaryButton(
                        label: _session.currentIndex == _session.questions.length - 1 ? 'Lihat hasil' : 'Berikutnya',
                        icon: _session.currentIndex == _session.questions.length - 1
                            ? Icons.emoji_events_rounded
                            : Icons.arrow_forward_rounded,
                        onPressed: _session.currentIndex == _session.questions.length - 1
                            ? _finish
                            : _session.next,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_session.questions.length, (index) {
                    final answered = _session.answers.containsKey(index);
                    final active = _session.currentIndex == index;
                    return ActionChip(
                      avatar: Icon(
                        answered ? Icons.check_rounded : Icons.circle_outlined,
                        size: 16,
                        color: active ? scheme.onPrimary : scheme.primary,
                      ),
                      label: Text('${index + 1}'),
                      backgroundColor: active
                          ? scheme.primary
                          : answered
                              ? scheme.primary.withValues(alpha: .12)
                              : scheme.surfaceContainerHighest,
                      labelStyle: TextStyle(
                        color: active ? scheme.onPrimary : scheme.onSurface,
                        fontWeight: FontWeight.w800,
                      ),
                      onPressed: () => _session.goToQuestion(index),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showExitDialog(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar dari kuis?'),
        content: const Text('Progres jawabanmu akan tetap tersimpan selama sesi aplikasi ini berjalan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Lanjut kuis'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    if (shouldExit == true && mounted) Navigator.of(context).pop();
  }
}
