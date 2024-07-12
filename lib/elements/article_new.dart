import "package:flutter/material.dart";
import "package:news_app/screen/description_screen.dart";

class Article extends StatelessWidget {
  const Article({
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
  });

  final String thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Description(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  publishDate: publishDate,
                  thumbnail: thumbnail)),
        )
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: SizedBox(
          height: 96,
          child: Row(
            children: [
              Container(
                  height: 96,
                  width: 96,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(thumbnail, loadingBuilder:
                        (BuildContext context, Widget body,
                            ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return body;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    }),
                  )),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 20,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    child: Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 20,
                          child: Text(
                            author,
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          height: 20,
                          child: Text(
                            '$publishDate',
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
