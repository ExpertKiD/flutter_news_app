import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news/models/top_articles.dart';
import 'package:news/services/news_service.dart';
import 'package:shimmer/shimmer.dart';

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
      bottomSheet: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.expand),
              label: 'One',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.expand),
              label: 'One',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.expand),
              label: 'One',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.expand),
              label: 'One',
            ),
          ]),
      body: SafeArea(
        child: Container(
          // color: Colors.blue.shade600,
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
                        height: 300,
                        child: ListView.builder(
                            padding: EdgeInsets.only(left: 8),
                            itemCount: topArticles.articles.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                //padding: EdgeInsets.only(left: 16),
                                margin: EdgeInsets.only(right: 16),
                                width: MediaQuery.of(context).size.width - 16,
                                // color: Colors.green.shade600,
                                child: (Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    //Text(topArticles!.articles[index].title),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                    Container(
                                      margin: EdgeInsets.only(top: 12),
                                      child: Text(
                                        topArticles!.articles[index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    )
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
                case ConnectionState.active:
                  return SizedBox(
                    width: double.infinity,
                    height: 300.0,
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: Container(
                          color: Colors.red,
                        )),
                  );

                default:
                  return Text('Default');
              }
            },
          ),
        ),
      ),
    );
  }
}
