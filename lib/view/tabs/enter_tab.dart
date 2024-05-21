import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_riverpod/model/article_model.dart';
import 'package:intern_riverpod/service/api_service.dart';
import 'package:intern_riverpod/view/widget/error_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../provider/article_provider.dart';

class EntertainmentTab extends ConsumerStatefulWidget {
  const EntertainmentTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EntertainmentTabState();
}

class _EntertainmentTabState extends ConsumerState<EntertainmentTab> {
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    ref.read(entertainmentProvider.notifier).getArticles("entertainment");
    _refreshController.refreshCompleted();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            final articleResponse = ref.watch(entertainmentProvider);
            if (articleResponse.apiState == ApiState.loading) {
              return const Center(child: CircularProgressIndicator());
            } 
            else if (articleResponse.apiState == ApiState.success) {
              List<Article> articles = articleResponse.data as List<Article>;
              return SmartRefresher(
                footer: const ClassicFooter(),
                header: const ClassicHeader(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: () {
                  ref
                      .read(entertainmentProvider.notifier)
                      .getMoreArticles("entertainment");
                  _refreshController.loadComplete();
                },
                enablePullUp: true,
                child: ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final article = articles[index];
                    return ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(article.title ?? 'Empty'),
                      subtitle: Text(article.description ?? 'Empty'),
                    );
                  },
                ),
              );
            } 
            else if (articleResponse.apiState == ApiState.error) {
              return  Center(child: ErrorOccur(
                articleProvider: entertainmentProvider,
                category: "entertainment",
                errorState: articleResponse.errorState!,
              ),);
            }
            else{
              return const Center(child: Text("I dont Know"),);
            }
          },
        )
        );
  }
}
