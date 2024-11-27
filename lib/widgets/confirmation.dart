import 'package:flutter/material.dart';
import '../consts.dart';

class Confirmation extends StatelessWidget {
  final String text;
  final ElevatedButton button;

  const Confirmation({
    super.key,
    required this.text,
    required this.button,
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
              child: button,
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
