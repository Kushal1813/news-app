import "package:flutter/material.dart";

class Description extends StatelessWidget {
  const Description({
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.thumbnail,
  });

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String thumbnail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: const IconThemeData.fallback(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(thumbnail, loadingBuilder: (BuildContext context,
              Widget body, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return body;
            }
            return Center(
                child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ));
          }),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '$title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: Text(
                  '$author',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              ),
              Container(
                child: Text(
                  '$publishDate',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '$subtitle',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
