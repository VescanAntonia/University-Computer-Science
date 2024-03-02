import 'package:flutter/material.dart';
import 'package:library_managment_app/data_access/models/book.dart';

class BookInfoWidget extends StatelessWidget {
  final VoidCallback? onDelete;
  final Book book;
  //final bool isDeleteEnabled;

  const BookInfoWidget(
      {Key? key,
        required this.book,
        this.onDelete,
        //this.isDeleteEnabled = false
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title: ${book.title}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Author: ${book.author}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Genre: ${book.genre}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),

                  ],
                ),
                // if (isDeleteEnabled)
                //   IconButton(
                //     icon: const Icon(Icons.delete),
                //     onPressed: () async {
                //       onDelete!();
                //     },
                //   ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}