
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/core/constants/news_category.dart';
import 'package:news_app/data/services/news_api_exception.dart';

import '../models/article.dart';

class NewsApiService {
  final http.Client _client;

  NewsApiService({http.Client? client})
      : _client = client ?? http.Client();

  // Mengambil berita berdasarkan kategori NewsAPI
  Future<List<Article>> fetchTopHeadlines(String category) async {
    return _get('/top-headlines', {
      'country': ApiConstants.country,
      'category': category,
    });
  }

  // Mencari berita berdasarkan keyword
  Future<List<Article>> searchArticles(String query) async {
    return _get('/everything', {
      'q': query,
      'sortBy': 'publishedAt',
      'language': ApiConstants.language,
    });
  }

  // Mengambil berita seputar STEM
  Future<List<Article>> fetchStemArticles() async {
    return searchArticles(
      'science OR technology OR engineering OR mathematics',
    );
  }

  // Mengambil berita berdasarkan topik STEM
  Future<List<Article>> fetchArticlesByTopic(String topic) async {
    return searchArticles(topic);
  }

  // Keyword khusus untuk setiap kategori STEMSpace
  static const Map<StemCategory, List<String>> _stemKeywords = {
    StemCategory.science: [
      'physics',
      'biology',
      'chemistry',
      'astronomy',
      'scientific discovery',
      'scientific research',
      'climate science',
      'genetics',
    ],

    StemCategory.technology: [
      'artificial intelligence',
      'robotics',
      'software',
      'semiconductor',
      'computing',
      'cybersecurity',
      'quantum computing',
      'machine learning',
    ],

    StemCategory.engineering: [
      'engineering',
      'mechanical engineering',
      'civil engineering',
      'electrical engineering',
      'aerospace engineering',
      'structural engineering',
      'biomedical engineering',
      'materials engineering',
    ],

    StemCategory.mathematics: [
      'mathematics',
      'mathematical',
      'algebra',
      'geometry',
      'statistics',
      'calculus',
      'mathematical theorem',
      'mathematical research',
    ],
  };

  // Mengambil berita berdasarkan kategori STEMSpace
  Future<List<Article>> fetchArticlesByStemCategory(
    StemCategory category,
  ) async {
    final keywords = _stemKeywords[category]!;

    final query = keywords
        .map((keyword) => '"$keyword"')
        .join(' OR ');

    final articles = await _get(
      '/everything',
      {
        'q': '($query)',
        'searchIn': 'title,description',
        'sortBy': 'publishedAt',
        'language': ApiConstants.language,
      },
      articleCategory: category,
    );

    // Filter agar berita sesuai dengan kategori yang dipilih
    return articles.where((article) {
      final searchableText = [
        article.title,
        article.description ?? '',
      ].join(' ').toLowerCase();

      return keywords.any(
        (keyword) => searchableText.contains(keyword.toLowerCase()),
      );
    }).toList();
  }

  // Fungsi utama untuk request API
  Future<List<Article>> _get(
    String path,
    Map<String, String> params, {
    StemCategory? articleCategory,
  }) async {
    final apiKey = ApiConstants.apiKey;

    if (apiKey.isEmpty) {
      debugPrint('[STEMSpace] NEWS_API_KEY kosong. Isi API Key di file .env');
      throw NewsApiException.serviceUnavailable;
    }

    final uri = Uri.parse('${ApiConstants.baseUrl}$path').replace(
      queryParameters: {
        ...params,
        'pageSize': '${ApiConstants.pageSize}',
      },
    );

    try {
      final response = await _client
          .get(uri, headers: {'X-Api-Key': apiKey})
          .timeout(ApiConstants.timeout);

      if (response.statusCode != 200) {
        debugPrint(
          '[STEMSpace] HTTP ${response.statusCode}: ${response.body}',
        );
        throw _formStatusCode(response.statusCode);
      }

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final articles = body['articles'] as List<dynamic>? ?? [];

      return articles
          .map(
            (json) => Article.fromJson(
              json as Map<String, dynamic>,
              category: articleCategory,
            ),
          )
          .where((article) => article.isValid)
          .toList();
    } on NewsApiException {
      rethrow;
    } on SocketException {
      throw NewsApiException.offline;
    } on http.ClientException {
      throw NewsApiException.offline;
    } on TimeoutException {
      throw NewsApiException.slowConnection;
    } catch (error) {
      debugPrint('[STEMSpace] Unexpected Error: $error');
      throw NewsApiException.unknown;
    }
  }

  // Mengubah HTTP status code menjadi exception
  NewsApiException _formStatusCode(int code) => switch (code) {
        401 || 403 => NewsApiException.serviceUnavailable,
        429 => NewsApiException.tooManyRequests,
        >= 500 => NewsApiException.serverBusy,
        _ => NewsApiException.unknown,
      };

  void dispose() {
    _client.close();
  }
}