import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/news_model.dart';
import '../widgets/html_text_view_widget.dart';
import '../widgets/top_bar_image.dart';

class DetailNewsPage extends StatelessWidget {
  /* final News news; */

  const DetailNewsPage({
    Key key,
    /* this.news */
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final News news = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                TopBarImage(size: size),
                Positioned(
                  top: size.height * .07,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  top: size.height * .08,
                  left: size.width * .2,
                  child: Container(
                    width: size.width * .6,
                    alignment: Alignment.center,
                    child: Html(data: news.companyName),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: news.photo != null && news.photo != []
                          ? Image.memory(
                              news.photo,
                              fit: BoxFit.cover,
                            )
                          : Container(),
                    ),
                  ),
                  HtmlText(
                    list: news,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
