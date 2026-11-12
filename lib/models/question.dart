class QuizQuestion {
  const QuizQuestion({
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.category,
    required this.explanation,
  });

  final String text;
  final List<String> options;
  final int correctIndex;
  final String category;
  final String explanation;
}

const List<QuizQuestion> sampleQuestions = [
  QuizQuestion(
    category: 'Flutter',
    text: 'Widget manakah yang cocok untuk UI yang tidak menyimpan state internal?',
    options: ['StatefulWidget', 'StatelessWidget', 'InheritedModel', 'FutureBuilder'],
    correctIndex: 1,
    explanation: 'StatelessWidget cocok ketika tampilan tidak perlu mengelola state yang berubah.',
  ),
  QuizQuestion(
    category: 'Dart',
    text: 'Kata kunci untuk membuat variabel yang nilainya ditetapkan sekali adalah ...',
    options: ['var', 'dynamic', 'final', 'late var'],
    correctIndex: 2,
    explanation: 'Variabel final hanya dapat diberi nilai satu kali.',
  ),
  QuizQuestion(
    category: 'Flutter',
    text: 'Widget yang umum digunakan untuk menyusun elemen secara vertikal adalah ...',
    options: ['Row', 'Stack', 'Column', 'Wrap'],
    correctIndex: 2,
    explanation: 'Column menempatkan child dari atas ke bawah.',
  ),
  QuizQuestion(
    category: 'Dasar UI',
    text: 'Apa kegunaan utama dari Navigator di Flutter?',
    options: [
      'Mengubah warna aplikasi',
      'Mengatur perpindahan halaman',
      'Menyimpan gambar',
      'Mengompilasi kode Dart',
    ],
    correctIndex: 1,
    explanation: 'Navigator mengelola stack route dan perpindahan antarhalaman.',
  ),
  QuizQuestion(
    category: 'Dart',
    text: 'Tipe data yang mewakili nilai benar atau salah adalah ...',
    options: ['String', 'int', 'bool', 'double'],
    correctIndex: 2,
    explanation: 'bool hanya memiliki nilai true atau false.',
  ),
  QuizQuestion(
    category: 'Flutter',
    text: 'Properti yang mengatur jarak di dalam sebuah Container adalah ...',
    options: ['margin', 'padding', 'alignment', 'decoration'],
    correctIndex: 1,
    explanation: 'Padding memberi jarak di antara batas widget dan child-nya.',
  ),
];
