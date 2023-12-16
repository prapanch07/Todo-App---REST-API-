import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:http/http.dart' as http;
import 'package:todoapp/utils/colors.dart';
import 'package:todoapp/widgets/custom_decoration_box.dart';
import 'package:todoapp/widgets/custom_text_field.dart';
import 'package:todoapp/widgets/messages.dart';

class ListTileWidget extends StatefulWidget {
  final index;
  final String heading;
  final String description;
  final data;
  const ListTileWidget({
    super.key,
    required this.index,
    required this.heading,
    required this.description,
    required this.data,
  });

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  final _uHeadingcontroller = TextEditingController();
  final _uDescriptioncontroller = TextEditingController();

  String? date;
  bool iscompleted = false;

  @override
  void initState() {
    date = setDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      secondaryBackground: const CustomDecorationBox(
        color: redcolor,
        icon: Icons.delete,
        align: MainAxisAlignment.end,
      ),
      background: const CustomDecorationBox(
        color: greencolor,
        icon: Icons.update,
        align: MainAxisAlignment.start,
      ),
      key: UniqueKey(),
      onDismissed: (dismissdirection) {
        if (dismissdirection == DismissDirection.startToEnd) {
          showdialoq();
        }
        if (dismissdirection == DismissDirection.endToStart) {
          deletetodo(widget.data['_id']);
        }
      },
      child: ListTile(
        leading: Column(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: redcolor,
              child: Text('${widget.index + 1}'),
            ),
            const Gap(5),
            Text(date!),
          ],
        ),
        title: Text(
          widget.heading,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            decoration: widget.data['is_completed']
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationColor: strikecolor,
            decorationThickness: 2,
            decorationStyle: TextDecorationStyle.solid,
          ),
        ),
        subtitle: Text(
          widget.description,
          style: TextStyle(
            fontSize: 17,
            decoration: widget.data['is_completed']
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationColor: strikecolor,
            decorationThickness: 2,
            decorationStyle: TextDecorationStyle.solid,
          ),
        ),
        trailing: Checkbox(
          value: widget.data['is_completed'],
          onChanged: (completed) {
            setState(() {
              widget.data['is_completed'] = completed;
              iscompleted = completed!;
            });
            updateCheckbox(
              widget.data['_id'],
              widget.data['title'],
              widget.data['description'],
            );
          },
        ),
      ),
    );
  }

  void deletetodo(String id) async {
    const requrl = "https://api.nstack.in/v1/todos/";
    String endpoint = id;

    final url = requrl + endpoint;

    final uri = Uri.parse(url);

    final respons = await http.delete(uri);

    if (respons.statusCode != 200) {
      errorMessage(context, 'some error occured while deleteing');
    }
    successMessage(context, 'deleted');
  }

  void showdialoq() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: const Text(
            'Update TODO',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            children: [
              CustomTextField(
                titlecontroller: _uHeadingcontroller,
                hinttext: 'title',
                minLine: 1,
                maxLine: 1,
              ),
              const Gap(10),
              CustomTextField(
                titlecontroller: _uDescriptioncontroller,
                hinttext: 'description',
                minLine: 3,
                maxLine: 10,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                updatetodo(widget.data['_id']);

                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void updatetodo(String id) async {
    const requrl = 'https://api.nstack.in/v1/todos/';
    String endpoint = id;
    final ubody = {
      "title": _uHeadingcontroller.text,
      "description": _uDescriptioncontroller.text,
      "is_completed": 'false'
    };

    final url = requrl + endpoint;
    final uri = Uri.parse(url);
    await http.put(
      uri,
      body: ubody,
    );
  }

  void updateCheckbox(String id, String heading, String description) async {
    const requrl = 'https://api.nstack.in/v1/todos/';
    String endpoint = id;

    final ubody = {
      "title": heading,
      "description": description,
      "is_completed": iscompleted.toString()
    };
    final url = requrl + endpoint;
    final uri = Uri.parse(url);
    await http.put(
      uri,
      body: ubody,
    );
  }

  String setDate() {
    final d = widget.data['created_at'].toString();

    final date = d.split('T');

    return date[0];
  }
}
