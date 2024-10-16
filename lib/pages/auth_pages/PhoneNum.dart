import 'package:flutter/material.dart';

class PhoneNum extends StatefulWidget {
  const PhoneNum({super.key});

  @override
  State<PhoneNum> createState() => _PhoneNumState();
}

class _PhoneNumState extends State<PhoneNum> {
  String selectedValue = '+855'; // Default country code
  List<String> dropDownCountryNums = ['+855', '+1', '+44', '+65', '+66']; // List of country codes

  List<DropdownMenuItem<String>> getDropdownMenuItems() {
    // Create a list of items with the selected value at the top
    List<String> sortedItems = [selectedValue];
    sortedItems.addAll(dropDownCountryNums.where((code) => code != selectedValue));

    return sortedItems.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  void _clickedButton() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 100.0,
          ),
          Text(
            'Phone Number',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600),
          ),
          Container(
            margin: EdgeInsets.only(top: 40, left: 25, right: 25),
            child: TextField(
              keyboardType: TextInputType.phone, // Phone keyboard
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(13),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
                prefixIcon: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items:
                        getDropdownMenuItems(), // Use the custom list with selected item at top
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          ElevatedButton(
              onPressed: _clickedButton,
              child: Icon(Icons.arrow_forward, color: Colors.black,),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              ),
          )
        ],
      ),
    );
  }
}
