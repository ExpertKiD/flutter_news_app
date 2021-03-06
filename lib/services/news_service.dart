import 'package:http/http.dart' as http;
import 'package:news/models/top_articles.dart';

class NewsService {
  NewsService();

  Future<TopArticles?> getNews() async {
    TopArticles? topArticles;

    const url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=7594e288341948a69dc78f8d56a86e20';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        topArticles = TopArticles.fromRawJson(response.body);

        return topArticles;
      } catch (ex, stacktrace) {
        print(ex.toString() + stacktrace.toString());
      }
    }
  }
}
