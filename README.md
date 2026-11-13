# Dokumentasi
<img width="1757" height="988" alt="image" src="https://github.com/user-attachments/assets/00250917-5577-4105-b04b-a81a0890e96b" />
<img width="1757" height="930" alt="image" src="https://github.com/user-attachments/assets/4a136b04-fc1d-4fb9-a2c3-7d71f0141fd5" />
<img width="1757" height="933" alt="image" src="https://github.com/user-attachments/assets/3ca019a1-5c62-495f-8b25-e84b980ef88c" />


# Data Mahasiswa

Nama  : Arya Sona Ginting
Nim   : 241401100



# Quiz Nova — Flutter

Aplikasi kuis pilihan ganda dengan:
- Input nama pemain
- Kuis pilihan ganda dengan progres dan navigasi soal
- Hasil akhir berdasarkan nama, skor, persentase, dan jawaban benar
- Light/Dark theme dengan tombol pengubah tema
- Responsive/adaptive layout untuk ponsel, tablet, dan browser
- State kuis disimpan dalam `QuizSession` di atas halaman sehingga progres tetap ada saat berpindah halaman dan perubahan orientasi
- Widget reusable terpisah
- Font kustom menggunakan Google Fonts (`Nunito`)
- Ikon Material dan ilustrasi SVG lokal sebagai aset

## Menjalankan

Pastikan Flutter SDK sudah terpasang.

```bash
flutter pub get
flutter run
```

Untuk browser:

```bash
flutter run -d chrome
```

## Struktur

```text
lib/
  main.dart
  app.dart
  models/question.dart
  state/quiz_session.dart
  screens/home_screen.dart
  screens/quiz_screen.dart
  screens/result_screen.dart
  widgets/primary_button.dart
  widgets/quiz_option.dart
  widgets/progress_header.dart
assets/images/quiz_illustration.svg
```

## GitHub: commit per fitur

Buat repository GitHub kosong, lalu dari folder proyek jalankan:

```bash
git init
git add .
git commit -m "chore: create Flutter quiz project structure"
git branch -M main
git remote add origin https://github.com/USERNAME/REPOSITORY.git
git push -u origin main
```

Lanjutkan commit per fitur, bukan hanya sekali di akhir. Contoh:
```bash
git add lib/models lib/state
git commit -m "feat: add quiz questions and session state"

git add lib/screens/home_screen.dart lib/widgets/primary_button.dart
git commit -m "feat: add player name entry screen"

git add lib/screens/quiz_screen.dart lib/widgets/quiz_option.dart lib/widgets/progress_header.dart
git commit -m "feat: implement multiple choice quiz flow"

git add lib/screens/result_screen.dart
git commit -m "feat: show personalized quiz results"

git add lib/app.dart lib/main.dart
git commit -m "feat: add light and dark theme support"

git add .
git commit -m "style: improve responsive layouts and quiz illustration"
git push
```

Catatan: font Nunito diambil melalui package `google_fonts`. Saat pertama kali dipakai, perangkat/browser memerlukan akses internet untuk mengambil font. Bila perlu sepenuhnya offline, unduh file font Nunito dan daftarkan melalui `fonts:` di `pubspec.yaml`.
