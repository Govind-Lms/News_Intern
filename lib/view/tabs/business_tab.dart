import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_riverpod/model/article_model.dart';
import 'package:intern_riverpod/service/api_service.dart';
import 'package:intern_riverpod/view/widget/error_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../provider/article_provider.dart';
import '../../view/onClick/details_page.dart';

class BusinessTab extends ConsumerStatefulWidget {
  const BusinessTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BusinessTabState();
}

class _BusinessTabState extends ConsumerState<BusinessTab> {
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    ref.read(businessProvider.notifier).getArticles("businesss");
    _refreshController.refreshCompleted();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(
      builder: (context, ref, child) {
        final articleResponse = ref.watch(businessProvider);
        debugPrint("Api State = ${articleResponse.apiState} ");
        debugPrint("Error State = ${articleResponse.errorState} ");

        if (articleResponse.apiState == ApiState.loading) {
          return const Center(child: CircularProgressIndicator(),);
        }
        else if (articleResponse.apiState == ApiState.success) {
          List<Article> articles = articleResponse.data as List<Article>;
          return SmartRefresher(
              footer: const ClassicFooter(),
              header: const ClassicHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: () {
                ref.read(businessProvider.notifier).getMoreArticles("business");
                _refreshController.loadComplete();
              },
              enablePullUp: true,
              child: articles.isNotEmpty
                  ? ListView.builder(
                      itemCount: articles.length ,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final article = articles[index];
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => DetailsPage(article)));
                          },
                          leading: Text('${index + 1}'),
                          title: Text(article.title ?? 'Empty'),
                          subtitle: Text(article.description ?? 'Empty'),
                        );
                      },
                    )
                  : ErrorOccur(errorState: ErrorState.notFound, category: "business", articleProvider: businessProvider));
        } else if (articleResponse.apiState == ApiState.error) {
          return ErrorOccur(
            articleProvider: businessProvider,
            category: "business",
            errorState: articleResponse.errorState,
          );
        } else if (articleResponse.apiState == ApiState.initial) {
          return const Center(
            child: Text("Initial"),
          );
        } else {
          return const Center(
            child: Text('Business Tab Error'),
          );
        }
      },
    ));
  }
}
