import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController textEditingController;

  CustomDatePicker({required this.textEditingController});

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        widget.textEditingController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: TextField(
        controller: widget.textEditingController,
        readOnly: true,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: ColorConstant.black900Dd,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: ColorConstant.black900Dd,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: ColorConstant.black900Dd,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: ColorConstant.black900Dd,
              width: 1,
            ),
          ),
        ),
        style: TextStyle(
          color: ColorConstant.blueGray400,
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          height: 1.50,
        ),
      ),
    );
  }
}
