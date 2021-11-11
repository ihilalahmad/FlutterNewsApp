import 'package:flutter/material.dart';
import 'package:flutter_news_app/helpers/news.dart';
import 'package:flutter_news_app/models/article_model.dart';
import 'article_view.dart';

class CategoryNews extends StatefulWidget {
  final String categoryName;

  CategoryNews({required this.categoryName});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.categoryName);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.categoryName,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.share,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(child: CircularProgressIndicator()),

              ///loading categories
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                        itemCount: articles.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return PostCard(
                              articles[index].title,
                              articles[index].urlToImage,
                              articles[index].description,
                              articles[index].url);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String postTitle;
  final String postImageUrl;
  final String postDescription;
  final String articleUrl;

  PostCard(
      this.postTitle, this.postImageUrl, this.postDescription, this.articleUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ArticleView(articleTitle: postTitle, articleUrl: articleUrl),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(postImageUrl),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              postTitle,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              postDescription,
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
