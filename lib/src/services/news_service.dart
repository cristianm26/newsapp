import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const _urlNews = 'https://newsapi.org/v2';
const _apiKey = '07c8de218a0743178a11eef8fd2f4eca';

class NewsService extends ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  bool _isLoading = true;
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.footballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadLines();
    for (var item in categories) {
      categoryArticles[item.name] = [];
    }
  }

  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String valor) {
    _selectedCategory = valor;
    _isLoading = true;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada =>
      categoryArticles[_selectedCategory];

  getTopHeadLines() async {
    final url = Uri.parse('$_urlNews/top-headlines?apiKey=$_apiKey&country=us');
    final resp = await http.get(url);
    final newsResponse = NewsResponse.fromJson(resp.body);
    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return categoryArticles[category];
    }

    final url = Uri.parse(
        '$_urlNews/top-headlines?apiKey=$_apiKey&country=us&category=$category');
    final resp = await http.get(url);
    final newsResponse = NewsResponse.fromJson(resp.body);
    categoryArticles[category]!.addAll(newsResponse.articles);
    _isLoading = false;
    notifyListeners();
  }
}
