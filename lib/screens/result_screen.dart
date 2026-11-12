import 'package:flutter/material.dart';
import '../state/quiz_session.dart';
import '../widgets/primary_button.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.session,
    required this.isDark,
    required this.onToggleTheme,
  });

  final QuizSession session;
  final bool isDark;
  final VoidCallback onToggleTheme;

  String get message {
    final score = session.percentage;
    if (score >= 85) return 'Luar biasa! Kamu menguasai materi.';
    if (score >= 60) return 'Kerja bagus! Terus tingkatkan.';
    return 'Jangan menyerah. Coba lagi dan tingkatkan skormu!';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final wide = size.width >= 700;
    final scheme = Theme.of(context).colorScheme;
    final horizontal = size.width >= 900 ? size.width * .2 : size.width >= 600 ? 48.0 : 22.0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('HASIL KUIS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
        actions: [
          IconButton(
            tooltip: isDark ? 'Light mode' : 'Dark mode',
            onPressed: onToggleTheme,
            icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(horizontal, 20, horizontal, 32),
            child: Column(
              children: [
                Container(
                  width: wide ? 140 : 112,
                  height: wide ? 140 : 112,
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: .12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    session.percentage >= 60 ? Icons.emoji_events_rounded : Icons.flag_rounded,
                    size: wide ? 72 : 56,
                    color: scheme.primary,
                  ),
                ),
                const SizedBox(height: 22),
                Text('Kuis selesai, ${session.playerName}!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                Text(message, textAlign: TextAlign.center,
                    style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 16)),
                const SizedBox(height: 28),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  child: Padding(
                    padding: EdgeInsets.all(wide ? 32 : 22),
                    child: Column(
                      children: [
                        Text('SKOR AKHIR', style: TextStyle(color: scheme.onSurfaceVariant, letterSpacing: 2, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 6),
                        Text('${session.correctCount * 100 ~/ session.questions.length}',
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: scheme.primary,
                            )),
                        Text('dari 100 poin', style: TextStyle(color: scheme.onSurfaceVariant)),
                        const SizedBox(height: 24),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: LinearProgressIndicator(
                            value: session.percentage / 100,
                            minHeight: 10,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(child: _stat(context, Icons.check_circle_rounded, '${session.correctCount}', 'Benar')),
                            Expanded(child: _stat(context, Icons.cancel_rounded, '${session.questions.length - session.correctCount}', 'Salah')),
                            Expanded(child: _stat(context, Icons.quiz_rounded, '${session.questions.length}', 'Total soal')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('REVIEW JAWABAN', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
                        const SizedBox(height: 14),
                        ...List.generate(session.questions.length, (index) {
                          final q = session.questions[index];
                          final answer = session.answers[index];
                          final correct = answer == q.correctIndex;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  correct ? Icons.check_circle_rounded : Icons.cancel_rounded,
                                  color: correct ? Colors.green : scheme.error,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(q.text, style: const TextStyle(fontWeight: FontWeight.w800)),
                                      const SizedBox(height: 4),
                                      Text('Jawaban benar: ${q.options[q.correctIndex]}',
                                          style: TextStyle(color: scheme.onSurfaceVariant)),
                                      const SizedBox(height: 3),
                                      Text(q.explanation, style: Theme.of(context).textTheme.bodySmall),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    label: 'Main lagi',
                    icon: Icons.refresh_rounded,
                    onPressed: () {
                      session.reset();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => HomeScreen(
                            session: session,
                            isDark: isDark,
                            onToggleTheme: onToggleTheme,
                          ),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _stat(BuildContext context, IconData icon, String value, String label) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Icon(icon, color: scheme.primary, size: 25),
        const SizedBox(height: 7),
        Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
