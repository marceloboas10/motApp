import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({
    super.key,
    required this.nameLabel,
    required this.nameField,
    this.maxLengthCaracter,
    this.keyboardType,
  required  this.inputFormatter,
    this.message,
    this.onChange,
  });

  final String nameLabel;
  final TextEditingController nameField;
  final int? maxLengthCaracter;
  final TextInputType? keyboardType;
  final TextInputFormatter inputFormatter;
  final String? message;
  final ValueChanged<String>? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(nameLabel),
        SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            cursorColor: Colors.black,
            maxLength: maxLengthCaracter,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return message;
              }
              return null;
            },
            controller: nameField,
            style: TextStyle(color: Colors.black, fontSize: 18),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xffe2e8f0)),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: LightColors.iconColorGreen),
              ),
              labelStyle: TextStyle(color: Colors.black, fontSize: 16),
            ),
            keyboardType: keyboardType,
            onChanged: onChange,
            inputFormatters: [inputFormatter],
          ),
        ),
      ],
    );
  }
}
