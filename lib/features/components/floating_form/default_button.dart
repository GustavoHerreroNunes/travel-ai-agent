import 'package:flutter/material.dart';

class DefaultButton extends StatefulWidget {
  final FormButtonData buttonData;
  final GlobalKey<FormState>? formKey;

  DefaultButton({required this.buttonData, this.formKey});

  @override
  _DefaultButtonState createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });

          bool isValid = true;
          if (widget.buttonData.validateForm ?? false) {
            isValid = widget.formKey!.currentState!.validate();
          }

          await widget.buttonData.onPressed(isValid);

          setState(() {
            _isLoading = false;
          });
        },
        style: ((widget.buttonData.type ?? ButtonType.submit) == ButtonType.submit)
            ? _submitStyle
            : _linkStyle,
        child: _isLoading
            ? CircularProgressIndicator(
              strokeWidth: 2,
              semanticsLabel: widget.buttonData.semanticLoadingLabel ?? "Loading...",
            )
            : Align(
                alignment: widget.buttonData.alignment ?? Alignment.center,
                child: Text(widget.buttonData.label),
              ),
      ),
    );
  }
}

ButtonStyle _submitStyle = TextButton.styleFrom(
  backgroundColor: Colors.deepOrange, 
  foregroundColor: Colors.black, 
  textStyle: TextStyle(
    fontWeight: FontWeight.w600,

  ),
);

ButtonStyle _linkStyle = TextButton.styleFrom(
  backgroundColor: Colors.transparent,
  foregroundColor: Colors.blue,
  textStyle: TextStyle(
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
  ),
);

class FormButtonData{
  const FormButtonData({
    required this.label,
    this.type,
    this.alignment,
    this.validateForm,
    this.semanticLoadingLabel,
    required this.onPressed,
  });

  final String label;
  final ButtonType? type;
  final AlignmentGeometry? alignment;
  final bool? validateForm;
  final Function(bool? isFormValid) onPressed;
  final String? semanticLoadingLabel;
}

enum ButtonType{
  submit,
  link
}
