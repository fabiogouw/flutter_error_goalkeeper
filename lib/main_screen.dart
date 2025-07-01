import 'package:flutter/material.dart';
import 'package:flutter_error_goalkeeper/error_goalkeeper.dart';
import 'package:flutter_error_goalkeeper/item.dart';
import 'package:flutter_error_goalkeeper/item_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  final _uuid = const Uuid();
  final List<Item> _items = [];

  void _addItem() {
    setState(() {
      _items.add(Item(id: _uuid.v4().toString()));
    });
  }

  void _forceError() async {
    final url = Uri.parse('https://invalidurl');
    await http.get(url);
  }

  void _removeItem(Item item) {
    setState(() {
      _items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: _items.length,
      itemBuilder: (ctx, index) {
        return ErrorGoalkeeper(
          scope: _items[index].id,
          child: ItemWidget(
            item: _items[index],
            onRemove: _removeItem,
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: _forceError,
            icon: const Icon(Icons.car_crash_sharp),
          ),
        ],
      ),
      body: content,
    );
  }
}
