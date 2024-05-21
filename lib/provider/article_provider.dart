import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_riverpod/model/article_model.dart';
import 'package:intern_riverpod/service/api_service.dart';

final apiProvider = Provider<ApiService>((ref) => ApiService());
List<Article> list = [];
int page = 1;
final businessProvider = StateNotifierProvider<ArticleStateProvider, InfiniteObject>((ref) => ArticleStateProvider("business"));
final healthProvider = StateNotifierProvider<ArticleStateProvider, InfiniteObject>((ref) => ArticleStateProvider("health"));
final techProvider = StateNotifierProvider<ArticleStateProvider, InfiniteObject>((ref) => ArticleStateProvider("technology"));
final entertainmentProvider = StateNotifierProvider<ArticleStateProvider, InfiniteObject>((ref) => ArticleStateProvider("entertainment"));
final generalProvider = StateNotifierProvider<ArticleStateProvider,InfiniteObject>((ref) => ArticleStateProvider("general"));


class ArticleStateProvider extends StateNotifier<InfiniteObject> {
  final String category;
  ArticleStateProvider(this.category) : super(InfiniteObject(ApiState.initial, [])) {
    getArticles(category);
  }

  final _apiService = ApiService();

  List<Article> list = [];
  int page = 1;

  Future<void> getArticles( String category) async {
    page = 1;
    state = InfiniteObject(ApiState.loading, []);
    final response = await _apiService.getData(category, page);
    if (response.apiState == ApiState.success) {
      List jsonBody = response.data['articles'];
      List<Article> articles =
          jsonBody.map((e) => Article.fromJson(e)).toList();
      state = InfiniteObject(ApiState.success, articles);
    } else if(response.apiState == ApiState.initial) {
      state = InfiniteObject(ApiState.initial, []);
    } else if(response.apiState == ApiState.loading) {
      state = InfiniteObject(ApiState.loading, []);
    }
    else {
      state = InfiniteObject(ApiState.error, [], errorState: response.errorState);
    }
  }

Future<void> getMoreArticles(String category) async {
  page++;
  final response = await _apiService.getData(category, page);
  if (response.apiState == ApiState.success) {
    List jsonBody = response.data['articles'];
    List<Article> articles = jsonBody.map((e) => Article.fromJson(e)).toList();
    state = InfiniteObject(ApiState.success, state.data..addAll(articles));
  } else {
    state = InfiniteObject(ApiState.error, [], errorState: response.errorState);
  }
}

}
