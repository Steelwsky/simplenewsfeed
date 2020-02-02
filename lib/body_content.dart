import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenewsfeed/news_controller.dart';
import 'package:simplenewsfeed/initial_empty_list.dart';
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
                              key: Key('listKey'),
                              title: Text(
                                i.title,
                                key: Key('titleKey'),
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
                          .toList()));
        });
  }
}
