import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_riverpod/provider/article_provider.dart';
import 'package:intern_riverpod/service/api_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../model/article_model.dart';

class HealthTab extends ConsumerStatefulWidget {
  const HealthTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HealthTabState();
}

class _HealthTabState extends ConsumerState<HealthTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    ref.read(healthProvider.notifier).getArticles("health");
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final articleResponse = ref.watch(healthProvider);
          if(articleResponse.apiState == ApiState.loading){
            return const Center(child: CircularProgressIndicator());
          }
          else if (articleResponse.apiState == ApiState.success){
            List<Article> articles = articleResponse.data as List<Article>;
            return SmartRefresher(
              onRefresh: _onRefresh,
              header: const ClassicHeader(),
              controller: _refreshController,
              enablePullUp: true,
              onLoading: () {
                ref.read(healthProvider.notifier).getMoreArticles("health");
                _refreshController.loadComplete();
              },
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (BuildContext context, int index) {
                  final article = articles[index];
                  return ListTile(
                    leading: Text('${index + 1}'),
                    title:  Text(article.title ?? 'Empty'),
                    subtitle: Text(article.description ?? "Empty"),
                  );
                },
              ),
            );
          }
          else{
            return const Center(child: Text('Error'),);
          }
        },
      ),
    );
  }
}
