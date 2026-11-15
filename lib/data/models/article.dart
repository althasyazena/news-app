
import 'package:news_app/core/constants/news_category.dart';

// TODO 1: Buat class Article
// 1. Buat class dengan properti: title, sourceName, author, description, url, imageUrl, publishedAt, content
// 2. Buat factory constructor `fromJson(Map<String, dynamic> json)`
// 3. Buat getter `cleanContent` untuk menghapus teks "[+... chars]" dari content
// 4. Buat getter `isValid` untuk memastikan artikel bukan "[Removed]"

class Article {
  // Siswi akan melengkapi bagian ini.
  const Article({
    required this.title,
    required this.sourceName,
    required this.url,
    required this.publishedAt,
    this.author,
    this.description,
    this.imageUrl,
    this.content,
    this.category,
  });

  final String title;
  final String sourceName;
  final String url;
  final DateTime? publishedAt;
  final String? author;
  final String? description;
  final String? imageUrl;
  final String? content;
  final StemCategory? category;

  // TODO: Implementasi cleanContent
  String get cleanContent => (content ?? '').replaceAll(RegExp(r'\s*\[\+\d+ chars\]$'), '').trim();

  // TODO: Implementasi isValid
  bool get isValid => title.isNotEmpty && title != '[Removed]' && url.isNotEmpty;

  // akan dijalankan jika nilai yg diatas tidak terpenuhi, ini sebuah pendukung kalau nilai diatas tidak benar
  @override
  bool operator ==(Object other) => other is Article && other.url == url;

  @override
  int get hashCode => url.hashCode; // mengembalikan nilai objek jadi nilai acak

  // mengubah data JSON dari API menjadi object article, supaya datanya bisa digunakan di flutter
  // Implementasi fromJson. untuk dikonversi menjadi bahasa Dart (bukan raw JSON)
  factory Article.fromJson(
    Map<String, dynamic> json, {
    StemCategory? category,
  }) {
    final source = json['source'] as Map<String, dynamic>?;

    return Article(
      title: json['title'] as String? ?? '',
      sourceName: source?['name'] as String? ?? 'Tanpa Sumber',
      url: json['url'] as String? ?? '',
      publishedAt: DateTime.tryParse(json['publishedAt'] as String? ?? ''),
      author: json['author'] as String?,
      description: json['description'] as String?,
      imageUrl: json['urlToImage'] as String?,
      content: json['content'] as String?,
      category: category,
    );
  }

  // mengubah object artikel menjadi Map/JSON, supaya bisa disimpan atau dikirim kembali
  // Implementasi toJson, untuk verifikasi
  Map<String, dynamic> toJson() => {
    'title': title,
    'source': {'name': sourceName},
    'url': url,
    'publishedAt': publishedAt?.toIso8601String(),
    'author': author,
    'description': description,
    'urlToImage': imageUrl,
    'content': content,
    'category': category?.name,
  };

  // Dummy article untuk UI sementara
  static final dummy = Article(
    title: 'Berita Menarik Hari Ini',
    sourceName: 'Warta News',
    url: 'https://example.com',
    publishedAt: DateTime.now(),
    description: 'Ini adalah deskripsi berita sementara sebelum API disambungkan.',
    imageUrl: 'https://picsum.photos/400/200',
    content: 'Isi konten berita yang lebih panjang akan muncul di sini.',
    category: StemCategory.science,
  );
}