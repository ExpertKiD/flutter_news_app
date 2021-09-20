import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news/models/top_articles.dart';
import 'package:news/services/news_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    ;
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Sizes: (${MediaQuery.of(context).size.width},${MediaQuery.of(context).size.height}) ');

    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blue.shade600,
        child: FutureBuilder<TopArticles?>(
          future: NewsService().getNews(),
          builder: (context, snapshot) {
            TopArticles? topArticles;
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                print(snapshot.data);

                if (snapshot.hasData) {
                  topArticles = snapshot.data;

                  if (topArticles != null) {
                    return SizedBox(
                      height: 400,
                      child: ListView.builder(
                          padding: EdgeInsets.only(left: 8),
                          itemCount: topArticles.articles.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              //padding: EdgeInsets.only(left: 16),
                              margin: EdgeInsets.only(right: 16),
                              width: MediaQuery.of(context).size.width - 16,
                              color: Colors.green.shade600,
                              child: (Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  //Text(topArticles!.articles[index].title),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 240,
                                      child: Image.network(
                                        (topArticles == null ||
                                                topArticles.articles[index]
                                                        .urlToImage ==
                                                    null)
                                            ? 'https://www.pixsy.com/wp-content/uploads/2021/04/ben-sweet-2LowviVHZ-E-unsplash-1.jpeg'
                                            : topArticles
                                                .articles[index].urlToImage
                                                .toString(),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 350,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            );
                          }),
                    );
                  } else {
                    return Text('No data');
                  }
                } else {
                  return Text('Nothing to show');
                }

              case ConnectionState.waiting:
                return Text('Waiting');

              case ConnectionState.active:
                return Text('Active');

              default:
                return Text('Default');
            }
          },
        ),
      ),
    );
  }
}
