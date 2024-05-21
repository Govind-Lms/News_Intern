import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_riverpod/model/article_model.dart';
import 'package:intern_riverpod/provider/article_provider.dart';
import 'package:intern_riverpod/service/api_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TechTab extends ConsumerStatefulWidget {
  const TechTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TechTabState();
}

class _TechTabState extends ConsumerState<TechTab> {


  final RefreshController _refreshIndicator = RefreshController(initialRefresh: false);
  void _onRefresh() async{
    await Future.delayed(const Duration (seconds: 1));
    ref.read(techProvider.notifier).getArticles("technology");
    _refreshIndicator.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final response = ref.watch(techProvider);
          if(response.apiState == ApiState.loading){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if (response.apiState == ApiState.success){
            final articles = response.data as List<Article>;
            return SmartRefresher(
              controller: _refreshIndicator,
              onRefresh: _onRefresh,
              header: const ClassicHeader(),
              onLoading: (){
                ref.read(techProvider.notifier).getMoreArticles("technology");
                _refreshIndicator.loadComplete();
              },
              enablePullUp: true,
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (BuildContext context, int index) {
                  final article = articles[index];
                  return ListTile(
                    leading: Text('${index+1}'),
                    title: Text(article.title ?? ''),
                    subtitle: Text(article.description ?? ''),
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