import 'package:coinwise/widget/drawer_content_page.dart';
import 'package:flutter/material.dart';
import 'package:coinwise/pages/api/news_api.dart';
import 'package:coinwise/pages/models/article.dart';
import 'package:coinwise/pages/berita/news_article.dart';
import 'package:intl/intl.dart';

import '../api/news_repository.dart';

class NewsPage extends StatelessWidget {
  NewsPage({Key? key}) : super(key: key);

  final api = NewsApi();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBF3),
        appBar: AppBar(
          title: const Text(
            'CoinWise',
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: IconButton(
              icon: Image.asset('assets/images/icon_menu.png'),
              onPressed: () {
                // Menggunakan GlobalKey untuk membuka drawer
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: const Color(0xFF023E8A),
            tabs: [
              tabDetail(context, 'Umum'),
              tabDetail(context, 'Kesehatan'),
              tabDetail(context, 'Teknologi'),
              tabDetail(context, 'Sains'),
              tabDetail(context, 'Berita Utama'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FetchNews(future: api.fetchCategory(Category.general)),
            FetchNews(future: api.fetchCategory(Category.health)),
            FetchNews(future: api.fetchCategory(Category.technology)),
            FetchNews(future: api.fetchCategory(Category.science)),
            FetchNews(future: api.fetchAllNews()),
          ],
        ),
        key: _scaffoldKey,
        drawer: DrawerContentPage(),
      ),
    );
  }

  Tab tabDetail(BuildContext context, String text) {
    return Tab(
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class FetchNews extends StatelessWidget {
  const FetchNews({super.key, required this.future});
  final Future<List<Article>> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final news = snapshot.data;
            return Scaffold(
              backgroundColor: const Color(0xffE5EBF3),
              body: ListView.builder(
                  itemCount: news!.length,
                  itemBuilder: (context, index) {
                    final article = news[index];
                    final dateTime = DateTime.parse(article.publishedAt);
                    final formattedDate = DateFormat('yMMMd').format(dateTime);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ArticlePage(article: news[index]),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              ImageContainer(
                                width: 120,
                                height: 120,
                                margin: const EdgeInsets.all(10.0),
                                borderRadius: 5,
                                imageUrl: news[index].urlToImage,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      news[index].title,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.web,
                                          size: 18,
                                          color: Color(0xFF023E8A),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          news[index].source.name,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF023E8A),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 20),
                                        const Icon(Icons.calendar_today,
                                            size: 18),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            formattedDate,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
        });
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
    this.height = 128,
    this.borderRadius = 24,
    required this.width,
    required this.imageUrl,
    this.margin,
    this.child,
  }) : super(key: key);

  final double width;
  final double height;
  final String imageUrl;
  final EdgeInsets? margin;
  final double borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
