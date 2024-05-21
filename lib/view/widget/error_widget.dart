import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_riverpod/provider/article_provider.dart';
import 'package:intern_riverpod/service/api_service.dart';

class ErrorOccur extends ConsumerWidget {
  final ErrorState? errorState;
  final String category;
  final StateNotifierProvider<ArticleStateProvider, InfiniteObject> articleProvider;

  const ErrorOccur({super.key, required this.errorState,required this.category, required this.articleProvider});

  @override
  Widget build(BuildContext context,ref) {
    debugPrint("Debug Print : ${errorState.toString()}");
    if(errorState == ErrorState.notFound) {
      return  Scaffold(
        body:const Center(child: Text('Page Not Found'),),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            ref.read(articleProvider.notifier).getArticles(category);
          },
          child:const Icon(Icons.refresh),
        ),
      );
    }
    else if (errorState == ErrorState.badRequest){
      return const Scaffold(
        body:  Center(child: Text('Bad Requests'),),
      );
    }
    else if (errorState == ErrorState.tooManyReq){
      return const Scaffold(
        body: Center(child: Text('Too Many Requests'),),
      );
    }
    else if (errorState == ErrorState.networkError){
      return const Scaffold(
        body: Center(child: Text('Network Error'),),
      );
    }
    else if (errorState == ErrorState.serverError){
      return  Scaffold(
        body: const Center(child: Text('Server error'),),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            ref.read(articleProvider.notifier).getArticles(category);
          },
          child:const Icon(Icons.refresh),
        ),
      );
    }
    else {
      return  Scaffold(
        body: const Center(child: Text('Unknown error'),),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            ref.read(articleProvider.notifier).getArticles(category);
          },
          child:const Icon(Icons.refresh),
        ),
      );
    }
    // else{
    //   return  const Scaffold(
    //     body:Center(child: CircularProgressIndicator(),),
    //   );
    // }
  }
}