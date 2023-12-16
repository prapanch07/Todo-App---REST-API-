import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/screens/add_todo_screen.dart';

import 'package:todoapp/utils/colors.dart';
import 'package:todoapp/widgets/list_tile_widget.dart';
import 'package:todoapp/widgets/messages.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List todoList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: redcolor,
          centerTitle: true,
          title: const Text(
            'TodoList',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => _fetchtodo(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) => ListTileWidget(
                index: index,
                heading: todoList[index]['title'],
                description: todoList[index]['description'],
                data: todoList[index],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToAdd(context),
          backgroundColor: redcolor,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }

  void _navigateToAdd(BuildContext context) {
    final route = MaterialPageRoute(
      builder: (context) => const ScreenAddTodo(),
    );
    Navigator.of(context).push(route);
  }

  Future<void> _fetchtodo(BuildContext context) async {
    successMessage(context, 'fetching data from server');
    const String reqUrl = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final Uri uri = Uri.parse(reqUrl);
    final response = await http.get(uri);

    print(response.statusCode);

    if (response.statusCode != 200) {
      errorMessage(context, "some error occured");
    } else {
      final json = jsonDecode(response.body);

      setState(() {
        todoList = json['items'];
      });
    }
  }
}
