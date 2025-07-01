import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_error_goalkeeper/item.dart';
import 'package:http/http.dart' as http;

class ItemWidget extends StatelessWidget {
  const ItemWidget(
      {super.key,
      required this.item,
      required this.onRemove});

  final Item item;
  final Function(Item) onRemove;

  Future<void> fetchData() async {
    final url = Uri.parse('https://invalidurl');
    await http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.id),
          Column(
            children: [
              ElevatedButton(
                onPressed: fetchData,
                child: const Text('Execute async error'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => throw Exception('test'),
                child: const Text('Execute sync error'),
              ),
              const SizedBox(
                height: 10,
              ),              
              ElevatedButton(
                onPressed: () => onRemove(item),
                child: const Text('Remove me'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
