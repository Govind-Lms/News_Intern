import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/article_model.dart';

class DetailsPage extends ConsumerStatefulWidget {
  final Article article;
  const DetailsPage(this.article, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {

  Future<void> _launchUrl() async {
    if (!await launchUrl(widget.article.url as Uri)) {
      throw Exception('Could not launch ${widget.article.url}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              widget.article.title ?? 'title',
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              widget.article.description ?? 'description',
              maxLines: 5,
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'By : ${widget.article.author}',
                  style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'By : ${widget.article.publishedAt}',
                  style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: CachedNetworkImage(
                imageUrl: widget.article.urlToImage ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child:  Icon(Icons.error)),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              widget.article.content ?? 'Content',
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  _launchUrl();
                },
                child: Container(
                  width: 100.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Center(child: Text('Visit Web')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
