import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intern_riverpod/model/article_model.dart';

class NewsCard extends StatelessWidget {
  final VoidCallback onTap;
  final Article article;
  const NewsCard(
      {super.key,
      required this.onTap,
      required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              // boxShadow: [
              //   BoxShadow(
              //     offset: Offset(3, 3),
              //     color: Colors.black12,
              //     blurRadius: 6.0,
              //   )
              // ]),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 10.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Hero(
                        tag: article.title ?? 'title',
                        child: CachedNetworkImage(
                          imageUrl: article.urlToImage ?? 'urlToImage',
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Placeholder(),
                          errorWidget: (context, url, error) =>
                              const Placeholder(),
                        ),),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width/ 1.8,

                        child: Text(
                          '${article.title}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: Text(
                          article.author ?? 'author',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 1.0,
          color: Colors.grey,
        )
      ],
    );
  }
}
