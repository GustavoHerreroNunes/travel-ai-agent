import 'package:flutter/material.dart';

Widget getDefaultButton(FormButtonData buttonData, GlobalKey<FormState>? formKey){
  return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed:() {
          if(buttonData.validateForm ?? false){
            buttonData.onPressed(formKey!.currentState!.validate());
          }else{
            buttonData.onPressed(true);
          }
        },
        style: ((buttonData.type ?? ButtonType.submit) == ButtonType.submit) 
          ? _submitStyle 
          : _linkStyle,
        child: Align(
          alignment: buttonData.alignment ?? Alignment.center,
          child: Text(buttonData.label)
        ),
      )
    );
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
    required this.onPressed
  });

  final String label;
  final ButtonType? type;
  final AlignmentGeometry? alignment;
  final bool? validateForm;
  final Function(bool? isFormValid) onPressed;
}

enum ButtonType{
  submit,
  link
}
