import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../state/quiz_session.dart';
import '../widgets/primary_button.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.session,
    required this.isDark,
    required this.onToggleTheme,
  });

  final QuizSession session;
  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (!_formKey.currentState!.validate()) return;
    widget.session.start(_nameController.text);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => QuizScreen(
          session: widget.session,
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
    final horizontal = size.width >= 900 ? size.width * .12 : size.width >= 600 ? 48.0 : 24.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QUIZ NOVA', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2)),
        actions: [
          IconButton(
            tooltip: widget.isDark ? 'Aktifkan light mode' : 'Aktifkan dark mode',
            onPressed: widget.onToggleTheme,
            icon: Icon(widget.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(horizontal, 20, horizontal, 32),
            child: wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: _hero(context)),
                      const SizedBox(width: 36),
                      Expanded(child: _formCard(context)),
                    ],
                  )
                : Column(
                    children: [
                      _hero(context),
                      const SizedBox(height: 20),
                      _formCard(context),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _hero(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Text('✦  CHALLENGE YOURSELF',
              style: TextStyle(color: scheme.primary, fontWeight: FontWeight.w900, letterSpacing: 1)),
        ),
        const SizedBox(height: 18),
        Text(
          'Uji wawasanmu.\nRaih skor terbaik.',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w900,
            height: 1.08,
            letterSpacing: -1.2,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Kuis singkat seputar Dart dan Flutter. Jawab setiap pertanyaan, lihat hasilmu, dan tantang dirimu untuk jadi lebih baik.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
        const SizedBox(height: 24),
        Center(
          child: SvgPicture.asset(
            'assets/images/quiz_illustration.svg',
            height: MediaQuery.sizeOf(context).width >= 760 ? 220 : 180,
            fit: BoxFit.contain,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(Icons.bolt_rounded, color: scheme.primary, size: 30),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('6 pertanyaan seru', style: TextStyle(fontWeight: FontWeight.w900)),
                    SizedBox(height: 3),
                    Text('Pilih jawaban terbaik dan kumpulkan poin.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _formCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(Icons.person_rounded, color: scheme.primary, size: 28),
              ),
              const SizedBox(height: 18),
              Text('Siapa namamu?', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text('Masukkan nama untuk memulai sesi kuis.', style: TextStyle(color: scheme.onSurfaceVariant)),
              const SizedBox(height: 22),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _startQuiz(),
                decoration: InputDecoration(
                  labelText: 'Nama pemain',
                  hintText: 'Contoh: Arya',
                  prefixIcon: const Icon(Icons.badge_outlined),
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Nama tidak boleh kosong.';
                  if (value.trim().length < 2) return 'Masukkan minimal 2 karakter.';
                  return null;
                },
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: 'Mulai kuis',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: _startQuiz,
                ),
              ),
              const SizedBox(height: 14),
              Center(
                child: Text('Tanpa akun • Gratis • 5–7 menit',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
