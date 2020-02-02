import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenewsfeed/news_controller.dart';
import 'package:simplenewsfeed/initial_empty_list.dart';
import 'package:simplenewsfeed/selected_news_page.dart';
import 'package:webfeed/webfeed.dart';

class BodyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerController = Provider.of<NewsController>(context);
    return ValueListenableBuilder<RssFeed>(
        valueListenable: providerController.newsState,
        builder: (_, newsBuilder, __) {
          return RefreshIndicator(
              key: Key('refresh'),
              onRefresh: () => providerController.fetchNews(),
              child: providerController.newsState.value.items ==
                      null // newsBuilder.items == null would be wrong coz it's always a null after creation?
                  ? InitialEmptyList()
                  : ListView(
                      children: newsBuilder.items
                          .map(
                            (i) => ListTile(
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
                              trailing: newsController.isNewsInHistory(i)
                                  ? Icon(Icons.bookmark,
                                      size: 24, color: Colors.amber)
                                  : Icon(Icons.bookmark_border,
                                      size: 24, color: Colors.amber),
                              onTap: () {
                                newsController.addNotViewedToHistory(rssFeed
                                    .items[rssFeed.items.indexOf(i)].guid);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => SelectedNewsPage(
                                        item: rssFeed
                                            .items[rssFeed.items.indexOf(i)])));
                              },
                            ),
                          )
                          .toList()));
        });
  }
}
