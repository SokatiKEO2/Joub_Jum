import 'package:flutter/material.dart';
import '../consts.dart';

typedef AsyncCallback = Future<void> Function();

class Confirmation extends StatelessWidget {
  final String text;
  final AsyncCallback? function;

  const Confirmation({
    super.key,
    required this.text,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: boxColor,
      title: Text(
        "Are you sure you want to $text?",
        style: TextStyle(fontFamily: mainFont, fontSize: 20),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  await function!();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2.0,
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2.0,
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
