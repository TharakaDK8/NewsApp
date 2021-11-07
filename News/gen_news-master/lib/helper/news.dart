import 'dart:convert';

import 'package:gennews/helper/search_keyword.dart';
import 'package:gennews/models/article_model.dart';
import 'package:gennews/models/search_model.dart';
import 'package:http/http.dart' as http;

//Get News
class News {
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=6c5f0713a5914b5eaf56cce290dca709";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content']);

          news.add(articleModel);
        }
      });
    }
  }
}

//Get News By Category
class CategoryNewsClass {
  List<ArticleModel> news = [];
  Future<void> getNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=6c5f0713a5914b5eaf56cce290dca709";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content']);

          news.add(articleModel);
        }
      });
    }
  }
}

//Search News
class SearchList{


  List<dynamic> searchDynamic=[];
  List<SearchModel> searchListFinal = [];
  String _title;
  String _url;
  String _urlToImage;
  String _sourceName;


  Future<List> getSearchList() async {

    var response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q='+keyData.text+'&apiKey=05a6e38c9b5943f7b5849e7e8b954fa2'));
    Map body = await jsonDecode(response.body);
    searchDynamic= body["articles"];
    print(searchDynamic.length);

    for(int i=0;i< searchDynamic.length;i++){
      _title = searchDynamic[i]["title"].toString();
      _url = searchDynamic[i]["url"].toString();
      _urlToImage=searchDynamic[i]["urlToImage"].toString();
      _sourceName = searchDynamic[i]["source"]["name"].toString();
      searchListFinal.add(SearchModel(_title, _url, _urlToImage ,_sourceName ));
    }
    return searchListFinal;
  }




}