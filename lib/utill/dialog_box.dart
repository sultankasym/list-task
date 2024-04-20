
import 'package:flutter/material.dart';

import 'my_botton.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback OnSave;
  VoidCallback OnCancel;
  DialogBox(
      {super.key,
      this.controller,
      required this.OnSave,
      required this.OnCancel}
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: SizedBox(
        height: 200,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Write your task',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyBotton(
                  text: 'Save',
                  onPressed: OnSave,
                ),
                const SizedBox(
                  width: 10,
                ),
                MyBotton(
                  text: 'Cancel',
                  onPressed: OnCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
