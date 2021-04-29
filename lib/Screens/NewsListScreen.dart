import 'package:flutter/material.dart';
import 'package:newsappsunil/Models/NewsModel.dart';
import 'package:newsappsunil/Services/NewsService.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  News _news = News(articles: []);
  bool endOfPage = false;

  @override
  void initState() {
    getArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _renderAppBar(),
      body: renderNewsList(),
    );
  }

  Widget _renderAppBar() {
    return AppBar(
      title: Text("Live News"),
    );
  }

  Widget renderNewsList() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: _news.articles != null && _news.articles.length > 0
          ? Container(
              key: UniqueKey(),
              child: ListView.builder(
                  itemCount: _news.articles != null ? _news.articles.length : 0,
                  itemBuilder: (context, articleIndex) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8,right: 8,left: 8),
                      child: InkWell(
                        onTap: () {
                          openUrl(_news.articles[articleIndex].url);
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      _news.articles[articleIndex].urlToImage != null
                                          ? "https:" +
                                              (_news.articles[articleIndex].urlToImage
                                                  .replaceFirst("https:", ""))
                                          : "https://static.thenounproject.com/png/2884221-200.png",
                                      width: MediaQuery.of(context).size.width * .4,
                                      height: MediaQuery.of(context).size.width * .2,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: Text(
                                              _news.articles[articleIndex].title,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: Text(
                                              getFormattedDateTime(_news
                                                      .articles[articleIndex]
                                                      .publishedAt)
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5,bottom: 5),
                                  child: Text(
                                    _news.articles[articleIndex].description != null
                                        ? _news.articles[articleIndex].description
                                        : "",
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          openUrl(_news.articles[articleIndex].url);
                                        },
                                        child: Text("Click here for more details",style: TextStyle(color: Colors.blue,fontSize: 12),)),
                                    Text(
                                      _news.articles[articleIndex].source != null &&
                                              _news.articles[articleIndex].source
                                                      .name !=
                                                  null
                                          ? _news.articles[articleIndex].source.name
                                          : "",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.amber
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          : Container(
              key: UniqueKey(),
              child: Center(child: CircularProgressIndicator()),
            ),
    );
  }

  getArticles() {
    NewsService.getNews().then((_newsResult) {
      if (_newsResult != null) {
        _news.articles.addAll(_newsResult.articles);
        if (_news.articles == null || _news.articles.length == 0)
          endOfPage = true;
        setState(() {});
      }
    });
  }

  Future<void> openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the link.';
    }
  }

  getFormattedDateTime(DateTime time) {
    return new DateFormat('dd MMM yyyy hh:mm a').format(time);
  }
}
