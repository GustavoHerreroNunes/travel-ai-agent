import 'package:flutter/material.dart';
import 'package:travel_ai_agent/features/components/floating_form/default_button.dart';

class FloatingForm extends StatefulWidget {
  const FloatingForm({
    super.key,
    required this.heading,
    this.subHeading,
    required this.textFields,
    required this.formButtons  
  });

  final String heading;
  final String? subHeading;
  final List<TextFormFieldData> textFields;
  final List<FormButtonData> formButtons;

  @override
  State<FloatingForm> createState() => _FloatingFormState();
}

class _FloatingFormState extends State<FloatingForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<Widget> formField = widget.textFields.map((data) => TextFormField(
      decoration: InputDecoration(
        labelText: data.label,
        hintText: data.hint ?? "",
        border: OutlineInputBorder()
      ),
      obscureText: data.isPassword ?? false,
      focusNode: data.focusNode,
      controller: data.controller,
      validator:(value) => data.validator(value)
    )).toList();

    List<Widget> formButtons = widget.formButtons.map((data) => DefaultButton(buttonData: data, formKey: _formKey)).toList();

    return Container( 
      color: Color.fromRGBO(243, 243, 243, 1),
      child: Padding(padding: EdgeInsets.only(top: 70, bottom: 70, left: 25, right: 25), child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.heading, style: 
              TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w600,
              )),
            Text(widget.subHeading ?? ""),
            SizedBox(height: 66),
            Form(
              key: _formKey,
              child: Column(spacing: 17, children: [...formField, ...formButtons])
            )
          ],
        ))
    );
  }
}

class TextFormFieldData{
  const TextFormFieldData({
    required this.label,
    this.hint,
    this.isRequired,
    this.isPassword,
    this.focusNode,
    required this.controller,
    required this.validator
  });
  
  final String label;
  final String? hint;
  final bool? isRequired;
  final bool? isPassword;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String? value) validator;
}
