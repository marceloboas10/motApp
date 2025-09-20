import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({
    super.key,
    required this.nameLabel,
    required this.nameField,
    this.hintText,
    this.maxLine,
    this.keyboardType,
    required this.inputFormatter,
    this.message,
    this.onChange,
    this.onTap,
    this.readOnly = false,
  });

  final String nameLabel;
  final TextEditingController nameField;
  final int? maxLine;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputFormatter inputFormatter;
  final String? message;
  final ValueChanged<String>? onChange;
  final VoidCallback? onTap;
  final bool? readOnly;

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
            readOnly: readOnly!,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.black,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return message;
              }
              return null;
            },
            controller: nameField,
            maxLines: maxLine,

            style: TextStyle(color: Colors.black, fontSize: 18),
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xffe2e8f0)),
              ),
              errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: LightColors.iconColorGreen),
              ),
              labelStyle: TextStyle(color: Colors.black, fontSize: 16),
            ),
            keyboardType: keyboardType,
            onChanged: onChange,
            onTap: onTap,
            inputFormatters: [inputFormatter],
          ),
        ),
      ],
    );
  }
}
