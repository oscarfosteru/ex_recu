import 'package:flutter/material.dart';

class ContentColumn extends StatelessWidget {
  final String description;
  final double price;
  
  const ContentColumn({
    super.key,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(description),
          Text('Price: \$${price.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
