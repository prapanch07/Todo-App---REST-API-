import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/utils/colors.dart';
import 'package:todoapp/widgets/custom_text_field.dart';
import 'package:todoapp/widgets/messages.dart';

class ScreenAddTodo extends StatelessWidget {
  const ScreenAddTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final _titlecontroller = TextEditingController();
    final _descriptioncontroller = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 15,
          ),
          child: ListView(
            children: [
              CustomTextField(
                titlecontroller: _titlecontroller,
                hinttext: 'heading .',
                minLine: 1,
                maxLine: 1,
              ),
              const Gap(10),
              CustomTextField(
                titlecontroller: _descriptioncontroller,
                hinttext: 'Type your content here...',
                minLine: 5,
                maxLine: 50,
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () {
                  // _navigateBack(context);
                  _posttodo(
                    _titlecontroller.text,
                    _descriptioncontroller.text,
                    context,
                  );

                  _descriptioncontroller.text = '';
                  _titlecontroller.text = '';
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    redcolor,
                  ),
                ),
                child: const Text(
                  'submit',
                  style: TextStyle(
                    color: whitecolor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> _posttodo(
      String heading, String description, BuildContext context) async {
    const String reqUrl = 'https://api.nstack.in/v1/todos';

    final reqBody = {
      "title": heading,
      "description": description,
      "is_completed": 'false' 
    };
    final uri = Uri.parse(reqUrl);

    final postReq = await http.post(
      uri,
      body: reqBody,
    );
    if (postReq.statusCode == 201) {
      successMessage(context, 'Success');
    } else if (postReq.statusCode == 400) {
      errorMessage(context, "client side error");
    } else if (postReq.statusCode == 429) {
      errorMessage(context, "too many request wait for a while");
    } else {
      errorMessage(context, 'some error while pushing');
    }
  }
}
