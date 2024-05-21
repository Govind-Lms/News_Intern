import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_riverpod/model/article_model.dart';
import 'package:intern_riverpod/provider/article_provider.dart';
import 'package:intern_riverpod/service/api_service.dart';
import 'package:intern_riverpod/view/onClick/details_page.dart';

class GeneralView extends StatelessWidget {
  const GeneralView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final response = ref.watch(generalProvider);
        if (response.apiState == ApiState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (response.apiState == ApiState.success) {
          final articles = response.data as List<Article>;
          return SizedBox(
            height: 310.0,
            child: Swiper(
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                final article = articles[index];
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DetailsPage(article)));
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          width: MediaQuery.of(context).size.width / 1.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl: articles[index].urlToImage ?? '',
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              errorWidget: (context, url, error) => Image.network(
                                'https://images.unsplash.com/photo-1714905532906-0b9ec1b22dfa?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8',
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                              height: 300.0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 300.0,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        left: 0.0,
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft :  Radius.circular(10.0)),
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width / 1.2 - 10,
                          height: 100.0,
                          decoration:  const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10.0),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(6,0),
                                color: Colors.black12,
                                blurRadius: 6.0,
                              ),
                              BoxShadow(
                                offset: Offset(0,6),
                                color: Colors.black12,
                                blurRadius: 6.0,
                              )
                            ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title ?? '',
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.bold),maxLines: 1,
                              ),
                              Text(
                                article.author ?? '',
                                style: const TextStyle(
                                    fontSize: 14.0, color: Colors.black,fontStyle: FontStyle.italic),maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              layout: SwiperLayout.STACK,
              itemWidth: MediaQuery.of(context).size.width / 1.2,
              itemHeight: 300.0,
            ),
          );
        } else {
          return const Center(
            child: Text("Loading"),
          );
        }
      },
    );
  }
}
