import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenewsfeed/news_controller.dart';
import 'package:simplenewsfeed/news_list.dart';
import 'package:webfeed/webfeed.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerController = Provider.of<NewsController>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('NewsFeed'),
        ),
        body: ValueListenableBuilder<RssFeed>(
            valueListenable: providerController.newsState,
            builder: (context, newsBuilder, _) {
              return RefreshIndicator(
                  key: Key('refresh'),
                  onRefresh: () => NewsController().fetchNews(),
                  child: newsBuilder.items == null
                      ? StarterEmptyList()
                      : ListView(
                          children: newsBuilder.items
                              .map(
                                (i) => ListTile(
                                  key: PageStorageKey(i.guid),
                                  title: Text(
                                    i.title,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    i.description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  onTap: () {},
                                ),
                              )
                              .toList(),
                        )
              );
            }
            )
    );
  }
}
