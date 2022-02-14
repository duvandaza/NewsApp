import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;


class NewsService with ChangeNotifier {

  final String _UrlNews = 'https://newsapi.org/v2';
  final String _ApiKey = 'ea55f84fa4984a0497f3f27b79999390';

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};


  NewsService(){
    getTopHeadlines();

    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });

  }

  get selectedCategory => _selectedCategory;

  set selectedCategory(valor){
    _selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> ? get getListaArticuloSeleccionado => categoryArticles[selectedCategory];

  getTopHeadlines() async {
    final url =  Uri.parse('$_UrlNews/top-headlines?apiKey=$_ApiKey&country=us');
    final resp = await http.get(url);

    final newsResponse = newResponseFromJson(resp.body);

    headlines.addAll( newsResponse.articles );
    notifyListeners();
  }

  getArticlesByCategory( String category ) async{

    final url =  Uri.parse('$_UrlNews/top-headlines?apiKey=$_ApiKey&country=us&category=$category');
    final resp = await http.get(url);

    final newsResponse = newResponseFromJson(resp.body);

    categoryArticles[category]!.addAll(newsResponse.articles);
    
    notifyListeners();

  }


}