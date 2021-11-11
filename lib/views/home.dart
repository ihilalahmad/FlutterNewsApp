import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/helpers/data.dart';
import 'package:flutter_news_app/helpers/news.dart';
import 'package:flutter_news_app/models/article_model.dart';
import 'package:flutter_news_app/models/category_model.dart';
import 'package:flutter_news_app/views/article_view.dart';
import 'package:flutter_news_app/views/category_news.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'News',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'App',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
        child: Container(child: CircularProgressIndicator()),

        ///loading categories
      )
          : SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      imageUrl: categories[index].categoryImageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  },
                ),
              ),

              ///loading articles
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
                        articles[index].url
                    );
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

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;

  CategoryTile({required this.imageUrl, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryNews(categoryName: categoryName.toString().toLowerCase())
        ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black54),
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
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

  PostCard(this.postTitle, this.postImageUrl, this.postDescription,
      this.articleUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ArticleView(
                  articleTitle: postTitle,
                    articleUrl: articleUrl
                ),
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
