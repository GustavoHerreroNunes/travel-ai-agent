import 'package:flutter/material.dart';
import 'package:travel_ai_agent/features/components/floating_form/default_button.dart';
import 'package:travel_ai_agent/tools/breakpoints.dart';

class FloatingForm extends StatefulWidget {
  const FloatingForm({
    super.key,
    required this.heading,
    this.subHeading,
    required this.textFields,
    required this.formButtons,
    this.breakpoint = Breakpoint.expanded,
    this.windowSize
  });

  final String heading;
  final String? subHeading;
  final List<TextFormFieldData> textFields;
  final List<FormButtonData> formButtons;
  final Breakpoint breakpoint;
  final Size? windowSize;

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

    final double yPadding = 
      widget.breakpoint == Breakpoint.compact ? 10  
      : widget.breakpoint == Breakpoint.medium ? 20
      : 50;

    final double headingFontSize =
      widget.breakpoint == Breakpoint.compact 
      ? 30
      : 40;

    Widget formBody = Container( 
      color: Color.fromRGBO(243, 243, 243, 1),
      child: Padding(padding: EdgeInsets.only(top: yPadding, bottom: yPadding, left: 25, right: 25), child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.heading, style: 
              TextStyle(
                fontSize: headingFontSize,
                fontWeight: FontWeight.w600,
              )),
            Text(widget.subHeading ?? ""),
            SizedBox(height: yPadding),
            Form(
              key: _formKey,
              child: Column(spacing: 17, children: [...formField, ...formButtons])
            )
          ],
        ))
    );

    return widget.breakpoint == Breakpoint.compact || widget.breakpoint == Breakpoint.medium
      ? SizedBox(
        height: widget.windowSize!.height,
        width: widget.windowSize!.width,
        child: formBody
      )
      : Container(
        child: formBody,
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
