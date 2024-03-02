import 'package:flutter/material.dart';

class TypeQuantityWidget extends StatelessWidget {
  final int quantity;
  final String type;

  const TypeQuantityWidget(
      {super.key, required this.type, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120.0,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    type,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '$quantity',
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  )
                ])));
  }
}