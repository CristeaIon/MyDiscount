import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/entities/news_model.dart';

class HtmlText extends StatelessWidget {
  const HtmlText({
    Key? key,
    required this.list,
  }) : super(key: key);

  final News list;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(right: 5, bottom: 5),
      child: Html(
        /* style: {
          'p': Style(maxLines: 3, textOverflow: TextOverflow.ellipsis),
        }, */
        data: list.content,
        onLinkTap: (url, _, __, ___) async {
          if (await canLaunch(url!)) {
            await launch(url);
          } else {
            throw Exception();
          }
        },
      ),
    );
  }
}